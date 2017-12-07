library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity background is
port(
		pixel_x, pixel_y : in std_logic_vector(9 downto 0);
		background_on : out std_logic;
		background_redgreenblue : out std_logic_vector(2 downto 0)
	);
end background;

architecture background_arch of background is
	signal scan1_x: unsigned(9 downto 0);
	signal scan1_y: unsigned(9 downto 0);
	constant MAX_X: integer := 640;
	constant MAX_Y: integer := 480;
	constant UPPER_WALL_Y_Top: integer := 40;
	constant UPPER_WALL_Y_Bottom: integer := 50;
	constant LOWER_WALL_Y_Top: integer := 430;
	constant LOWER_WALL_Y_Bottom: integer := 440;	
	signal upper_wall_on, lower_wall_on, wall_on : std_logic;
	signal wall_redgreenblue, initials_redgreenblue : std_logic_vector(2 downto 0);


begin	
	scan1_x <= unsigned(pixel_x);
	scan1_y <= unsigned(pixel_y);
	upper_wall_on <= '1' when (UPPER_WALL_Y_Top <= scan1_y) and (scan1_y <= UPPER_WALL_Y_Bottom) else '0';
	lower_wall_on <= '1' when (LOWER_WALL_Y_Top <= scan1_y) and (scan1_y <= LOWER_WALL_Y_Bottom) else '0';
	wall_on <= upper_wall_on or lower_wall_on;
	background_on <= wall_on;
	wall_redgreenblue <= "111"; -- white		
	background_redgreenblue <= wall_redgreenblue when wall_on = '1'else "010";
	
end background_arch;