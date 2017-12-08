library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity average is
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        distance_in: in std_logic_vector(11 downto 0);
        distance_out: out std_logic_vector(11 downto 0);
        ready: out std_logic
    );
end;

architecture behavioural of average is
    signal u_distance: unsigned(11 downto 0);
    signal accumulator: unsigned(13 downto 0);
    signal counter: unsigned(1 downto 0);
    signal sub_counter: unsigned(2 downto 0);
begin
    u_distance <= unsigned(distance_in);

    process(clk, reset) begin
        if (reset = '1') then
            accumulator <= (others => '0');
            counter <= (others => '0');
            sub_counter <= (others => '0');
            distance_out <= (others => '0');
        elsif rising_edge(clk) then
            ready <= '0';
            if (update = '1') then
                if (sub_counter = 0) then
                    if (counter = 0) then
                        distance_out <= std_logic_vector(accumulator(13 downto 2));
                        accumulator <= "00" & u_distance;
                        ready <= '1';
                    else
                        accumulator <= accumulator + u_distance;
                    end if;
                    
                    counter <= counter - 1;
                end if;
                
                sub_counter <= sub_counter - 1;
            end if;
        end if;
    end process;
end;
