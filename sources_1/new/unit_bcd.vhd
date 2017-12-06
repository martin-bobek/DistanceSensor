library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unit_bcd is
    port(
        clk: in std_logic;
        reset: in std_logic;
        mem_ready: in std_logic;
        inches: in std_logic;
        distance: in std_logic_vector(11 downto 0);
        tens: out std_logic_vector(3 downto 0);
        ones: out std_logic_vector(3 downto 0);
        tenths: out std_logic_vector(3 downto 0);
        hundredths: out std_logic_vector(3 downto 0);
        ready: out std_logic  
    );
end;

architecture behavioural of unit_bcd is
    component inches_rom is
        port(
            clka: in std_logic;
            rsta: in std_logic;
            addra: in std_logic_vector(11 downto 0);
            douta: out std_logic_vector(12 downto 0)
            -- rsta_busy: out std_logic
        );
    end component;
    
    component cm_rom is
        port(
            clka: in std_logic;
            rsta: in std_logic;
            addra: in std_logic_vector(6 downto 0);
            douta: out std_logic_vector(7 downto 0)
            -- rsta_busy: out std_logic
        );
    end component;
    
    signal unit_cm: std_logic_vector(5 downto 0);
    signal dec_cm: std_logic_vector(7 downto 0);
    type lut is array(0 to 2**5 - 1) of std_logic_vector(5 downto 0);
    constant unit_cm_lut: lut := (
        "000000",
        "000001",
        "000010",
        "000011",
        "000100",
        "000101",
        "000110",
        "000111",
        "001000",
        "001001",
        "010000",
        "010001",
        "010010",
        "010011",
        "010100",
        "010101",
        "010110",
        "010111",
        "011000",
        "011001",
        "100000",
        "100001",
        "100010",
        "100011",
        "100100",
        "100101",
        "100110",
        "100111",
        "101000",
        "101001",
        "110000",
        "110001");
    
    signal bcd, bcd_in, bcd_cm: std_logic_vector(15 downto 0);
begin
    tens <= bcd(15 downto 12);
    ones <= bcd(11 downto 8);
    tenths <= bcd(7 downto 4);
    hundredths <= bcd(3 downto 0);
    
    bcd <= bcd_in when (inches = '1') else bcd_cm;

    bcd_in(15 downto 13) <= "000";
    in_rom: inches_rom
        port map(
            clka => clk,
            rsta => reset,
            addra => distance,
            douta => bcd_in(12 downto 0)
            -- rsta_busy => open
        );
        
    bcd_cm <= "00" & unit_cm & dec_cm;
    cent_rom: cm_rom
        port map(
            clka => clk,
            rsta => reset,
            addra => distance(6 downto 0),
            douta => dec_cm
            -- rsta_busy => open
        );
        
    process(clk) begin
        if (reset = '1') then
            ready <= '0';
            unit_cm <= (others => '0');
        elsif rising_edge(clk) then
            ready <= mem_ready;
            unit_cm <= unit_cm_lut(to_integer(unsigned(distance(11 downto 7))));
        end if;
    end process;
end;
