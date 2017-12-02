library ieee;
use ieee.std_logic_1164.all;

entity tb_ring_buffer is end;

architecture behavioural of tb_ring_buffer is
    component ring_buffer is
        port(
            clka: in std_logic;
            wea: in std_logic_vector(0 downto 0);
            addra: in std_logic_vector(9 downto 0);
            dina: in std_logic_vector(11 downto 0);
            clkb: in std_logic;
            rstb: in std_logic;
            addrb: in std_logic_vector(9 downto 0);
            doutb: out std_logic_vector(11 downto 0)
        );
    end component
    
    constant clk_period: time := 1ns;
    
    signal clk: std_logic := '1';
    signal reset: std_logic := '1';
    signal write: std_logic_vector(0 downto 0); 
    signal write_addr, read_addr: std_logic_vector(9 downto 0);
    signal write_value, read_value: std_logic_vector(11 downto 0);
    
begin
    uut: ring_buffer
        port map(
            clka => clk,
            wea => write,
            addra => write_addr,
            dina => write_value,
            clkb => clk,
            rstb => reset,
            addrb => read_addr,
            doutb => read_value
        );
        
    process begin
        write <= '0';
        write_addr <= (others => '0');
        read_addr <= (others => '0');
        write_value <= (others => '0');
        wait for 5*clk_period;
        
    end process;
        
    reset <= '0' after 5*clk_period/2;
    clk <= not clk after clk_period/2;
end;
