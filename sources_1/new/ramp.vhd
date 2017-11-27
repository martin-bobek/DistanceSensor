library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ramp is
    generic(
        period: positive;
        period_width: positive;
        distance_size: positive;
        pwm_width: positive
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        pwm_update: in std_logic;
        value_last: in std_logic_vector(distance_size - 1 downto 0);
        value_next: in std_logic_vector(distance_size - 1 downto 0);
        output: out std_logic_vector(pwm_width - 1 downto 0);
        update: out std_logic
    );
end;

architecture behavioural of ramp is
    function max(num1: positive; num2: positive) return positive is begin
        if (num1 >= num2) then
            return num1;
        else
            return num2;
        end if;
    end;

    constant top: unsigned(period_width - 1 downto 0) := to_unsigned(period - 1, period_width);
    
    signal c_last, c_next, duty_cycle: unsigned(pwm_width - 1 downto 0);
    signal counter: unsigned(period_width - 1 downto 0);
    signal i_update: std_logic;
    signal ascending: boolean;
    signal amp_delta, tot_delta: unsigned(pwm_width - 1 downto 0);
    signal tick_prod, level_prod: unsigned(pwm_width + period_width - 1 downto 0);
begin
    output <= std_logic_vector(duty_cycle);
    update <= i_update;
    
    ascending <= c_next >= c_last;
    tot_delta <= (c_next - c_last) when ascending else (c_last - c_next);
    amp_delta <= (duty_cycle - c_last) when ascending else (c_last - duty_cycle);
    level_prod <= resize((resize(amp_delta, (pwm_width + max(period_width, pwm_width + 1) + 1) / 2) + 1) * (period - 1), pwm_width + period_width);
    tick_prod <= resize(counter * tot_delta, pwm_width + period_width);
    
    process(clk, reset) begin
        if (reset = '1') then
            i_update <= '0';
            c_last <= (others => '0');
            c_next <= (others => '0');
            counter <= top;
        elsif rising_edge(clk) then
            if (pwm_update = '1') then
                if (counter = top) then
                    counter <= (others => '0');
                    c_last <= unsigned(value_last(distance_size - 1 downto distance_size - pwm_width));
                    c_next <= unsigned(value_next(distance_size - 1 downto distance_size - pwm_width));
                    i_update <= '1';
                else
                    counter <= counter + 1;
                end if;
            end if;
            
            if (i_update = '1') then
                i_update <= '0';
            end if;
        end if;
    end process;
   
    process(clk, reset) begin
        if (reset = '1') then
            duty_cycle <= (others => '0');
        elsif rising_edge(clk) then
            if (i_update = '1') then
                duty_cycle <= c_last;
            elsif (tick_prod > level_prod) then
                if ascending then
                    duty_cycle <= duty_cycle + 1;
                else
                    duty_cycle <= duty_cycle - 1;
                end if;
            end if;
        end if;
    end process;
end;
