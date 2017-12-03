library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity vga_module is
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        
        mem_read: out std_logic;
        address: out std_logic_vector(9 downto 0);
        distance: in std_logic_vector(11 downto 0);
        mem_ready: in std_logic;
        
        red: out std_logic_vector(3 downto 0);
        green: out std_logic_vector(3 downto 0);
        blue: out std_logic_vector(3 downto 0);
        hsync: out std_logic;
        vsync: out std_logic
    );
end;

architecture behavioural of vga_module is
    component sync_signal_generator is
        port(
            clk: in std_logic;
            reset: in std_logic;
            pixel_clk: out std_logic;
            frame: out std_logic;
            blank: out std_logic;
            hor_sync: out std_logic;
            ver_sync: out std_logic;
            scan_x: out std_logic_vector(9 downto 0);
            scan_y: out std_logic_vector(8 downto 0)
        );
    end component;
    
    component inch_bcd is
        port(
            clk: in std_logic;
            reset: in std_logic;
            mem_ready: in std_logic;
            distance: in std_logic_vector(11 downto 0);
            tens: out std_logic_vector(0 downto 0);
            ones: out std_logic_vector(3 downto 0);
            tenths: out std_logic_vector(3 downto 0);
            hundredths: out std_logic_vector(3 downto 0);
            ready: out std_logic  
        );
    end component;
    
    component char_bits is
        port(
            clk: in std_logic;
            reset: in std_logic;
            bcd: in std_logic_vector(3 downto 0);
            line_num: in std_logic_vector(width(34) - 1 downto 0);
            bitline: out std_logic_vector(0 to 25)
        );
    end component;
    
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
    
    type cell_element is (start, border, top_pad, char, bottom_pad, complete);
    type horizontal_element is (h_blank, h_char); 
    signal cell_state: cell_element;
    signal hor_state: horizontal_element;
    signal element_y: unsigned(width(35) - 1 downto 0);
    signal c_hsync, i_hsync: std_logic;
    signal pixel_index: unsigned(width(25) - 1 downto 0);
    
    signal black: std_logic;
begin
    hsync <= i_hsync;

    sync_gen: sync_signal_generator
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
    
    tens_in(3 downto 1) <= "000";
    bcd_inches: inch_bcd
        port map(
            clk => clk,
            reset => reset,
            mem_ready => mem_ready,
            distance => distance,
            tens => tens_in(0 downto 0),
            ones => ones_in,
            tenths => tenths_in,
            hundredths => hundredths_in,
            ready => in_ready
        );
    
    characters: char_bits
        port map(
            clk => clk,
            reset => reset,
            bcd => bcd,
            line_num => std_logic_vector(element_y),
            bitline => bitline
        );
    
    address <= std_logic_vector(resize(fill_index, 10));
    process(clk, reset) begin
        if (reset = '1') then
            fill_index <= fill_end;
            mem_read <= '0';
            tens_table <= (others => (others => '0'));
            ones_table <= (others => (others => '0'));
            tenths_table <= (others => (others => '0'));
            hundredths_table <= (others => (others => '0'));
        elsif rising_edge(clk) then
            mem_read <= '0';
            if (frame = '1') then
                fill_index <= (others => '0');
                mem_read <= '1';
            end if;
            
            if (in_ready = '1') and (fill_index /= fill_end) then
                tens_table(to_integer(fill_index)) <= tens_in;
                ones_table(to_integer(fill_index)) <= ones_in;
                tenths_table(to_integer(fill_index)) <= tenths_in;
                hundredths_table(to_integer(fill_index)) <= hundredths_in;
                fill_index <= fill_index + 1;
                mem_read <= '1';
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
            
--            if (frame = '1') then
--                cell_state <= start;
--                print_index <= (others => '0');
--            end if;
            
            c_hsync <= i_hsync;  
        end if;
    end process;
    
    process(clk, reset) begin
        if (reset = '1') then
            hor_state <= h_blank;
            black <= '0';
            bcd <= (others => '0');
            pixel_index <= (others => '0');
        elsif rising_edge(clk) and (pixel_clk = '1') then
            black <= '0';
            
            case cell_state is
                when border =>
                    if (scan_x >= 2) and (scan_x <= 636) then
                        black <= '1';
                    end if;
                when top_pad | bottom_pad => 
                    if (scan_x = 2) or (scan_x = 636) then
                        black <= '1';
                    end if;
                when char =>
                    if (hor_state = h_char) then
                        pixel_index <= pixel_index + 1;
                        black <= bitline(to_integer(pixel_index));
                        if (pixel_index = 25) then
                            hor_state <= h_blank;
                            pixel_index <= (others => '0');
                        end if;
                    end if;
                
                    if (scan_x = 2) then
                        black <= '1';
                    elsif (scan_x = 100) then
                        hor_state <= h_char;
                        bcd <= tens_table(to_integer(print_index));
                    elsif (scan_x = 130) then
                        hor_state <= h_char;
                        bcd <= ones_table(to_integer(print_index));
                    elsif (scan_x = 160) then
                        hor_state <= h_char;
                        bcd <= tenths_table(to_integer(print_index));
                    elsif (scan_x = 190) then
                        hor_state <= h_char;
                        bcd <= hundredths_table(to_integer(print_index));
                    elsif (scan_x = 636) then
                        black <= '1';
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