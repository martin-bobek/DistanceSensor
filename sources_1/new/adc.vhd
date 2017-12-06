library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity adc is 
    generic(
        period: positive
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        sample: in std_logic;
        feedback: out std_logic;
        voltage: out std_logic_vector(11 downto 0);
        ready: out std_logic
    );
end;

architecture behavioural of adc is
    constant period_width: positive := width(period - 1);
    constant top: unsigned(period_width - 1 downto 0) := to_unsigned(period - 1, period_width);
    
    type partial_array is array(0 to 7) of unsigned(8 downto 0);
    signal partials: partial_array;
    
    signal counter: unsigned(period_width - 1 downto 0);
    signal sample_num, u_voltage: unsigned(8 downto 0);
begin
    process(clk, reset) begin
        if (reset = '1') then
            counter <= top;
            partials <= (others => (others => '0'));
            u_voltage <= (others => '0');
            sample_num <= (others => '0');
            feedback <= '0';
            ready <= '0';
        elsif rising_edge(clk) then
            ready <= '0';
            
            if (counter = top) then
                counter <= (others => '0');
                feedback <= sample;
                
                if (sample_num = 0) then
                    partials(0) <= u_voltage;
                    for i in 0 to 6 loop
                        partials(i + 1) <= partials(i);
                    end loop;
                    
                    u_voltage <= (0 => sample, others => '0');
                    ready <= '1';
                elsif (sample = '1') then
                    u_voltage <= u_voltage + 1;
                end if;
                
                sample_num <= sample_num + 1;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    process(partials)
        variable sum: unsigned(11 downto 0) := (others => '0');
    begin
        sum := (others => '0');
        for i in 0 to 7 loop
            sum := sum + partials(i);
        end loop;
        voltage <= std_logic_vector(sum);
    end process;
end;
