----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2017 04:31:07 PM
-- Design Name: 
-- Module Name: tb_ShiftReg - Behavioral
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

package output_array_distances_type is
    type output_array_distances is array (0 to 59) of STD_LOGIC_VECTOR(11 downto 0);
end package output_array_distances_type;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use work.output_array_distances_type.all;

entity tb_ShiftReg is end; 

architecture Behavioral of tb_ShiftReg is

    component ShiftReg is
        Generic
        (
            VECTOR_SIZE : integer := 12
        );
        Port ( 
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           ChangeDisplay : in STD_LOGIC;
           InVals : in STD_LOGIC_VECTOR (VECTOR_SIZE-1 downto 0);
           OutVals : inout output_array_distances
          );
       end component;

    signal CLK_t : std_logic := '0';
    signal RST_t : std_logic := '1';
    signal ChangeDisplay_t : std_logic := '0';
    signal InVals_t : std_logic_vector(11 downto 0);
    signal OutVals_t : output_array_distances;
begin

    utt: ShiftReg
        port map(
            CLK => CLK_t,
            RST => RST_t,
            ChangeDisplay => ChangeDisplay_t,
            InVals => InVals_t,
            OutVals => OutVals_t
            );
       
     CLKproc: process begin
        CLK_t <= '1';
        wait for 1ns;
        CLK_t <= '0';
        wait for 1ns;
      end process;
      
      RSTproc: process begin
        RST_t <= '1';
        wait for 40ns;
        RST_t <= '0';
        wait;
      end process;
      
      DisplayProc: process begin
        ChangeDisplay_t <= '0';
        wait for 7 ns;
        ChangeDisplay_t <= '1';
        wait for 3 ns;
      end process;
      
      InValsProc: process begin
        InVals_t <= "100000000000";
        wait for 3 ns; 
        InVals_t <= "000000000001";
        wait for 3 ns;
        InVals_t <= "000000000010";
        wait for 3 ns;
        InVals_t <= "000000000100";
        wait for 3 ns;
        InVals_t <= "000000001000";
        wait for 3 ns;
      end process;

end Behavioral;
