library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity left_bar is
port(
		clk, reset : in std_logic;
		live_distance : in std_logic_vector(11 downto 0);
		pause : in std_logic;
		location : in std_logic_vector(9 downto 0);
		left_bar_on : out std_logic;
		pixel_x, pixel_y : in std_logic_vector(9 downto 0);
		left_bar_redgreenblue : out std_logic_vector(2 downto 0);
		frame: in std_logic
	);
end left_bar;

architecture left_bar_arch of left_bar is
    signal h_up_down: unsigned(8 downto 0);
    signal refr_tick: std_logic;
	signal reg_up_down: unsigned (8 downto 0);
	-- x, y coordinates (0,0 to (639, 479)
	signal pix_x, pix_y: unsigned(9 downto 0);
	
	-- screen dimensions
	constant MAX_X: integer := 640;
	constant MAX_Y_T: integer := 50;
	constant MAX_Y_B: integer := 430;
	
	-- left_bar left, left, top, bottom and height left &
	-- right are constant. top & bottom are signals to
	-- allow movement. bar_y_t driven by reg below.
	signal bar_x_l: unsigned(9 downto 0);
	signal bar_x_r: unsigned(9 downto 0);
	signal bar_y_t, bar_y_b: unsigned(9 downto 0);
	constant BAR_Y_SIZE: integer := 100;
	
	-- reg to track top boundary (x position is fixed)
	signal bar_y_reg, bar_y_next: unsigned(9 downto 0):= "0011110000";
	
	-- bar moving velocity when a button is pressed
	-- the amount the bar is moved.
	constant BAR_V: integer:= 4;

begin
    reg_up_down <= unsigned(live_distance(11 downto 3));

    h_up_down<= to_unsigned(330,9) when ( reg_up_down < 225) else to_unsigned(50,9) when ( reg_up_down >505) else resize(555 - ('0'& reg_up_down), 9);
	process (clk, reset)
	begin
		if (reset = '1') then
			bar_y_reg <= "0011110000";
		elsif (clk'event and clk = '1') then
			bar_y_reg <= bar_y_next;
		end if;
	end process;
--distances <= unsigned(live_distance);
	bar_x_l <= unsigned(location);
	bar_x_r <= unsigned(location) + 3;
	
	pix_x <= unsigned(pixel_x);
	pix_y <= unsigned(pixel_y);
	
	-- refr_tick: 1-clock tick asserted at start of v_sync,
	-- e.g., when the screen is refreshed -- speed is 60 Hz
	refr_tick <= '1' when (frame = '1') and (pause = '0') else 
					 '0';
					 
	-- pixel within left_bar
	bar_y_t <= bar_y_reg;
	bar_y_b <= bar_y_t + BAR_Y_SIZE - 1;
	
	left_bar_on <= '1' when (bar_x_l <= pix_x) and (pix_x <= bar_x_r) and (bar_y_t <= pix_y) and (pix_y <= bar_y_b)
					else '0';
					 
	left_bar_redgreenblue <= "111";
	
	-- Process bar movement requests
	process( bar_y_reg, bar_y_b, bar_y_t, refr_tick, h_up_down  )
	begin
		if ( refr_tick = '1' ) then
		 bar_y_next <= ('0' & h_up_down);
		--bar move when distance changes	
		end if;
	end process;
		
end left_bar_arch;
