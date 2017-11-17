library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adc is 
    port(
        clk: in std_logic;
        reset: in std_logic;
        sample: in std_logic;
        feedback: out std_logic;
        led: out std_logic_vector(11 downto 0)
    );
end;

architecture behavioural of adc is
    constant top: unsigned(14 downto 0) := to_unsigned(20000 - 1, 15);
    
    signal counter: unsigned(14 downto 0);
    signal sample_num, u_output: unsigned(11 downto 0);
    
    signal tick, i_feedback: std_logic;
begin
    feedback <= i_feedback;

    process(clk, reset) begin
        if (reset = '1') then
            counter <= top;
            i_feedback <= '0';
            tick <= '0';
        elsif rising_edge(clk) then
            if (counter = top) then
                counter <= (others => '0');
                i_feedback <= sample;
                tick <= '1';
            else
                counter <= counter + 1;
            end if;
            
            if (tick = '1') then
                tick <= '0';
            end if;
        end if;
    end process;
    
    process(clk, reset) begin
        if (reset = '1') then
            sample_num <= (others => '0');
        elsif rising_edge(clk) and (tick = '1') then
            if (sample_num = 0) then
                led <= std_logic_vector(u_output);
                u_output <= "00000000000" & i_feedback;
            elsif (i_feedback = '1') then
                u_output <= u_output + 1;
            end if;
            
            sample_num <= sample_num + 1;
        end if;
    end process;
end;
