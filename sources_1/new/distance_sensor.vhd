library ieee;
use ieee.std_logic_1164.all;
use work.functions.all;

entity distance_sensor is
    port(
        clk: in std_logic;
        reset: in std_logic;
        input: in std_logic;
        start: in std_logic;
        feedback: out std_logic;
        led: out std_logic_vector(11 downto 0);
        pwm: out std_logic
    );
end;

architecture behavioural of distance_sensor is
    component adc is
        generic(
            period: positive;
            bits: positive
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            sample: in std_logic;
            feedback: out std_logic;
            voltage: out std_logic_vector(bits - 1 downto 0);
            ready: out std_logic
        );
    end component;
    
    component distance_rom is
        generic(
            adc_bits: positive;
            distance_width: positive
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            update: in std_logic;
            voltage: in std_logic_vector(adc_bits - 1 downto 0);
            distance: out std_logic_vector(distance_width - 1 downto 0);
            ready: out std_logic
        );
    end component;
    
    component shift_register is 
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
    end component;
    
    component scope_plot is
        generic(
            pwm_width: positive;
            trig_pulse: positive;
            blank_period: positive;
            ramp_period: positive;
            distance_width: positive;
            mem_length: positive
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            update: in std_logic;
            start: in std_logic;
            distance: in std_logic_vector(distance_width - 1 downto 0);
            address: out std_logic_vector(width(mem_length - 1) - 1 downto 0);
            pwm: out std_logic;
            test_pwm_value: out std_logic_vector(pwm_width - 1 downto 0)
        );
    end component;
    
    constant adc_bits: positive := 12;
    constant sample_period: positive := 20000;
    constant distance_width: positive := 12;
    constant mem_length: positive := 10;
    constant pwm_width: positive := 7;
    constant trig_pulse: positive := 100;
    constant blank_period: positive := 100;
    constant ramp_period: positive := 500;
    
    signal adc_ready, conv_ready: std_logic;
    signal voltage: std_logic_vector(adc_bits - 1 downto 0);
    signal conv_distance, mem_distance: std_logic_vector(distance_width - 1 downto 0);
    signal address: std_logic_vector(width(mem_length - 1) - 1 downto 0);
begin
    led <= conv_distance;
    pwm <= conv_ready;
    
    analog: adc
        generic map(
            period => sample_period,
            bits => adc_bits
        )
        port map(
            clk => clk,
            reset => reset,
            sample => input,
            feedback => feedback,
            voltage => voltage,
            ready => adc_ready
        );
    
    converter: distance_rom
        generic map(
            adc_bits => adc_bits,
            distance_width => distance_width
        )
        port map(
            clk => clk,
            reset => reset,
            update => adc_ready,
            voltage => voltage,
            distance => conv_distance,
            ready => conv_ready
        );
        
--    memory: shift_register
--        generic map(
--            distance_width => distance_width,
--            mem_length => mem_length
--        )
--        port map(
--            clk => clk,
--            reset => reset,
--            update => update,
--            distance_in => dac_distance,
--            address => address,
--            distance_out => mem_distance
--        );
    
--    graph: scope_plot
--        generic map(
--            pwm_width => pwm_width,
--            trig_pulse => trig_pulse,
--            blank_period => blank_period,
--            ramp_period => ramp_period,
--            distance_width => distance_width,
--            mem_length => mem_length
--        )
--        port map(
--            clk => clk,
--            reset => reset,
--            update => update,
--            start => start,
--            distance => mem_distance,
--            address => address,
--            pwm => pwm,
--            test_pwm_value => open
--        );
end;
