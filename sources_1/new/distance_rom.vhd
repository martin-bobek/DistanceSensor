library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

entity distance_rom is
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
end;

architecture behavioral of distance_rom is
    type rom_t is array(0 to 2**voltage_size - 1) of std_logic_vector(distance_size - 1 downto 0);
           
    impure function init_lut (filename : in string) return rom_t is
        file file_pointer : text open read_mode is filename;
        variable variable_rom : rom_t := (others => (others => '0'));
        variable current_distance : std_logic_vector(distance_size - 1 downto 0);
        variable line_num: line;
        variable voltage_val : integer := starting_voltage; --index of the voltage for about 30 cm
    begin  
        while not endfile(file_pointer) loop
            
            readline(file_pointer,line_num);
            read(line_num, current_distance);
            
            variable_rom(voltage_val) := current_distance; 
            
            voltage_val := voltage_val + 1;
        end loop;
        
        return variable_rom;
    end function;
     
    constant rom : rom_t := init_lut("../../resources/Curve.txt");     
    
begin
    process(clk) begin
        if rising_edge(clk) and (ready = '1') then
            distance <= rom(to_integer(unsigned(voltage)));
        end if;
    end process;
end;
