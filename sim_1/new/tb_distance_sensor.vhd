----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2017 11:08:06 AM
-- Design Name: 
-- Module Name: tb_distance_sensor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_distance_sensor is end;

architecture Behavioral of tb_distance_sensor is

    component distance_sensor
        port(
            clk: in std_logic;
            buttons: in std_logic_vector(4 downto 0);
            switches: in std_logic_vector(1 downto 0);
            input: in std_logic;
            feedback: out std_logic;
            pwm: out std_logic;
            red: out std_logic_vector(3 downto 0);
            green: out std_logic_vector(3 downto 0);
            blue: out std_logic_vector(3 downto 0);
            hsync: out std_logic;
            vsync: out std_logic;
            led: out std_logic_vector(11 downto 0);
            anodes: out std_logic_vector(3 downto 0);
            cathodes: out std_logic_vector(7 downto 0)
        );
    end component;

    constant clk_period: time := 1ns;
    constant sample_period: time := 6104ns;
    
    signal clk: std_logic := '1';
    signal buttons: std_logic_vector(4 downto 0) := (0 => '1', others => '0');
    signal switches: std_logic_vector(1 downto 0) := "11";
    signal input: std_logic := '1';
    signal feedback: std_logic := '1';
    signal pwm: std_logic := '1';
    signal red: std_logic_vector(3 downto 0);
    signal blue: std_logic_vector(3 downto 0);
    signal green: std_logic_vector(3 downto 0);
    signal hsync: std_logic;
    signal vsync: std_logic;
    signal led: std_logic_vector(11 downto 0);
    signal anodes: std_logic_vector(3 downto 0);
    signal cathodes: std_logic_vector(7 downto 0);

begin

    distsensor: distance_sensor
    port map (
        clk => clk,
        buttons => buttons,
        switches => switches,
        input => input,
        feedback => feedback,
        pwm => pwm,
        red => red,
        green => green,
        blue => blue,
        hsync => hsync,
        vsync => vsync,
        led => led,
        anodes => anodes,
        cathodes => cathodes
     );
     
     process begin
        clk <= '0';
        wait for clk_period/2;
        clk <='1';
        wait for clk_period/2;
     end process;
     
     process begin
         input <= '0';
         wait for 3*sample_period;
         input <= '1';
         wait for 2*sample_period;
         input <= '0';
         wait for 5*sample_period;
         input <= '1';
         wait for 4*sample_period;
     end process;
    
    buttons(0) <= '0' after 5*clk_period/2;
end Behavioral;
