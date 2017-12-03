library ieee;
use ieee.std_logic_1164.all;
use work.functions.all;

entity distance_sensor is
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        input: in std_logic;
        feedback: out std_logic;
        pwm: out std_logic;
        red: out std_logic_vector(3 downto 0);
        green: out std_logic_vector(3 downto 0);
        blue: out std_logic_vector(3 downto 0);
        hsync: out std_logic;
        vsync: out std_logic;
        led: out std_logic_vector(11 downto 0)
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

    component distance_mem is
        port(
            clk: in std_logic;
            reset: in std_logic;
            update: in std_logic;
            distance_in: in std_logic_vector(11 downto 0);
            
            read_a: in std_logic;
            address_a: in std_logic_vector(9 downto 0);
            distance_a: out std_logic_vector(11 downto 0);
            ready_a: out std_logic;
            
            read_b: in std_logic;
            address_b: in std_logic_vector(9 downto 0);
            distance_b: out std_logic_vector(11 downto 0);
            ready_b: out std_logic
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
            mem_read: out std_logic;
            mem_ready: in std_logic;
            pwm: out std_logic;
            test_pwm_value: out std_logic_vector(pwm_width - 1 downto 0)
        );
    end component;
    
    component vga_module is
        port(
            clk: in std_logic;
            reset: in std_logic;
            update: in std_logic;
            
            mem_read: out std_logic;
            address: out std_logic_vector(9 downto 0);
            distance: in std_logic_vector(11 downto 0);
            mem_ready: in std_logic;
            
            red: out std_logic_vector(3 downto 0);
            green: out std_logic_vector(3 downto 0);
            blue: out std_logic_vector(3 downto 0);
            hsync: out std_logic;
            vsync: out std_logic
        );
    end component;
    
    constant adc_bits: positive := 12;
    constant sample_period: positive := 5000;
    constant distance_width: positive := 12;
    constant mem_length: positive := 600;
    constant pwm_width: positive := 7;
    constant trig_pulse: positive := 100;
    constant blank_period: positive := 100;
    constant ramp_period: positive := 3125;
    
    signal adc_ready, conv_ready, scope_ready, scope_read, vga_ready, vga_read: std_logic;
    signal voltage: std_logic_vector(adc_bits - 1 downto 0);
    signal conv_distance, scope_distance, vga_distance: std_logic_vector(distance_width - 1 downto 0);
    signal scope_address, vga_address: std_logic_vector(width(mem_length - 1) - 1 downto 0);
begin
    led <= voltage;
    
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
        
      memory: distance_mem
        port map(
            clk => clk,
            reset => reset,
            update => conv_ready,
            distance_in => conv_distance,
            
            read_a => scope_read,
            address_a => scope_address,
            distance_a => scope_distance,
            ready_a => scope_ready,
            
            read_b => vga_read,
            address_b => vga_address,
            distance_b => vga_distance,
            ready_b => vga_ready
        );
    
    graph: scope_plot
        generic map(
            pwm_width => pwm_width,
            trig_pulse => trig_pulse,
            blank_period => blank_period,
            ramp_period => ramp_period,
            distance_width => 12,
            mem_length => 600
        )
        port map(
            clk => clk,
            reset => reset,
            update => conv_ready,
            start => start,
            distance => scope_distance,
            address => scope_address,
            mem_read => scope_read,
            mem_ready => scope_ready,
            pwm => pwm,
            test_pwm_value => open
        );
        
    vga: vga_module
        port map(
            clk => clk,
            reset => reset,
            update => conv_ready,
            
            mem_read => vga_read,
            address => vga_address,
            distance => vga_distance,
            mem_ready => vga_ready,
            
            red => red,
            green => green,
            blue => blue,
            hsync => hsync,
            vsync => vsync
        );
end;
