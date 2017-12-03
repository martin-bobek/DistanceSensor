library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity time_inc_dec is
    port(
        ten_min_in: in std_logic_vector(2 downto 0);
        min_in: in std_logic_vector(3 downto 0);
        ten_sec_in: in std_logic_vector(2 downto 0);
        sec_in: in std_logic_vector(3 downto 0);
        decrement: in std_logic;
        ten_min_out: out std_logic_vector(2 downto 0);
        min_out: out std_logic_vector(3 downto 0);
        ten_sec_out: out std_logic_vector(2 downto 0);
        sec_out: out std_logic_vector(3 downto 0)
    );
end;

architecture behavioural of time_inc_dec is 
    signal u_min, u_sec: unsigned(3 downto 0);
    signal u_ten_min, u_ten_sec: unsigned(2 downto 0);
begin
    u_ten_min <= unsigned(ten_min_in); 
    u_min <= unsigned(min_in);
    u_ten_sec <= unsigned(ten_sec_in);
    u_sec <= unsigned(sec_in);

    process(decrement, u_ten_min, u_min, u_ten_sec, u_sec) begin
        ten_sec_out <= std_logic_vector(u_ten_sec); 
        min_out <= std_logic_vector(u_min);
        ten_min_out <= std_logic_vector(u_ten_min);
        if (decrement = '0') then    
            if (u_sec = 9) then
                sec_out <= "0000";
                if (u_ten_sec = 5) then
                    ten_sec_out <= "000";
                    if (u_min = 9) then
                        min_out <= "0000";
                        if (u_ten_min = 5) then
                            ten_min_out <= "000";
                        else
                            ten_min_out <= std_logic_vector(u_ten_min + 1);
                        end if;
                    else
                        min_out <= std_logic_vector(u_min + 1);
                    end if;
                else
                    ten_sec_out <= std_logic_vector(u_ten_sec + 1);
                end if;
            else
                sec_out <= std_logic_vector(u_sec + 1);
            end if;
        else
            if (u_sec = 0) then
                sec_out <= "1001";
                if (u_ten_sec = 0) then
                    ten_sec_out <= "101";
                    if (u_min = 0) then
                        min_out <= "1001";
                        if (u_ten_min = 0) then
                            ten_min_out <= "101";
                        else
                            ten_min_out <= std_logic_vector(u_ten_min - 1);
                        end if;
                    else
                        min_out <= std_logic_vector(u_min - 1);
                    end if;
                else
                    ten_sec_out <= std_logic_vector(u_ten_sec - 1);
                end if;
            else
                sec_out <= std_logic_vector(u_sec - 1);
            end if;        
        end if;
    end process;
end;
