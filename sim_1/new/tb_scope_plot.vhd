library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_scope_plot is end;

architecture behavioural of tb_scope_plot is
    component scope_plot is
        generic(
            pwm_width: positive;
            trig_pulse: positive;
            trig_width: positive;
            blank_period: positive;
            blank_width: positive;
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
            distance: in std_logic_vector(distance_size - 1 downto 0);
            address: out std_logic_vector(address_size - 1 downto 0);
            pwm: out std_logic;
            test_pwm_value: out std_logic_vector(pwm_width - 1 downto 0)
        );
    end component;
    
    constant clk_period: time := 1ns;
    
    constant pwm_width: positive := 4;
    constant trig_pulse: positive := 10;
    constant trig_width: positive := 4;
    constant blank_period: positive := 10;
    constant blank_width: positive := 4;
    constant ramp_period: positive := 35;
    constant ramp_period_width: positive := 6;
    constant distance_size: positive := 5;
    constant address_size: positive := 4;
    constant mem_length: positive := 10;
    
    signal clk: std_logic := '1';
    signal reset: std_logic := '1';
    signal update: std_logic := '0';
    signal start: std_logic;
    signal distance: std_logic_vector(distance_size - 1 downto 0);
    signal address: std_logic_vector(address_size - 1 downto 0);
    signal pwm: std_logic;
    signal test_pwm_value: std_logic_vector(pwm_width - 1 downto 0);
    
    type input_type is array(0 to mem_length - 1) of natural;
    constant inputs: input_type := (20, 31, 0, 5, 15, 3, 28, 27, 5, 4);
    
    signal prod: unsigned(9 downto 0);
    signal mult: unsigned(4 downto 0) := "10101";
begin
    prod <= mult * 2;

    uut: scope_plot
        generic map(
            pwm_width => pwm_width,
            trig_pulse => trig_pulse,
            trig_width => trig_width, 
            blank_period => blank_period,
            blank_width => blank_width,
            ramp_period => ramp_period,
            ramp_period_width => ramp_period_width,
            distance_size => distance_size,
            address_size => address_size,
            mem_length => mem_length
        )
        port map(
            clk => clk,
            reset => reset,
            update => update,
            start => start,
            distance => distance,
            address => address, 
            pwm => pwm,
            test_pwm_value => test_pwm_value
        );
    
    process(clk, reset)
        variable u_address: unsigned(address_size - 1 downto 0);
    begin
        u_address := unsigned(address);
        if (reset = '1') then
            distance <= (others => '0');
        elsif rising_edge(clk) then
            if (u_address + 1 > mem_length) then
                distance <= (others => '0');
            else
                distance <= std_logic_vector(to_unsigned(inputs(to_integer(u_address)), distance_size));
            end if;
        end if;
    end process;
    
    process begin
        start <= '0';
        wait for 100*clk_period;
        start <= '1';
        wait for 1000*clk_period;
        start <= '0';
        wait;
    end process;
    
    reset <= '0' after 5*clk_period/2;
    clk <= not clk after clk_period/2;
end;
