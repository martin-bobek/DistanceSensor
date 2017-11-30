library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

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
    type rom_t is array(0 to 2**adc_bits - 1) of std_logic_vector(distance_width - 1 downto 0);
           
    impure function init_lut (filename : in string) return rom_t is
        file file_pointer : text open read_mode is filename;
        variable rom : rom_t;
        variable distance : std_logic_vector(distance_width - 1 downto 0);
        variable line_num: line;
        variable voltage : natural := 0;
    begin  
        while not endfile(file_pointer) loop
            readline(file_pointer, line_num);
            read(line_num, distance);
            rom(voltage) := distance; 
            voltage := voltage + 1;
        end loop;
        
        return rom;
    end function;
     
    constant rom : rom_t := init_lut("../../resources/Curve.txt");     
    
begin
    process(clk) begin
        if (reset = '1') then
            distance <= (others => '0');
            ready <= '0';
        elsif rising_edge(clk) then
            if (update = '1') then
                distance <= rom(to_integer(unsigned(voltage)));
            end if;
            
            ready <= update;
        end if;
    end process;
end;
