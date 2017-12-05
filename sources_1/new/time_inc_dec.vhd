library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.records.all;

entity time_inc_dec is
    port(
        decrement: in std_logic;
        input: in time_v;
        output: out time_v
    );
end;

architecture behavioural of time_inc_dec is
    signal u_in, u_out: time_u;
begin
    output <= to_vector(u_out);
    u_in <= to_unsigned(input);

    process(decrement, u_in) begin
        u_out <= u_in;
        if (decrement = '0') then    
            if (u_in.sec = 9) then
                u_out.sec <= "0000";
                if (u_in.ten_sec = 5) then
                    u_out.ten_sec <= "000";
                    if (u_in.min = 9) then
                        u_out.min <= "0000";
                        if (u_in.ten_min = 5) then
                            u_out.ten_min <= "000";
                        else
                            u_out.ten_min <= u_in.ten_min + 1;
                        end if;
                    else
                        u_out.min <= u_in.min + 1;
                    end if;
                else
                    u_out.ten_sec <= u_in.ten_sec + 1;
                end if;
            else
                u_out.sec <= u_in.sec + 1;
            end if;
        else
            if (u_in.sec = 0) then
                u_out.sec <= "1001";
                if (u_in.ten_sec = 0) then
                    u_out.ten_sec <= "101";
                    if (u_in.min = 0) then
                        u_out.min <= "1001";
                        if (u_in.ten_min = 0) then
                            u_out.ten_min <= "101";
                        else
                            u_out.ten_min <= u_in.ten_min - 1;
                        end if;
                    else
                        u_out.min <= u_in.min - 1;
                    end if;
                else
                    u_out.ten_sec <= u_in.ten_sec - 1;
                end if;
            else
                u_out.sec <= u_in.sec - 1;
            end if;        
        end if;
    end process;
end;
