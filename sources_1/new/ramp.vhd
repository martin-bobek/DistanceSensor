library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity ramp is
    generic(
        period: positive;
        distance_width: positive;
        pwm_width: positive
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        pwm_update: in std_logic;
        value_last: in std_logic_vector(distance_width - 1 downto 0);
        value_next: in std_logic_vector(distance_width - 1 downto 0);
        output: out std_logic_vector(pwm_width - 1 downto 0);
        update: out std_logic
    );
end;

architecture behavioural of ramp is
    component level_prod_dsp is
        port(
            clk: in std_logic;
            a: in std_logic_vector(7 downto 0);
            p: out std_logic_vector(18 downto 0)
        );
    end component;
    
    component tick_prod_dsp is
        port(
            clk: in std_logic;
            a: in std_logic_vector(6 downto 0);
            b: in std_logic_vector(11 downto 0);
            p: out std_logic_vector(18 downto 0)
        );
    end component;

    constant period_width: positive := width(period - 1);
    constant top: unsigned(period_width - 1 downto 0) := to_unsigned(period - 1, period_width);
    
    signal c_last, c_next, duty_cycle: unsigned(pwm_width - 1 downto 0);
    signal counter: unsigned(period_width - 1 downto 0);
    signal ascending: boolean;
    signal amp_delta: unsigned(pwm_width downto 0);
    signal tot_delta: unsigned(pwm_width - 1 downto 0);
    signal tick_prod, level_prod: unsigned(pwm_width + period_width - 1 downto 0);
    
    constant latency: integer := 4;
    constant delay_top: unsigned(width(latency - 1) - 1 downto 0) := to_unsigned(latency - 1, width(latency - 1));
    signal prod_delay: unsigned(width(latency - 1) - 1 downto 0); 
begin
    output <= std_logic_vector(duty_cycle);
    
    ascending <= c_next >= c_last;
    tot_delta <= (c_next - c_last) when ascending else (c_last - c_next);
    amp_delta <= ('0' & (duty_cycle - c_last)) + 1 when ascending else ('0' & (c_last - duty_cycle)) + 1;
    --level_prod <= resize((('0' & amp_delta) + 1) * to_unsigned(period - 1, period_width), pwm_width + period_width);
    --tick_prod <= resize(counter * tot_delta, pwm_width + period_width);
    
    level_product: level_prod_dsp
        port map(
            clk => clk,
            a => std_logic_vector(amp_delta),
            unsigned(p) => level_prod
        );
    
    tick_product: tick_prod_dsp
        port map(
            clk => clk,
            a => std_logic_vector(tot_delta),
            b => std_logic_vector(counter),
            unsigned(p) => tick_prod
        );
    
    process(clk, reset) begin
        if (reset = '1') then
            update <= '0';
            c_last <= (others => '0');
            c_next <= (others => '0');
            counter <= top;
            prod_delay <= delay_top;
            duty_cycle <= (others => '0');
        elsif rising_edge(clk) then
            if (prod_delay /= 0) then
                prod_delay <= prod_delay - 1;
            end if;
            
            update <= '0';
            if (pwm_update = '1') then
                if (counter = top) then
                    counter <= (others => '0');
                    duty_cycle <= unsigned(value_last(distance_width - 1 downto distance_width - pwm_width));
                    c_last <= unsigned(value_last(distance_width - 1 downto distance_width - pwm_width));
                    c_next <= unsigned(value_next(distance_width - 1 downto distance_width - pwm_width));
                    update <= '1';
                else
                    counter <= counter + 1;
                end if;
                prod_delay <= delay_top;
            elsif (prod_delay = 0) and (tick_prod > level_prod) then
                if ascending then
                    duty_cycle <= duty_cycle + 1;
                else
                    duty_cycle <= duty_cycle - 1;
                end if;
                prod_delay <= delay_top;
            end if;
        end if;
    end process;
end;
