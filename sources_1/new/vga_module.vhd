library ieee;
use ieee.std_logic_1164.all;

entity vga_module is
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        
        btn_u: in std_logic;
        btn_d: in std_logic;
        btn_r: in std_logic;
        sw1: in std_logic;
        
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
    signal scan_x: std_logic_vector(9 downto 0);
    signal scan_y: std_logic_vector(8 downto 0);
    signal table_red, table_green, table_blue: std_logic_vector(3 downto 0);
    
    signal i_hsync: std_logic;
    
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
            scan_x => scan_x,
            scan_y => scan_y
        );
        
    table: entity work.table_display
        port map(
            clk => clk,
            reset => reset,
            update => update,
            frame => frame,
            inches => sw1,
            
            top => btn_r,
            up => btn_u,
            down => btn_d,
            
            mem_read => mem_read,
            address => address,
            distance => distance,
            mem_ready => mem_ready,
            live_distance => live_distance,
            
            scan_x => scan_x,
            scan_y => scan_y,
            pixel_clk => pixel_clk,
            hsync => i_hsync, 
            blank => blank,
            
            red => table_red,
            green => table_green,
            blue => table_blue
        );
    
    process(clk, reset) begin
        if (reset = '1') then
            red <= (others => '0');
            green <= (others => '0');
            blue <= (others => '0');
        elsif rising_edge(clk) and (pixel_clk = '1') then
            red <= table_red;
            green <= table_green;
            blue <= table_blue;
        end if;
    end process;
end;