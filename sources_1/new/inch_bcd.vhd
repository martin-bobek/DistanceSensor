library ieee;
use ieee.std_logic_1164.all;

entity inch_bcd is
    port(
        clk: std_logic;
        reset: std_logic;
        tens: std_logic_vector(0 downto 0);
        ones: std_logic_vector(3 downto 0);
        tenths: std_logic_vector(3 downto 0);
        hundredths: std_logic_vector(3 downto 0)    
    );
end;

architecture behavioural of inch_bcd is

begin

end;
