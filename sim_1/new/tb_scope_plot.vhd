library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity tb_scope_plot is end;

architecture behavioural of tb_scope_plot is
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
    
    constant clk_period: time := 1ns;
    
    constant pwm_width: positive := 7;
    constant trig_pulse: positive := 10;
    constant blank_period: positive := 10;
    constant ramp_period: positive := 3125;
    constant distance_width: positive := 12;
    constant mem_length: positive := 10;
    constant address_width: positive := width(mem_length - 1);
    
    signal clk: std_logic := '1';
    signal reset: std_logic := '1';
    signal update: std_logic := '0';
    signal start: std_logic;
    signal distance: std_logic_vector(distance_width - 1 downto 0);
    signal address: std_logic_vector(address_width - 1 downto 0);
    signal mem_read: std_logic;
    signal mem_ready: std_logic;
    signal pwm: std_logic;
    signal test_pwm_value: std_logic_vector(pwm_width - 1 downto 0);
    
    type input_type is array(0 to 25) of natural;
    constant inputs: input_type := (10, 15, 0, 2, 7, 1, 13, 14, 3, 2, 10, 15, 0, 2, 7, 1, 14, 13, 2, 12, 2, 5, 7, 9, 15, 2);
    signal shift: natural := 0;
begin
    uut: scope_plot
        generic map(
            pwm_width => pwm_width,
            trig_pulse => trig_pulse, 
            blank_period => blank_period,
            ramp_period => ramp_period,
            distance_width => distance_width,
            mem_length => mem_length
        )
        port map(
            clk => clk,
            reset => reset,
            update => update,
            start => start,
            distance => distance,
            address => address, 
            mem_read => mem_read,
            mem_ready => mem_ready,
            pwm => pwm,
            test_pwm_value => test_pwm_value
        );
        
    process(clk, reset)
        variable u_address: unsigned(address_width - 1 downto 0);
    begin
        u_address := unsigned(address);
        if (reset = '1') then
            distance <= (others => '0');
        elsif rising_edge(clk) then
            if (update = '1') then
                shift <= shift + 1;
            end if;
        
            if (u_address + 1 > mem_length) then
                distance <= (others => '0');
            else
                distance <= std_logic_vector(to_unsigned(inputs(mem_length + shift - to_integer(u_address) - 1), distance_width));
            end if;
        end if;
    end process;
    
    process(clk, reset) begin
        if (reset = '1') then
            mem_ready <= '0';
        elsif rising_edge(clk) then
            mem_ready <= mem_read;
        end if;
    end process;
    
    process begin
        wait for 1054*clk_period;
        loop
            update <= '1';
            wait for clk_period; 
            update <= '0';
            wait for 110000*clk_period;
        end loop;
    end process;
    
    process begin
        start <= '0';
        wait for 100*clk_period;
        start <= '1';
        wait;
        wait for 1000*clk_period;
        start <= '0';
        wait;
        wait for 5000*clk_period;
        start <= '1';
        wait;
    end process;
    
    reset <= '0' after 5*clk_period/2;
    clk <= not clk after clk_period/2;
end;
