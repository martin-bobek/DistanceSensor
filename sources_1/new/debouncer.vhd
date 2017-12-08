library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity debouncer is
    generic(
        period: integer
    );
    port(
        clk: in std_logic;
        input: in std_logic;
        output: out std_logic
    );
end;

architecture behavioural of debouncer is
    constant top: unsigned(width(period - 1) - 1 downto 0) := to_unsigned(period - 1, width(period - 1));

    signal hold: std_logic_vector(1 downto 0);
    signal counter: unsigned(width(period - 1) - 1 downto 0);
    signal counter_reset, match: std_logic;
begin
    counter_reset <= hold(0) xor hold(1);
    match <= '1' when (counter >= top) else '0';
    
    process(clk) begin
        if rising_edge(clk) then
            hold(0) <= input;
            hold(1) <= hold(0);
            if (match = '1') then
                output <= hold(1);
            end if; 
        end if;
    end process;
    
    process(clk) begin
        if rising_edge(clk) then
            if (counter_reset = '1') then
                counter <= (others => '0');
            elsif (match = '0') then
                counter <= counter + 1;
            end if;
        end if;
    end process;
end;
