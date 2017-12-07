library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ball is
port(   
        frame: in std_logic;
		clk, reset : in std_logic;
		pause : in std_logic;
		bar1_on, bar2_on : in std_logic;
		pixel_x, pixel_y : in std_logic_vector(9 downto 0);
		player1_score : out std_logic_vector(2 downto 0);
		player_scored : out std_logic;
		ball_on : out std_logic;
		ball_rgb : out std_logic_vector(2 downto 0)
	);
end ball;

architecture ball_arch of ball is
    type rom_type is array(0 to 7) of std_logic_vector(0 to 7);
    constant BALL_ROM: rom_type:= (
                                    "00111100",
                                    "01111110",
                                    "11111111",
                                    "11111111",
                                    "11111111",
                                    "11111111",
                                    "01111110",
                                    "00111100"
                                    );
	-- Signal used to control speed of ball and how
	signal speed_ball: std_logic;
	-- x, y coordinates (0,0 to (639, 479)
	signal scan1_x, scan1_y: unsigned(9 downto 0);
	-- screen dimensions
	constant MAX_X: integer := 640;
	constant MAX_Y_Top: integer := 50;
	constant MAX_Y_Bottom: integer := 430;
	constant BALL_SIZE: integer := 8;
	signal ball_x_left, ball_x_right: unsigned(9 downto 0);
	signal ball_Y_Top, ball_Y_Bottom: unsigned(9 downto 0);
	-- reg to track left and top boundary
	signal ball_x_reg, ball_x_next: unsigned(9 downto 0);
	signal ball_y_reg, ball_y_next: unsigned(9 downto 0);
	-- reg to track ball speed
	signal x_prime_reg, x_prime_next : unsigned(9 downto 0);
	signal y_prime_reg, y_prime_next : unsigned(9 downto 0);
	signal ball_rom_address, ball_rom_col: unsigned(2 downto 0);
    signal ball_rom_data: std_logic_vector(7 downto 0);
    signal ball_rom_bit: std_logic;
    signal sq_ball_on, rd_ball_on : std_logic;
    signal p2_score_reg, p2_score_next : unsigned(2 downto 0);
    signal scored : std_logic;
	-- ball movement can be pos or neg
	constant BALL_V_Positive: unsigned(9 downto 0) := to_unsigned(2,10);
	constant BALL_V_Negative: unsigned(9 downto 0) := unsigned(to_signed(-2,10));
	
begin
    process (clk, reset)
    begin
    if (reset = '1') then
    ball_x_reg <= "0100111011";
    ball_y_reg <= "0011110000";
    x_prime_reg <= "0000000010";
    y_prime_reg <= "0000000010";
    p2_score_reg <= to_unsigned(0,3);
    
    elsif (clk'event and clk = '1') then
        ball_x_reg <= ball_x_next;
        ball_y_reg <= ball_y_next;
        x_prime_reg <= x_prime_next;
        y_prime_reg <= y_prime_next;
        p2_score_reg <= p2_score_next;
    end if;
    end process;
	
	scan1_x <= unsigned(pixel_x);
	scan1_y <= unsigned(pixel_y);

	speed_ball <= '1' when (frame = '1')  and (pause = '0')else '0';
	ball_x_left <= ball_x_reg;
	ball_Y_Top <= ball_y_reg;
	ball_x_right <= ball_x_left + BALL_SIZE - 1;
	ball_Y_Bottom <= ball_Y_Top + BALL_SIZE - 1;
	-- pixel within square ball
	sq_ball_on <= '1' when (ball_x_left <= scan1_x) and (scan1_x <= ball_x_right) and (ball_Y_Top <= scan1_y) and (scan1_y <= ball_Y_Bottom) else  '0';
	ball_rom_address <= scan1_y(2 downto 0) - ball_Y_Top(2 downto 0);
	ball_rom_col <= scan1_x(2 downto 0) - ball_x_left(2 downto 0);
	-- Get row data
	ball_rom_data <= BALL_ROM(to_integer(ball_rom_address));
	-- Get column bit
	ball_rom_bit <= ball_rom_data(to_integer(ball_rom_col));
	
	-- Turn ball on only if within square and ROM bit is 1.
	rd_ball_on <= '1' when (sq_ball_on = '1') and (ball_rom_bit = '1') else '0';
	ball_rgb <= "100"; -- red
	ball_on <= rd_ball_on;
	
	-- Update the ball position.
	ball_x_next <= "0100111011" when scored = '1' else
						ball_x_reg + x_prime_reg when speed_ball = '1' else 
						ball_x_reg;
	ball_y_next <= ball_y_reg + y_prime_reg when speed_ball = '1' else 
						ball_y_reg;
						
	player_scored <= scored;

	process(x_prime_reg, y_prime_reg, ball_Y_Top, ball_x_left, ball_x_right, 
			  ball_Y_Top, ball_Y_Bottom, bar1_on, bar2_on, rd_ball_on, p2_score_reg)
	begin
		x_prime_next <= x_prime_reg;
		y_prime_next <= y_prime_reg;
		p2_score_next <= p2_score_reg;
		scored <= '0';
			
		-- ball reached top, make offset positive
		if ( ball_Y_Top < MAX_Y_Top - 1 ) then
			y_prime_next <= BALL_V_Positive;
		-- reached bottom, make negative
		elsif (ball_Y_Bottom > (MAX_Y_Bottom - 1)) then
			y_prime_next <= BALL_V_Negative;
		-- Hit left paddle
		elsif(bar1_on = '1' and rd_ball_on = '1') then
			x_prime_next <= BALL_V_Positive;
		-- Hit right paddle
		elsif(bar2_on = '1' and rd_ball_on = '1') then
			x_prime_next <= BALL_V_Negative;
		-- Player  scored
		elsif(ball_x_left < 8) then
			p2_score_next <= p2_score_reg + 1;
			scored <= '1';
			x_prime_next <= BALL_V_Positive;
		elsif(ball_x_right > (MAX_X - 8)) then
			scored <= '1';
			x_prime_next <= BALL_V_Negative;
		end if;

	end process;
	
	player1_score <= std_logic_vector(p2_score_next);
	
end ball_arch;