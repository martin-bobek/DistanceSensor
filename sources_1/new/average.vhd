library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity average is
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        voltage_in: in std_logic_vector(11 downto 0);
        voltage_out: out std_logic_vector(11 downto 0);
        ready: out std_logic
    );
end;

architecture behavioural of average is
    signal u_voltage: unsigned(11 downto 0);
    signal accumulator: unsigned(13 downto 0);
    signal counter: unsigned(1 downto 0);
begin
    u_voltage <= unsigned(voltage_in);

    process(clk, reset) begin
        if (reset = '1') then
            accumulator <= (others => '0');
            counter <= (others => '0');
        elsif rising_edge(clk) then
            ready <= '0';
            if (update = '1') then
                if (counter = 0) then
                    voltage_out <= std_logic_vector(accumulator(13 downto 2));
                    accumulator <= "00" & u_voltage;
                    ready <= '1';
                else
                    accumulator <= accumulator + u_voltage;
                end if;
                
                counter <= counter - 1;
            end if;
        end if;
    end process;
end;
