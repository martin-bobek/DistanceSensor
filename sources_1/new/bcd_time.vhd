library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;
use work.records.all;

entity bcd_time is
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        frame: in std_logic;
        up: in std_logic;
        down: in std_logic;
        live: out time_v;
        row: in std_logic_vector(width(10) - 1 downto 0);
        table: out time_v;
        table_offset: out std_logic_vector(9 downto 0);
        hold: out std_logic
    );
end;

architecture behavioural of bcd_time is
    constant scroll_period: positive := 10;
    signal scroll_counter: unsigned(width(scroll_period - 1) - 1 downto 0);

    type time_array is array(0 to 9) of time_v;
    signal times: time_array;
    
    signal table_top, current, increment, capture, decrement, offset, next_offset: time_v;
    
    signal update_pend, update_latch: std_logic;
    signal up_pend, up_latch: std_logic;
    signal down_pend, down_latch: std_logic;
    signal frame_pend, frame_latch: std_logic;
    
    type update_type is (set_dir, inc_current, inc_offset, wait_table_top);
    signal update_state: update_type;
    signal up_state: update_type;
    signal down_state: update_type;
    signal offset_dec: std_logic;
    
    type handler_type is (update_h, up_h, down_h, frame_h);
    signal handler: handler_type;
    signal handler_running: std_logic;
    
    signal fill_row: unsigned(width(10) - 1 downto 0);
    constant row_end: unsigned(width(10) - 1 downto 0) := to_unsigned(10, width(10));
begin
    table <= times(to_integer(unsigned(row)));
    hold <= update_pend or up_pend or down_pend;

    inc_cur: entity work.time_inc_dec
        port map(
            decrement => '0',
            input => current,
            output => increment
        );
        
    dec_cap: entity work.time_inc_dec
        port map(
            decrement => '1',
            input => capture,
            output => decrement
        );
        
    off_update: entity work.time_inc_dec
        port map(
            decrement => offset_dec,
            input => offset,
            output => next_offset
        );
        
    table_bcd: entity work.time_diff
        port map(
            a => current,
            b => offset,
            y => table_top
        );
        
    mem_offset: entity work.bcd_to_bin
        generic map(
            bin_width => 10
        )
        port map(
            bcd => offset,
            binary => table_offset
        );
    
    update_pend <= update or update_latch;
    up_pend <= (up and frame) or up_latch;
    down_pend <= (not (up and frame)) and ((down and frame) or down_latch);
    frame_pend <= frame or frame_latch;
    process(clk, reset) 
        variable current_handler: handler_type;
        variable running: std_logic;
    begin
        if (reset = '1') then
            update_latch <= '0';
            up_latch <= '0';
            down_latch <= '0';
            scroll_counter <= (others => '0');
            
            update_state <= inc_current;
            up_state <= set_dir;
            down_state <= set_dir;
            handler_running <= '0';
            handler <= update_h;
            current <= ("000", "0000", "000", "1001");
            offset <= (others => (others => '0'));
            
            fill_row <= row_end;
            capture <= (others => (others => '0'));
            live <= (others => (others => '0'));
            times <= (others => (others => (others => '0')));
        elsif rising_edge(clk) then
            if (update = '1') then
                update_latch <= '1';
            end if;
            
            if (frame = '1') then
                frame_latch <= '1';
            
                scroll_counter <= scroll_counter + 1;
                if (scroll_counter = scroll_period - 1) then
                    scroll_counter <= (others => '0');
                    
                    if (up = '1') then
                        up_latch <= '1';
                    elsif (down = '1') then
                        down_latch <= '1';
                    end if;
                end if;
            end if;
            
            if (handler_running = '1') then
                running := '1';
                current_handler := handler;
            else
                running := '1';
                if (update_pend = '1') then
                    current_handler := update_h; 
                elsif (up_pend = '1') then
                    current_handler := up_h;
                elsif (down_pend = '1') then
                    current_handler := down_h;
                elsif (frame_pend = '1') then
                    current_handler := frame_h;
                else
                    running := '0';
                end if;
                
                handler <= current_handler;
                handler_running <= running; 
            end if;
            
            if (running = '1') then
                case current_handler is
                    when update_h => 
                        case update_state is
                            when inc_current =>
                                current <= increment;
                                offset_dec <= '0';
                                if (offset = ("000", "0000", "000", "0000")) or (offset = ("000", "1001", "101", "0000")) then
                                    handler_running <= '0';
                                    update_latch <= '0';
                                    update_state <= inc_current;
                                else
                                    update_state <= inc_offset;
                                end if;
                            when inc_offset =>
                                offset <= next_offset;
                                update_state <= wait_table_top;
                            when wait_table_top =>
                                handler_running <= '0';
                                update_latch <= '0';
                                update_state <= inc_current;
                            when others =>
                        end case;
                    when up_h => 
                        case up_state is
                            when set_dir =>
                                offset_dec <= '1';
                                if (offset = ("000", "0000", "000", "0000")) then
                                    handler_running <= '0';
                                    up_latch <= '0';
                                    up_state <= set_dir;
                                else
                                    up_state <= inc_offset;
                                end if;
                            when inc_offset =>
                                offset <= next_offset;
                                up_state <= wait_table_top;
                            when wait_table_top =>
                                handler_running <= '0';
                                up_latch <= '0';
                                up_state <= set_dir;
                            when others =>
                        end case;
                    when down_h =>
                        case down_state is
                            when set_dir =>
                                offset_dec <= '0';
                                if (offset = ("000", "1001", "101", "0000")) then
                                    handler_running <= '0';
                                    down_latch <= '0';
                                    down_state <= set_dir;
                                else
                                    down_state <= inc_offset;
                                end if;
                            when inc_offset =>
                                offset <= next_offset;
                                down_state <= wait_table_top;
                            when wait_table_top =>
                                handler_running <= '0';
                                down_latch <= '0';
                                down_state <= set_dir;
                            when others =>
                        end case;
                    when frame_h => 
                        fill_row <= (others => '0');
                        live <= current;
                        capture <= table_top;
                        handler_running <= '0';
                        frame_latch <= '0';
                end case;
            end if;
            
            if (fill_row < row_end) then
                fill_row <= fill_row + 1;
                times(to_integer(fill_row)) <= decrement;
                capture <= decrement;
            end if;
        end if;
    end process;
end;
