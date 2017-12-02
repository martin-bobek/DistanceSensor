library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_distance_mem is end;

architecture behavioural of tb_distance_mem is
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
    
    constant clk_period: time := 1ns;
    
    signal clk: std_logic := '1';
    signal reset: std_logic := '1';
    signal update: std_logic;
    signal distance_in: unsigned(11 downto 0) := (0 => '0', others => '1');
    signal address_a: std_logic_vector(9 downto 0);
    signal read_a, ready_a: std_logic;
    signal distance_a: std_logic_vector(11 downto 0);
    signal address_b: std_logic_vector(9 downto 0);
    signal read_b, ready_b: std_logic;
    signal distance_b: std_logic_vector(11 downto 0);
begin
    address_a <= (0 => '0', others => '0');
    address_b <= (1 => '0', others => '0');
    
    uut: distance_mem
        port map(
            clk => clk,
            reset => reset,
            update => update,
            distance_in => std_logic_vector(distance_in),
            
            read_a => read_a,
            address_a => address_a,
            distance_a => distance_a,
            ready_a => ready_a,
            
            read_b => read_b,
            address_b => address_b,
            distance_b => distance_b,
            ready_b => ready_b
        );
    
    process begin
        update <= '1';
        distance_in <= distance_in + 1;
        wait for clk_period;
        update <= '0';
        wait for 6*clk_period;
    end process;
    
    process begin
        read_a <= '1';
        wait for clk_period;
        read_a <= '0';
        wait for 7*clk_period;
    end process;
    
    process begin
        wait for clk_period;
        loop
            read_b <= '1';
            wait for clk_period;
            read_b <= '0';
            wait for 5*clk_period;
        end loop; 
    end process;
    
    reset <= '0' after 5*clk_period/2;
    clk <= not clk after clk_period/2;
end;
