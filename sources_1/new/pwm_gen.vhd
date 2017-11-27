library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_gen is
    generic(
        width: positive
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        input: in std_logic_vector(width - 1 downto 0);
        output: out std_logic;
        update: out std_logic
    );
end;

architecture behavioural of pwm_gen is 
    constant top: unsigned(width - 1 downto 0) := (0 => '0', others => '1');
    
    signal counter: unsigned(width - 1 downto 0);
    signal c_input: unsigned(width - 1 downto 0);
    signal i_update: std_logic;
begin
    output <= '1' when (counter < c_input) else '0';
    update <= i_update;
    
    process(clk, reset) begin
        if (reset = '1') then
            i_update <= '0';
            c_input <= (others => '0');
            counter <= top;
        elsif rising_edge(clk) then
            if (counter = top) then
                counter <= (others => '0');
                c_input <= unsigned(input);
                i_update <= '1';
            else
                counter <= counter + 1;
            end if;
            
            if (i_update = '1') then
                i_update <= '0';
            end if;
        end if;
    end process;
end;
