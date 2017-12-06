library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.records.all;
entity bcd_to_bin is
    generic(
        bin_width: positive
    );
    port(
        bcd: in time_v;
        binary: out std_logic_vector(bin_width - 1 downto 0)
    );
end;

architecture behavioural of bcd_to_bin is
    signal u_bcd: time_u;
    signal ten_secs: unsigned(5 downto 0);  
    signal mins: unsigned(9 downto 0);
    signal ten_mins: unsigned(11 downto 0);
begin
    u_bcd <= to_unsigned(bcd);
    ten_secs <= resize(to_unsigned(10, 4) * u_bcd.ten_sec, 6);
    mins <= to_unsigned(60, 6) * u_bcd.min;
    ten_mins <= resize(to_unsigned(600, 10) * u_bcd.ten_min, 12);
    binary <= std_logic_vector(resize(ten_mins + mins + ten_secs + u_bcd.sec, bin_width));
end;
