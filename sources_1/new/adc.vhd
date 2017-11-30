library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity adc is 
    generic(
        period: positive;
        bits: positive
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        sample: in std_logic;
        feedback: out std_logic;
        output: out std_logic_vector(bits - 1 downto 0);
        update: out std_logic
    );
end;

architecture behavioural of adc is
    constant period_width: positive := width(period - 1);
    constant top: unsigned(period_width - 1 downto 0) := to_unsigned(period - 1, period_width);
    
    signal counter: unsigned(period_width - 1 downto 0);
    signal sample_num, u_output: unsigned(bits - 1 downto 0);
    
    signal tick, i_feedback, i_update: std_logic;
begin
    feedback <= i_feedback;
    update <= i_update;

    process(clk, reset) begin
        if (reset = '1') then
            counter <= top;
        elsif rising_edge(clk) then
            if (counter = top) then
                counter <= (others => '0');
                i_feedback <= sample;
                if (sample_num = 0) then
                    
                else
                    sample_num <= sample_num + 1;
                end if;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    

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
                i_update <= '1';
                tick <= '0';
            end if;
            if (i_update = '1') then
                i_update <= '0';
            end if;
        end if;
    end process;
    
    process(clk, reset) begin
        if (reset = '1') then
            sample_num <= (others => '0');
        elsif rising_edge(clk) and (tick = '1') then
            if (sample_num = 0) then
                output <= std_logic_vector(u_output);
                u_output <= "00000000000" & i_feedback;
            elsif (i_feedback = '1') then
                u_output <= u_output + 1;
            end if;
            
            sample_num <= sample_num + 1;
        end if;
    end process;
end;
