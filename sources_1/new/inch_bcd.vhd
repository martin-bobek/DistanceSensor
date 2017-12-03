library ieee;
use ieee.std_logic_1164.all;

entity inch_bcd is
    port(
        clk: in std_logic;
        reset: in std_logic;
        mem_ready: in std_logic;
        distance: in std_logic_vector(11 downto 0);
        tens: out std_logic_vector(0 downto 0);
        ones: out std_logic_vector(3 downto 0);
        tenths: out std_logic_vector(3 downto 0);
        hundredths: out std_logic_vector(3 downto 0);
        ready: out std_logic  
    );
end;

architecture behavioural of inch_bcd is
    component inches_rom is
        port(
            clka: in std_logic;
            rsta: in std_logic;
            ena: in std_logic;
            addra: in std_logic_vector(11 downto 0);
            douta: out std_logic_vector(12 downto 0);
            rsta_busy: out std_logic
        );
    end component;
    
    signal bcd: std_logic_vector(12 downto 0);
begin
    tens <= bcd(12 downto 12);
    ones <= bcd(11 downto 8);
    tenths <= bcd(7 downto 4);
    hundredths <= bcd(3 downto 0);

    rom: inches_rom
        port map(
            clka => clk,
            rsta => reset,
            ena => mem_ready,
            addra => distance,
            douta => bcd,
            rsta_busy => open
        );
        
    process(clk) begin
        if (reset = '1') then
            ready <= '0';
        elsif rising_edge(clk) then
            ready <= mem_ready;
        end if;
    end process;
end;
