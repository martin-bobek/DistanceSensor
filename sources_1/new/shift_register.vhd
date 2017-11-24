library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package output_array_distances_type is
    type output_array_distances is array (0 to 9) of STD_LOGIC_VECTOR(11 downto 0);
end package output_array_distances_type;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use work.output_array_distances_type.all;


entity ShiftReg is
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
end ShiftReg;

architecture Behavioral of ShiftReg is

   component DataRegister
   port(
      CLK : in STD_LOGIC;
      RST : in STD_LOGIC;
      ChangeDisplay: in STD_LOGIC; -- Determines how often to change display
      DistanceIn : in STD_LOGIC_VECTOR (VECTOR_SIZE-1 downto 0);
      DistanceOut : out STD_LOGIC_VECTOR (VECTOR_SIZE-1 downto 0)
    );    
    end component;
    
begin
    TenShiftRegs: for i in 0 to 9 generate
        begin
            DataRegFirst: if i = 0 generate
                RegOne: DataRegister port map(
                    CLK => CLK,
                    RST => RST,
                    ChangeDisplay => ChangeDisplay,
                    DistanceIn => InVals,
                    DistanceOut => OutVals(i)
                    );
            end generate DataRegFirst;
            
            OtherDataRegs: if i > 0 generate
                RegOne: DataRegister port map(
                        CLK => CLK,
                        RST => RST,
                        ChangeDisplay => ChangeDisplay,
                        DistanceIn => OutVals(i-1),
                        DistanceOut => OutVals(i)
                        );
                end generate OtherDataRegs;
            
     end generate TenShiftRegs;

end Behavioral;
