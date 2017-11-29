library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity shift_register is
    generic(
        distance_width: positive;
        mem_length: positive
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        distance_in: in std_logic_vector(distance_width - 1 downto 0);
        address: in std_logic_vector(width(mem_length - 1) - 1 downto 0);
        distance_out: out std_logic_vector(distance_width - 1 downto 0)
    );
end;

architecture behavioural of shift_register is
    type registers is array(0 to mem_length - 1) of std_logic_vector(distance_width - 1 downto 0);
    
    signal storage: registers;
begin
    process(clk, reset) begin
        if (reset = '1') then
            for i in 0 to mem_length - 1 loop
                storage(i) <= (others => '0');
            end loop;
        elsif rising_edge(clk) then
            if (update = '1') then
                storage(0) <= distance_in;
                for i in 0 to mem_length - 2 loop
                    storage(i + 1) <= storage(i);
                end loop;
            end if;
            
            distance_out <= storage(to_integer(unsigned(address)));
        end if;
    end process;
end;
