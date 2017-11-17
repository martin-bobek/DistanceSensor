library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity distance_sensor is
    port(
        clk: in std_logic;
        reset: in std_logic;
        input: in std_logic;
        feedback: out std_logic;
        led: out std_logic_vector(11 downto 0)
    );
end;

architecture behavioural of distance_sensor is
    component adc is
        port(
            clk: in std_logic;
            reset: in std_logic;
            sample: in std_logic;
            feedback: out std_logic;
            output: out std_logic_vector(11 downto 0)
        );
    end component;
begin
    analog: adc
        port map(
            clk => clk,
            reset => reset,
            sample => input,
            feedback => feedback,
            output => led
        );
end;
