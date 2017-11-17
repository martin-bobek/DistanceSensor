library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adc is 
    port(
        clk: in std_logic;
        reset: in std_logic;
        sample: in std_logic;
        feedback: out std_logic;
        output: out std_logic_vector(11 downto 0);
    );
end;

architecture behavioural of adc is
    constant top: unsigned(14 downto 0) := to_unsigned(20000 - 1, 15);
    
    signal counter: unsigned(14 downto 0);
    signal sample_num, u_output: unsigned(11 downto 0);
begin
    process(clk, reset) begin
        if (reset = '1') then
            counter <= top;
            feedback <= '0';
            sample_num <= (others => '0');
        elsif rising_edge(clk) then
            if (counter = top) then
                counter <= (others => '0');
                feedback <= sample;
                sample_num <= sample_num;
                
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    
end;