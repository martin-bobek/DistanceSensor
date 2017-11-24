library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity scope_plot is
    generic(
        pwm_width: integer;
        distance_size: integer;
        address_size: integer;
        mem_length: integer
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        distance: in std_logic_vector(distance_size downto 0);
        address: out std_logic_vector(address_size downto 0);
        pwm: out std_logic
    );
end;

architecture behavioral of scope_plot is
    component pwm_gen is
        generic(
            width: integer
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            input: in std_logic_vector(width - 1 downto 0);
            output: out std_logic;
            update: out std_logic
        );
    end component;
begin
    dac: pwm_gen
        generic map(
            width => pwm_width
        )
        port map(
            clk => clk,
            reset => reset,
            input => ,
            output => pwm,
            update => 
        );
        
    
end;
