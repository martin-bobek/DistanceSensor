library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_distance_rom is end;

architecture behavioral of tb_distance_rom is
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

    constant clk_period: time := 1ns;
    
    constant adc_bits: positive := 12;
    constant distance_width: positive := 12;

    signal clk: std_logic := '1';
    signal reset: std_logic := '1';
    signal update: std_logic := '0';
    signal u_voltage: unsigned(adc_bits - 1 downto 0) := (others => '1');
    signal distance: std_logic_vector (distance_width - 1 downto 0);
    signal ready: std_logic;
 begin
    
    uut: distance_rom
        generic map(
            adc_bits => adc_bits,
            distance_width => distance_width
        )
        port map(
            clk => clk,
            reset => reset,
            update => update,
            voltage => std_logic_vector(u_voltage),
            distance => distance,
            ready => ready
        );
    
    process begin
        wait for 5*clk_period;
        loop
            update <= '1';
            u_voltage <= u_voltage + 1;
            wait for clk_period;
            update <= '0';
            wait for 4*clk_period;
        end loop;
    end process;
    
    reset <= '0' after 5*clk_period/2;
    clk <= not clk after clk_period/2;
end Behavioral;
