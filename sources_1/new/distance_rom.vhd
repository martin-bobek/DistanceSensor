library ieee;
use ieee.std_logic_1164.all;

entity distance_rom is
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
end;

architecture behavioral of distance_rom is
    component v_to_d_rom is
        port (
            clka : in std_logic;
            rsta : in std_logic;
            ena : in std_logic;
            addra : in std_logic_vector(11 downto 0);
            douta : out std_logic_vector(11 downto 0)
        );
    end component;
begin
    rom: v_to_d_rom
        port map(
            clka => clk,
            rsta => reset,
            ena => update,
            addra => voltage,
            douta => distance
        );
        
    process(clk) begin
        if (reset = '1') then
            ready <= '0';
        elsif rising_edge(clk) then
            ready <= update;
        end if;
    end process;
end;
