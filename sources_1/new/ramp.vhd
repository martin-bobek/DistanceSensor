library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ramp is
    generic(
        period: integer;
        period_width: integer;
        distance_size: integer;
        pwm_width: integer
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
    constant top: unsigned(period_width - 1 downto 0) := to_unsigned(period - 1, period_width);
    
    signal c_last, c_next, duty_cycle: unsigned(pwm_width - 1 downto 0);
    signal counter: unsigned(period_width - 1 downto 0);
    signal i_update: std_logic;
begin
    output <= std_logic_vector(duty_cycle);
    update <= i_update;
    
    process(clk, reset) begin
        if (reset = '1') then
            update <= '0';
            c_last <= (others => '0');
            c_next <= (others => '0');
            counter <= top;
        elsif rising_edge(clk) and (pwm_update = '1') then
            if (pwm_update = '1') then
                if (counter = top) then
                    counter <= (others => '0');
                    c_last <= unsigned(value_last(distance_size - 1 downto distance_size - pwm_width - 1));
                    c_next <= unsigned(value_next(distance_size - 1 downto distance_size - pwm_width - 1));
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
        
        elsif rising_edge(clk) then
        
        end if;
    end process;
end;
