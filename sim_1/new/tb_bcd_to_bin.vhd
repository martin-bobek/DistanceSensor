library ieee;
use ieee.std_logic_1164.all;
use work.records.all;

entity tb_bcd_to_bin is end;

architecture behavioural of tb_bcd_to_bin is
    component bcd_to_bin is
        generic(
            bin_width: positive
        );
        port(
            bcd: in time_v;
            binary: out std_logic_vector(11 downto 0)
        );
    end component;
    
    constant bcd: time_v := ("101", "1001", "101", "1001");
    signal binary: std_logic_vector(11 downto 0);
    
begin
    uut: bcd_to_bin
        port map(
            bcd => bcd,
            binary => binary
        ); 
end;
