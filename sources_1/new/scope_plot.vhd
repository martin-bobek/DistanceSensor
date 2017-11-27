library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity scope_plot is
    generic(
        pwm_width: positive;
        trig_pulse: positive;
        trig_width: positive;
        ramp_period: positive;
        ramp_period_width: positive;
        distance_size: positive;
        address_size: positive;
        mem_length: positive
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        start: in std_logic;
        distance: in std_logic_vector(distance_size downto 0);
        address: out std_logic_vector(address_size downto 0);
        pwm: out std_logic
    );
end;

architecture behavioral of scope_plot is
    component pwm_gen is
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
    end component;
    
    component ramp is
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
    end component;
    
    type state_type is (idle, sync, trigger, waveform);
    
    signal state: state_type;
    signal pwm_update, ramp_update: std_logic;
    signal pwm_value, ramp_value: std_logic_vector(pwm_width - 1 downto 0);
    signal value_last, value_next: std_logic_vector(distance_size - 1 downto 0);
    signal counter: unsigned(ramp_period_width - 1 downto 0);
begin
    pwm_value <= (others => '1') when (state = trigger) else ramp_value;

    dac: pwm_gen
        generic map(
            width => pwm_width
        )
        port map(
            clk => clk,
            reset => reset,
            input => pwm_value,
            output => pwm,
            update => pwm_update
        );
        
    ramp_gen: ramp
        generic map(
            period => ramp_period,
            period_width => ramp_period_width,
            distance_size => distance_size,
            pwm_width => pwm_width
        )
        port map(
            clk => clk,
            reset => reset,
            pwm_update => pwm_update,
            value_last => value_last,
            value_next => value_next,
            output => ramp_value,
            update => ramp_update
        );
    
    process(clk, reset) begin
        if (reset = '1') then
            state <= idle;
            pwm_value <= (others => '0');
        elsif rising_edge(clk) then
            case state is
                when idle =>
                    if (start = '1') then
                        state <= sync;
                    end if;
                when sync =>
                    if (ramp_update = '1') then
                        counter <= to_unsigned(trig_pulse - 1, trig_width);
                        state <= trigger;
                    end if;
                when trigger =>
                    if (counter = 0) then
                        state <= waveform;
                    else
                        counter <= counter - 1;
                    end if;
                when waveform =>
                    
                    
            end case;
        end if;
    end process;
        
    
end;
