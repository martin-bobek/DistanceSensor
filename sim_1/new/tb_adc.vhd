library ieee;
use ieee.std_logic_1164.all;

entity tb_adc is end;

architecture behavioural of tb_adc is
    component adc
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
    
    constant clk_period: time := 1ns;
    
    constant period: positive := 5;
    constant bits: positive := 4;
    
    signal clk: std_logic := '1';
    signal reset: std_logic := '1';
    signal sample: std_logic;
    signal feedback: std_logic;
    signal voltage: std_logic_vector(bits - 1 downto 0);
    signal ready: std_logic;
begin
    analog: adc
        generic map(
            period => period,
            bits => bits
        )
        port map(
            clk => clk,
            reset => reset,
            sample => sample,
            feedback => feedback,
            voltage => voltage,
            ready => ready
        );
        
    process begin
        sample <= '0';
        wait for 3*period*clk_period;
        sample <= '1';
        wait for 2*period*clk_period;
        sample <= '0';
        wait for 5*period*clk_period;
        sample <= '1';
        wait for 4*period*clk_period;
    end process;
    
    reset <= '0' after 5*clk_period/2;
    clk <= not clk after clk_period/2; 
end;