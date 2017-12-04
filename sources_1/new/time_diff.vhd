library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity time_diff is
    port(
        ten_min_a: in std_logic_vector(2 downto 0);
        min_a: in std_logic_vector(3 downto 0);
        ten_sec_a: in std_logic_vector(2 downto 0);
        sec_a: in std_logic_vector(3 downto 0);
        ten_min_b: in std_logic_vector(2 downto 0);
        min_b: in std_logic_vector(3 downto 0);
        ten_sec_b: in std_logic_vector(2 downto 0);
        sec_b: in std_logic_vector(3 downto 0);
        ten_min_y: out std_logic_vector(2 downto 0);
        min_y: out std_logic_vector(3 downto 0);
        ten_sec_y: out std_logic_vector(2 downto 0);
        sec_y: out std_logic_vector(3 downto 0)
    );
end;

architecture behavioural of time_diff is
    signal s_ten_min, s_ten_sec: unsigned(2 downto 0);
    signal s_min, s_sec: unsigned(3 downto 0);
    signal c_ten_min_b, c_ten_sec_b: unsigned(3 downto 0);
    signal c_min_b, c_sec_b: unsigned(4 downto 0);
    signal u_ten_min, u_ten_sec: unsigned(2 downto 0);
    signal u_min, u_sec: unsigned(3 downto 0);
    
    signal carry_1, carry_2, carry_3: unsigned(0 downto 0);
begin
    ten_min_y <= std_logic_vector(u_ten_min);
    min_y <= std_logic_vector(u_min);
    ten_sec_y <= std_logic_vector(u_ten_sec); 
    sec_y <= std_logic_vector(u_sec);

    c_ten_min_b <= 5 - unsigned(ten_min_b);
    c_min_b <= 9 - unsigned(min_b);
    c_ten_sec_b <= 5 - unsigned(ten_sec_b);
    c_sec_b <= 9 - unsigned(sec_b);
    
    s_ten_min <= ('0' & c_ten_min_b) + unsigned(ten_min_a) + carry_3;
    s_min <= ('0' & c_min_b) + unsigned(min_a) + carry_2;
    s_ten_sec <= ('0' & c_ten_sec_b) + unsigned(ten_sec_a) + carry_1;
    s_sec <= ('0' & c_sec_b) + unsigned(sec_a) + 1;
    
    process(s_ten_min, s_min, s_ten_sec, s_sec, carry_1, carry_2, carry_3) begin
        u_ten_min <= s_ten_min(2 downto 0); 
        u_min <= s_ten_min(3 downto 0);
        u_ten_sec <= s_ten_min(2 downto 0); 
        u_sec <= s_ten_min(3 downto 0);
        carry_1 <= "0";
        carry_2 <= "0";
        carry_3 <= "0";
        
        if (u_sec > 9) then
            carry_1 <= "1";
            u_sec <= resize(s_sec - 9, 4);
        end if;
        
        if (u_ten_sec > 5) then
            carry_2 <= "1";
            u_ten_sec <= resize(s_ten_sec - 5, 3);
        end if;
        
        if (u_min > 9) then
            carry_3 <= "1";
            u_min <= resize(s_min - 9, 4);
        end if;
            
        if (u_ten_min > 5) then
            u_ten_min <= resize(s_ten_min - 5, 3);
        end if;
    end process;
end;