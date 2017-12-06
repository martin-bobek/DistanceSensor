library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;
use work.records.all;

entity vga_module is
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        
        up: in std_logic;
        down: in std_logic;
        inches: in std_logic;
        
        mem_read: out std_logic;
        address: out std_logic_vector(9 downto 0);
        distance: in std_logic_vector(11 downto 0);
        mem_ready: in std_logic;
        
        live_distance: in std_logic_vector(11 downto 0);
        
        red: out std_logic_vector(3 downto 0);
        green: out std_logic_vector(3 downto 0);
        blue: out std_logic_vector(3 downto 0);
        hsync: out std_logic;
        vsync: out std_logic
    );
end;

architecture behavioural of vga_module is
    signal pixel_clk: std_logic;
    signal frame, blank: std_logic;
    signal scan_x: unsigned(9 downto 0);
    signal scan_y: unsigned(8 downto 0);
    signal next_red, next_green, next_blue: std_logic_vector(3 downto 0);
    
    signal tens_in, ones_in, tenths_in, hundredths_in: std_logic_vector(3 downto 0);
    signal in_ready: std_logic;
    
    type bcd_entries is array(0 to 9) of std_logic_vector(3 downto 0);
    signal tens_table, ones_table, tenths_table, hundredths_table: bcd_entries;
    constant fill_end: unsigned(width(10) - 1 downto 0) := to_unsigned(10, width(10));
    signal fill_index, print_index: unsigned(width(10) - 1 downto 0);
    signal bcd: std_logic_vector(3 downto 0);
    signal bitline: std_logic_vector(0 to 25);
    
    signal live_t, table_t: time_v;
    
    signal offset: unsigned(9 downto 0);
    signal hold: std_logic;
    signal frame_latch, frame_pend: std_logic;
    
    signal live_tens, live_ones, live_tenths, live_hundredths: std_logic_vector(3 downto 0);
    signal conv_distance: std_logic_vector(11 downto 0);
    
    type cell_element is (start, border, top_pad, char, bottom_pad);
    type horizontal_element is (h_blank, h_char); 
    signal cell_state: cell_element;
    signal hor_state: horizontal_element;
    signal element_y: unsigned(width(35) - 1 downto 0);
    signal c_hsync, i_hsync: std_logic;
    signal pixel_index: unsigned(width(25) - 1 downto 0);
    
    signal black: std_logic;
begin
    hsync <= i_hsync;

    sync_gen: entity work.sync_signal_generator
        port map(
            clk => clk,
            reset => reset,
            pixel_clk => pixel_clk,
            frame => frame,
            blank => blank,
            hor_sync => i_hsync,
            ver_sync => vsync,
            unsigned(scan_x) => scan_x,
            unsigned(scan_y) => scan_y
        );
    
    conv_distance <= live_distance when (fill_index = fill_end) else distance;
    bcd_inches: entity work.unit_bcd
        port map(
            clk => clk,
            reset => reset,
            mem_ready => mem_ready,
            inches => inches,
            distance => conv_distance,
            tens => tens_in,
            ones => ones_in,
            tenths => tenths_in,
            hundredths => hundredths_in,
            ready => in_ready
        );
    
    characters: entity work.char_bits
        port map(
            clk => clk,
            reset => reset,
            bcd => bcd,
            line_num => std_logic_vector(element_y),
            bitline => bitline
        );
    
    times: entity work.bcd_time
        port map(
            clk => clk,
            reset => reset,
            update => update,
            frame => frame,
            up => up,
            down => down,
            live => live_t,
            row => std_logic_vector(print_index),
            table => table_t,
            unsigned(table_offset) => offset,
            hold => hold
        );
    
    address <= std_logic_vector(fill_index + offset);
    frame_pend <= frame or frame_latch;
    process(clk, reset) begin
        if (reset = '1') then
            fill_index <= fill_end;
            mem_read <= '0';
            live_tens <= (others => '0');
            live_ones <= (others => '0');
            live_tenths <= (others => '0');
            live_hundredths <= (others => '0');
            tens_table <= (others => (others => '0'));
            ones_table <= (others => (others => '0'));
            tenths_table <= (others => (others => '0'));
            hundredths_table <= (others => (others => '0'));
            frame_latch <= '0';
        elsif rising_edge(clk) then
            mem_read <= '0';
            
            if (frame = '1') then
                frame_latch <= '1';
            end if;
            
            if (hold = '1') then
                fill_index <= fill_end; 
            elsif (frame_pend = '1') and (fill_index = fill_end) then
                live_tens <= tens_in;
                live_ones <= ones_in;
                live_tenths <= tenths_in;
                live_hundredths <= hundredths_in;
                fill_index <= (others => '0');
                mem_read <= '1';
            elsif (in_ready = '1') and (fill_index /= fill_end) then
                tens_table(to_integer(fill_index)) <= tens_in;
                ones_table(to_integer(fill_index)) <= ones_in;
                tenths_table(to_integer(fill_index)) <= tenths_in;
                hundredths_table(to_integer(fill_index)) <= hundredths_in;
                fill_index <= fill_index + 1;
                if (fill_index = fill_end - 1) then
                    frame_latch <= '0';
                else
                    mem_read <= '1';
                end if;
            end if;
        end if;
    end process;
    
    process(clk, reset) begin
        if (reset = '1') then
            print_index <= (others => '0');
            cell_state <= start;
            c_hsync <= '0';
            element_y <= (others => '0');
        elsif rising_edge(clk) then
            if (i_hsync = '0') and (c_hsync = '1') then
                case cell_state is
                    when start =>
                        if (scan_y = 3) then
                            cell_state <= border;
                            print_index <= (others => '0');
                        end if;
                    when border =>
                        element_y <= (others => '0');
                        cell_state <= top_pad;
                        if (print_index = 10) then
                            cell_state <= start;
                        end if;
                    when top_pad =>
                        element_y <= element_y + 1;
                        if (element_y = 4) then
                            element_y <= (others => '0');
                            cell_state <= char;
                        end if;
                    when char =>
                        element_y <= element_y + 1;
                        if (element_y = 35) then
                            element_y <= (others => '0');
                            cell_state <= bottom_pad;
                        end if;
                    when bottom_pad =>                    
                        element_y <= element_y + 1;
                        if (element_y = 3) then
                            print_index <= print_index + 1;
                            cell_state <= border;
                        end if;
                    when others => 
                end case;
            end if;
            
            c_hsync <= i_hsync;  
        end if;
    end process;
    
    process(clk, reset) 
        variable new_char: boolean;
    begin
        if (reset = '1') then
            hor_state <= h_blank;
            black <= '0';
            bcd <= (others => '0');
            pixel_index <= (others => '0');
        elsif rising_edge(clk) and (pixel_clk = '1') then
            black <= '0';
            
            case cell_state is
                when border =>
                    if (scan_x >= 2) and (scan_x <= 330) then
                        black <= '1';
                    end if;
                when top_pad | bottom_pad =>
                    if (scan_x = 2) or (scan_x = 165) or (scan_x = 330) then
                        black <= '1';
                    end if;
                when char =>
                    if (hor_state = h_char) then
                        pixel_index <= pixel_index + 1;
                        black <= bitline(to_integer(pixel_index));
                        if (pixel_index = 25) then
                            hor_state <= h_blank;
                        end if;
                    end if;
                    
                    if (scan_x = 2) or (scan_x = 165) or (scan_x = 330) then
                        black <= '1';
                    end if;
                
                    new_char := true;
                    case to_integer(scan_x) is
                        when 15 => bcd <= '0' & table_t.ten_min;
                        when 45 => bcd <= table_t.min;
                        when 75 => bcd <= "1011";
                        when 90 => bcd <= '0' & table_t.ten_sec;
                        when 120 => bcd <= table_t.sec;
                        when 180 => bcd <= tens_table(to_integer(print_index));
                        when 210 => bcd <= ones_table(to_integer(print_index));
                        when 240 => bcd <= "1010";
                        when 255 => bcd <= tenths_table(to_integer(print_index));
                        when 285 => bcd <= hundredths_table(to_integer(print_index));
                        when others => new_char := false;
                    end case;
                    if (new_char) then
                        hor_state <= h_char;
                        pixel_index <= (others => '0');
                    end if;
                    
                    if (print_index = 3) then
                        new_char := true;
                        case to_integer(scan_x) is
                            when 415 => bcd <= '0' & live_t.ten_min;
                            when 445 => bcd <= live_t.min;
                            when 475 => bcd <= "1011";
                            when 490 => bcd <= '0' & live_t.ten_sec;
                            when 520 => bcd <= live_t.sec;
                            when others => new_char := false;
                        end case;
                        if (new_char) then
                            hor_state <= h_char;
                            pixel_index <= (others => '0');
                        end if;
                    elsif (print_index = 5) then
                        new_char := true;
                        case to_integer(scan_x) is
                            when 415 => bcd <= live_tens;
                            when 445 => bcd <= live_ones;
                            when 475 => bcd <= "1010";
                            when 490 => bcd <= live_tenths;
                            when 520 => bcd <= live_hundredths;
                            when others => new_char := false;
                        end case;
                        if (new_char) then
                            hor_state <= h_char;
                            pixel_index <= (others => '0');
                        end if;
                    end if;
                when others =>
            end case;
        end if;
    end process;
    
    process(black, blank) begin
        if (black = '1') or (blank = '1') then
            next_red <= (others => '0');
            next_green <= (others => '0');
            next_blue <= (others => '0');
        else
            next_red <= (others => '1');
            next_green <= (others => '1');
            next_blue <= (others => '1');
        end if;
    end process;
    
    process(clk, reset) begin
        if (reset = '1') then
            red <= (others => '0');
            green <= (others => '0');
            blue <= (others => '0');
        elsif rising_edge(clk) and (pixel_clk = '1') then
            red <= next_red;
            green <= next_green;
            blue <= next_blue;
        end if;
    end process;
end;