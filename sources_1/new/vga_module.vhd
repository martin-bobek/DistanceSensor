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
        tennis: in std_logic;
        sw2: in std_logic;
        
        mem_read: out std_logic;
        address: out std_logic_vector(9 downto 0);
        distance: in std_logic_vector(11 downto 0);
        mem_ready: in std_logic;
        
        live_distance: in std_logic_vector(11 downto 0);
        
        red: out std_logic_vector(3 downto 0);
        green: out std_logic_vector(3 downto 0);
        blue: out std_logic_vector(3 downto 0);
        hsync: out std_logic;
        vsync: out std_logic;
        anodes: out std_logic_vector(3 downto 0);
        cathodes: out std_logic_vector(7 downto 0)
    );
end;

architecture behavioural of vga_module is
    signal sys_pause: std_logic;
    signal pixel_clk: std_logic;
    signal frame, blank: std_logic;
    signal scan_x: std_logic_vector(9 downto 0);
    signal scan_y: std_logic_vector(8 downto 0);
    signal table_red, table_green, table_blue: std_logic_vector(3 downto 0);
    signal tennis_rgb: std_logic_vector(2 downto 0);
    
    signal i_hsync: std_logic;
    
begin
    sys_pause<= sw2 or not tennis; 
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
            inches => sw2,
            
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
    
    tennis_game: entity work.tennis
        port map(
            clk => clk,
            reset => reset,
            sys_pause => sys_pause ,
            continue => btn_r,
            
            live_distance => live_distance,
            
            blank => blank,
            frame => frame,
            scan_x => scan_x,
            scan_y => scan_y,
            
            anodes => anodes,
            cathodes => cathodes,
            rgb => tennis_rgb
        );
    
    process(clk, reset) begin
        if (reset = '1') then
            red <= (others => '0');
            green <= (others => '0');
            blue <= (others => '0');
        elsif rising_edge(clk) and (pixel_clk = '1') then
            if (tennis = '1') then
                red <= tennis_rgb(2) & tennis_rgb(2) & tennis_rgb(2) & tennis_rgb(2);
                green <= tennis_rgb(1) & tennis_rgb(1) & tennis_rgb(1) & tennis_rgb(1);
                blue <= tennis_rgb(0) & tennis_rgb(0) & tennis_rgb(0) & tennis_rgb(0);
            else
                red <= table_red;
                green <= table_green;
                blue <= table_blue;
            end if;
        end if;
    end process;
end;