library ieee;
use ieee.std_logic_1164.all;
use work.records.all;

entity tb_time_diff is end;

architecture behavioural of tb_time_diff is
    component time_diff is
        port(
            a: in time_v;
            b: in time_v;
            y: out time_v
        );
    end component;
    
    signal a, b, y: time_v;
begin
    a <= ("101", "1001", "010", "0111");
    b <= ("011", "0001", "001", "0010");

    uut: time_diff
        port map(
            a => a,
            b => b,
            y => y
        );
end;
