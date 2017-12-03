library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_level_prod_dsp is end;

architecture behavioural of tb_level_prod_dsp is 
    component level_prod_dsp is
        port(
            clk: in std_logic;
            a: in std_logic_vector(7 downto 0);
            p: out std_logic_vector(17 downto 0)
        );
    end component;
    
    constant clk_period: time := 1ns;
    
    signal clk: std_logic := '1';
    signal a: unsigned(7 downto 0) := (others => '0');
    signal p: std_logic_vector(17 downto 0);
begin
    uut: level_prod_dsp
        port map(
            clk => clk,
            a => std_logic_vector(a),
            p => p
        );
    
    a <= a + 1 after 5*clk_period;
    clk <= not clk after clk_period/2;
end;
