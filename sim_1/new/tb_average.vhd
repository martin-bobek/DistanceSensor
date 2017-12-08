library ieee;
use ieee.std_logic_1164.all;

entity tb_average is end;

architecture behavioural of tb_average is
    component average is
        port(
            clk: in std_logic;
            reset: in std_logic;
            update: in std_logic;
            distance_in: in std_logic_vector(11 downto 0);
            distance_out: out std_logic_vector(11 downto 0);
            ready: out std_logic
        );
    end component;
    
    constant clk_period: time := 1ns;
    
    signal clk: std_logic := '1';
    signal reset: std_logic := '1';
    signal update: std_logic;
    signal distance_in: std_logic_vector(11 downto 0);
    signal distance_out: std_logic_vector(11 downto 0);
    signal ready: std_logic;
begin
    uut: average
        port map(
            clk => clk,
            reset => reset,
            update => update, 
            distance_in => distance_in,
            distance_out => distance_out,
            ready => ready
        );
        
    process begin
        update <= '1';
        wait for clk_period;
        update <= '0';
        wait for 9*clk_period;
    end process;    
    
    process begin
        distance_in <= "100100100101";
        wait for 10*clk_period;
        distance_in <= "100100100001";
        wait for 10*clk_period;
        distance_in <= "100100110101";
        wait for 10*clk_period;
        distance_in <= "100100101101";
        wait for 10*clk_period;
        distance_in <= "100100100101";
        wait for 10*clk_period;
        distance_in <= "100100110101";
        wait for 10*clk_period;
        distance_in <= "100100100111";
        wait for 10*clk_period;
        distance_in <= "100100101001";
    end process;    
    
    reset <= '0' after 5*clk_period/2;
    clk <= not clk after clk_period/2;
end;