library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_register is 
    generic(
        length: integer := 12
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        change_display: in std_logic;
        distance_in: in std_logic_vector(length - 1 downto 0);
        distance_out: out std_logic_vector(length - 1 downto 0)
    );
end;

architecture behavioral of data_register is begin
    process(clk, reset) begin
        if (reset = '1') then
            distance_out <= (others => '0');
        elsif rising_edge(clk) and (change_display = '1') then
            distance_out <= distance_in;
        end if;
    end process;
end;
