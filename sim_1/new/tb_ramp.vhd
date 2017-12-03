library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity tb_ramp is end;

architecture behavioural of tb_ramp is
    component ramp is
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
    end component;
    
    constant clk_period: time := 1ns;
    
    constant period: positive := 3125;
    constant period_width: positive := width(period);
    constant distance_width: positive := 12;
    constant pwm_width: positive := 7;
    
    signal clk: std_logic := '1';
    signal reset: std_logic := '1';
    signal pwm_update: std_logic;
    signal value_last, value_next: std_logic_vector(distance_width - 1 downto 0);
    signal output: std_logic_vector(pwm_width - 1 downto 0);
    signal update: std_logic;
    
    constant num_inputs: natural := 10;
    type input_array is array(0 to num_inputs - 1) of natural;
    constant inputs: input_array := (512, 2456, 0, 4095, 1534, 123, 985, 3452, 2356, 2300);
    signal i_last: natural := 0;
    signal i_next: natural := 1;
begin
    uut: ramp
        generic map(
            period => period,
            distance_width => distance_width,
            pwm_width => pwm_width
        )
        port map(
            clk => clk,
            reset => reset,
            pwm_update => pwm_update,
            value_last => value_last,
            value_next => value_next,
            output => output,
            update => update
        );
    
    process(clk, reset) begin
        if (reset = '1') then
            value_last <= (others => '0');
            value_next <= (others => '0');
        elsif rising_edge(clk) and (update = '1') then
            value_last <= std_logic_vector(to_unsigned(inputs(i_last), distance_width));
            value_next <= std_logic_vector(to_unsigned(inputs(i_next), distance_width));
            
            if (i_last + 1 = num_inputs) then
                i_last <= 0;
            else
                i_last <= i_last + 1;
            end if;
            
            if (i_next + 1 = num_inputs) then
                i_next <= 0;
            else
                i_next <= i_next + 1;
            end if;
        end if;
    end process;
    
    process begin
        pwm_update <= '1';
        wait for clk_period;
        pwm_update <= '0';
        wait for 6*clk_period;
    end process;
        
    reset <= '0' after 5*clk_period/2;
    clk <= not clk after clk_period/2;
end;
