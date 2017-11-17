----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2017 07:41:03 PM
-- Design Name: 
-- Module Name: tb_DistanceMeasure - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_DistanceRomFunction is end;

architecture Behavioral of tb_DistanceRomFunction is
    component DistanceRomFunction is
    generic (
        VOLTAGE_SIZE:       integer := 12;
        DISTANCE_SIZE:      integer := 12;
        STARTING_VOLTAGE:   integer := 521
    );
    
    Port ( 
           CLK          : in std_logic;
           voltageIn    : in STD_LOGIC_VECTOR (VOLTAGE_SIZE-1 downto 0);
           distanceOut  : out STD_LOGIC_VECTOR (DISTANCE_SIZE-1 downto 0);
           Ready        : in std_logic
           );
    end Component;   

    signal CLK : std_logic := '1';
    signal Ready : std_logic := '1';
    signal voltage : std_logic_vector (11 downto 0);
    signal output : std_logic_vector (11 downto 0);
 
 begin
       
    uut: DistanceRomFunction
        port map(
            CLK => CLK,
            Ready => Ready,
            voltageIn => voltage,
            distanceOut => output
        );
    
    voltagechange: process begin
        --should give about 30 cm
        voltage <= std_logic_vector(to_unsigned(521,12));
        wait for 10ns;
        -- should give about 4 cm
        voltage <= std_logic_vector(to_unsigned(3387,12));
        wait for 10ns;
        -- should give about 7.75 cm
        voltage <= std_logic_vector(to_unsigned(2000,12));
        wait for 10ns;
    end process;    
    
    clkchange: process begin
        clk <= '0';
        wait for 1ns;
        clk <= '1';
        wait for 1ns;
     end process;
     
     readychange: process begin
        Ready <= '0';
        wait for 12 ns;
        Ready <= '1';
        wait for 1ns;
     end process;


end Behavioral;
