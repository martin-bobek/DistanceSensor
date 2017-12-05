library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.records.all;

entity time_diff is
    port(
        a: in time_v;
        b: in time_v;
        y: out time_v
    );
end;

architecture behavioural of time_diff is
    signal s_ten_min, s_ten_sec: unsigned(3 downto 0);
    signal s_min, s_sec: unsigned(4 downto 0);
    
    signal comp: time_u;
    signal u_y, u_a, u_b: time_u;
    
    signal carry_1, carry_2, carry_3: unsigned(0 downto 0);
begin
    y <= to_vector(u_y);
    u_a <= to_unsigned(a);
    u_b <= to_unsigned(b);

    comp <= (5 - u_b.ten_min, 9 - u_b.min, 5 - u_b.ten_sec, 9 - u_b.sec); 
    
    s_ten_min <= ('0' & comp.ten_min) + u_a.ten_min + carry_3; 
    s_min <= ('0' & comp.min) + u_a.min + carry_2;
    s_ten_sec <= ('0' & comp.ten_sec) + u_a.ten_sec + carry_1;
    s_sec <= ('0' & comp.sec) + u_a.sec + 1;
    
    process(s_ten_min, s_min, s_ten_sec, s_sec, carry_1, carry_2, carry_3) begin
        u_y.ten_min <= s_ten_min(2 downto 0); 
        u_y.min <= s_min(3 downto 0);
        u_y.ten_sec <= s_ten_sec(2 downto 0); 
        u_y.sec <= s_sec(3 downto 0);
        carry_1 <= "0";
        carry_2 <= "0";
        carry_3 <= "0";
        
        if (s_sec > 9) then
            carry_1 <= "1";
            u_y.sec <= resize(s_sec - 10, 4);
        end if;
        
        if (s_ten_sec > 5) then
            carry_2 <= "1";
            u_y.ten_sec <= resize(s_ten_sec - 6, 3);
        end if;
        
        if (s_min > 9) then
            carry_3 <= "1";
            u_y.min <= resize(s_min - 10, 4);
        end if;
            
        if (s_ten_min > 5) then
            u_y.ten_min <= resize(s_ten_min - 6, 3);
        end if;
    end process;
end;
