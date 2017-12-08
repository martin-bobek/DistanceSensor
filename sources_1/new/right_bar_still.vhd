library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity right_bar_still is
port(
		clk, reset : in std_logic;
		pause : in std_logic;
		location : in std_logic_vector(9 downto 0);
		right_bar_on : out std_logic;
		pixel_x, pixel_y : in std_logic_vector(9 downto 0);
		right_bar_redgreenblue : out std_logic_vector(2 downto 0)
	);
end right_bar_still;

architecture right_bar_arch_still of right_bar_still is
	signal tick: std_logic;
	signal scan_x, scan_y: unsigned(9 downto 0);
	constant MAX_X: integer := 640;
	constant MAX_Y_T: integer := 50;
	constant MAX_Y_B: integer := 430;
	signal bar_x_l: unsigned(9 downto 0);
	signal bar_x_r: unsigned(9 downto 0);
	signal bar_y_t, bar_y_b: unsigned(9 downto 0);
	constant BAR_Y_SIZE: integer := 380;	
	signal bar_y_reg, bar_y_next: unsigned(9 downto 0):= "0000110010";
	constant BAR_V: integer:= 4;

begin
    scan_x <= unsigned(pixel_x);
    scan_y <= unsigned(pixel_y);
    bar_x_l <= unsigned(location);
    bar_x_r <= unsigned(location) + 3;
	process (clk, reset)
	begin
		if (reset = '1') then
			bar_y_reg <= "0000110010";
		elsif (clk'event and clk = '1') then
			bar_y_reg <= bar_y_next;
		end if;
	end process;
	tick <= '1' when (scan_y = 481) and (scan_x = 0) and (pause = '0') else  '0';				 
	bar_y_t <= bar_y_reg;
	bar_y_b <= bar_y_t + BAR_Y_SIZE - 1;
	right_bar_on <= '1' when (bar_x_l <= scan_x) and (scan_x <= bar_x_r) and 
							 (bar_y_t <= scan_y) and (scan_y<= bar_y_b) else  '0';
	right_bar_redgreenblue <= "111";

end right_bar_arch_still;
