library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_distance_rom is end;

architecture behavioral of tb_distance_rom is
    component distance_rom is
        generic(
            voltage_size:       integer := 12;
            distance_size:      integer := 12;
            starting_voltage:   integer := 521
        );
        port(
            clk:        in std_logic;
            ready:      in std_logic;
            voltage:    in std_logic_vector(voltage_size - 1 downto 0);
            distance:   out std_logic_vector(distance_size - 1 downto 0)
        );
    end component; 

    constant clk_period: time := 1ns;

    signal clk : std_logic := '1';
    signal ready : std_logic;
    signal voltage : std_logic_vector (11 downto 0);
    signal distance : std_logic_vector (11 downto 0);
 begin
       
    uut: distance_rom
        port map(
            clk => clk,
            ready => ready,
            voltage => voltage,
            distance => distance
        );
    
    voltagechange: process begin
        --should give about 30 cm
        voltage <= std_logic_vector(to_unsigned(521,12));
        wait for 10ns;
        -- should give about 4 cm
        voltage <= std_logic_vector(to_unsigned(3387,12));
        wait for 10ns;
        -- should give about 7.75 cm
        voltage <= std_logic_vector(to_unsigned(2000,12));
        wait for 10ns;
    end process;    
     
    process begin
        ready <= '1';
        wait for clk_period;
        ready <= '0';
        wait for 9*clk_period;
    end process;

    clk <= not clk after clk_period/2;
end Behavioral;
