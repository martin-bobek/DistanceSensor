library ieee;
use ieee.std_logic_1164.all;
use work.functions.all;

entity distance_sensor is
    port(
        clk: in std_logic;
        buttons: in std_logic_vector(4 downto 0);
        switches: in std_logic_vector(1 downto 0);
        input: in std_logic;
        feedback: out std_logic;
        pwm: out std_logic;
        red: out std_logic_vector(3 downto 0);
        green: out std_logic_vector(3 downto 0);
        blue: out std_logic_vector(3 downto 0);
        hsync: out std_logic;
        vsync: out std_logic;
        led: out std_logic_vector(11 downto 0);
        anodes: out std_logic_vector(3 downto 0);
        cathodes: out std_logic_vector(7 downto 0)
    );
end;

architecture behavioural of distance_sensor is
    constant adc_bits: positive := 12;
    constant sample_period: positive := 6104;
    constant distance_width: positive := 12;
    constant mem_length: positive := 600;
    constant pwm_width: positive := 7;
    constant trig_pulse: positive := 100;
    constant blank_period: positive := 100;
    constant ramp_period: positive := 3125;
    
    signal reset: std_logic;
    signal d_buttons: std_logic_vector(4 downto 0);
    signal d_switches: std_logic_vector(1 downto 0);
    signal adc_ready, ave_ready, conv_ready, scope_ready, scope_read, vga_ready, vga_read: std_logic;
    signal adc_voltage: std_logic_vector(adc_bits - 1 downto 0);
    signal ave_distance, conv_distance, scope_distance, vga_distance: std_logic_vector(distance_width - 1 downto 0);
    signal scope_address, vga_address: std_logic_vector(width(mem_length - 1) - 1 downto 0);
begin
    led <= adc_voltage;
    d_buttons <= buttons;
    d_switches <= switches;
    reset <= d_buttons(0);
    
    analog: entity work.adc
        generic map(
            period => sample_period
        )
        port map(
            clk => clk,
            reset => reset,
            sample => input,
            feedback => feedback,
            voltage => adc_voltage,
            ready => adc_ready
        );

    converter: entity work.distance_rom
        generic map(
            adc_bits => adc_bits,
            distance_width => distance_width
        )
        port map(
            clk => clk,
            reset => reset,
            update => adc_ready,
            voltage => adc_voltage,
            distance => conv_distance,
            ready => conv_ready
        );
        
    ave: entity work.average
        port map(
            clk => clk,
            reset => reset,
            update => conv_ready,
            distance_in => conv_distance,
            distance_out => ave_distance,
            ready => ave_ready
        );  
      
    memory: entity work.distance_mem
        port map(
            clk => clk,
            reset => reset,
            update => ave_ready,
            distance_in => ave_distance,
            
            read_a => scope_read,
            address_a => scope_address,
            distance_a => scope_distance,
            ready_a => scope_ready,
            
            read_b => vga_read,
            address_b => vga_address,
            distance_b => vga_distance,
            ready_b => vga_ready
        );
    
    graph: entity work.scope_plot
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
            update => ave_ready,
            start => d_buttons(2),
            distance => scope_distance,
            address => scope_address,
            mem_read => scope_read,
            mem_ready => scope_ready,
            pwm => pwm,
            test_pwm_value => open
        );
        
    vga: entity work.vga_module
        port map(
            clk => clk,
            reset => reset,
            update => ave_ready,
            
            btn_u => d_buttons(1),
            btn_d => d_buttons(4),
            btn_r => d_buttons(3),
            tennis => d_switches(0),
            sw2 => d_switches(1),
            
            mem_read => vga_read,
            address => vga_address,
            distance => vga_distance,
            mem_ready => vga_ready,
            
            live_distance => conv_distance,
            
            red => red,
            green => green,
            blue => blue,
            hsync => hsync,
            vsync => vsync,
            anodes => anodes,
            cathodes => cathodes
        );
end;
