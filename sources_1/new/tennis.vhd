library ieee;
use ieee.std_logic_1164.all;

entity tennis is
    port(
        clk: in std_logic;
        reset: in std_logic;
        sys_pause: in std_logic;
        continue: in std_logic;
        
        live_distance: in std_logic_vector(11 downto 0);
        
        blank: in std_logic;
        frame: in std_logic;
        scan_x: in std_logic_vector(9 downto 0);
        scan_y: in std_logic_vector(8 downto 0);
        
        anodes: out std_logic_vector(3 downto 0);
        cathodes: out std_logic_vector(7 downto 0);
        rgb: out std_logic_vector(2 downto 0)
    );
end;

architecture behavioural of tennis is
    constant player2_controls: std_logic_vector(1 downto 0) := "00";
    signal ball_on, bar1_on, bar2_on, background_on : std_logic; 
    signal bar1_rgb, bar2_rgb, ball_rgb, background_rgb : std_logic_vector(2 downto 0);
    signal player1_score, player2_score : std_logic_vector(2 downto 0);
    signal pause, state_pause : std_logic;
    signal player_scored : std_logic;
    type states_type is (spause, splay, restart_game);
    signal next_state : states_type;
begin
    pause <= state_pause or sys_pause ;
    
    process(clk, reset, player1_score, player2_score) is
    begin
        if(reset = '1') then
            next_state <= spause;
            state_pause <= '1';
        elsif(rising_edge(clk)) then
            case next_state is
                when spause =>
                    state_pause <= '1';
                    if(continue = '1') then
                        next_state <= splay;
                    else
                        next_state <= spause;
                    end if;
                when splay =>
                    state_pause <= '0';
                    if(player_scored = '1') then
                        if(player1_score = "111") then
                            next_state <= restart_game;

                        else
                            next_state <= spause;
                        end if;
                    else
                        next_state <= splay;
                    end if;
                
                when restart_game => 
                     state_pause <= '0';
                     next_state  <= splay;
            end case;
        end if;
    end process;
    
    
                
    background_vga: entity work.background(background_arch)
    port map(background_on => background_on,
                pixel_x => scan_x,
                pixel_y(9) => '0',
                pixel_y(8 downto 0) => scan_y,
                background_redgreenblue => background_rgb
                );
    
    sevenSegControl_unit: entity work.sevenseg_control(Behavioral)
    port map(   clk => clk,
                reset => reset,
                digit1 => player1_score,
                cathodes => cathodes,
                anodes => anodes
                );
            
    
    bouncing_ball: entity work.ball(ball_arch)
    port map(clk => clk,
                reset => reset,
                pause => pause,
                bar1_on => bar1_on,
                player1_score => player1_score,
                player_scored => player_scored,
                bar2_on => bar2_on,
                ball_on => ball_on,
                pixel_x => std_logic_vector(scan_x),
                pixel_y(9) => '0',
                pixel_y(8 downto 0) => scan_y,
                ball_rgb => ball_rgb,
                frame => frame
                );
        
    left_bar: entity work.left_bar(left_bar_arch)
    port map(clk => clk,
                reset => reset,
                pause => pause,
                live_distance => live_distance,
                location => "0000110010", 
                left_bar_on => bar1_on, 
                pixel_x => std_logic_vector(scan_x),
                pixel_y(9) => '0',
                pixel_y(8 downto 0) => scan_y,
                left_bar_redgreenblue => bar1_rgb,
                frame => frame
                );
    
    -- instantiate pixel generation circuit
    right_bar_still: entity work.right_bar_still(right_bar_arch_still)
    port map(clk => clk,
                reset => reset,
                pause => pause,
                location => "1001011000", 
                right_bar_on => bar2_on, 
                pixel_x => std_logic_vector(scan_x),
                pixel_y(9) => '0',
                pixel_y(8 downto 0) => scan_y,
                right_bar_redgreenblue => bar2_rgb
                );    
             
             
    process(bar1_rgb, bar2_rgb, ball_rgb, background_rgb, bar1_on, bar2_on, ball_on, background_on, blank) begin
        if(blank = '0') then
            if(bar1_on = '1') then
                rgb <= bar1_rgb;
            elsif(bar2_on = '1') then
                rgb <= bar2_rgb;
            elsif(ball_on = '1') then
                rgb <= ball_rgb;
            else
                rgb <= background_rgb;
            end if;
        else
            rgb <= "000";
        end if;
    end process;   

end;
