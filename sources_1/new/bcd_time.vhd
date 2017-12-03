library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity bcd_time is
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        frame: in std_logic;
        up: in std_logic;
        down: in std_logic;
        print_index: in std_logic_vector(width(10) - 1 downto 0);
        ten_minutes: out std_logic_vector(3 downto 0);
        minutes: out std_logic_vector(3 downto 0);
        ten_seconds: out std_logic_vector(3 downto 0);
        seconds: out std_logic_vector(3 downto 0)
    );
end;

architecture behavioural of bcd_time is
    component time_inc_dec is
        port(
            ten_min_in: in std_logic_vector(2 downto 0);
            min_in: in std_logic_vector(3 downto 0);
            ten_sec_in: in std_logic_vector(2 downto 0);
            sec_in: in std_logic_vector(3 downto 0);
            decrement: in std_logic;
            ten_min_out: out std_logic_vector(2 downto 0);
            min_out: out std_logic_vector(3 downto 0);
            ten_sec_out: out std_logic_vector(2 downto 0);
            sec_out: out std_logic_vector(3 downto 0)
        );
    end component;
    
    type bcd_entries4 is array(0 to 9) of std_logic_vector(3 downto 0);
    type bcd_entries3 is array(0 to 9) of std_logic_vector(2 downto 0);
    
    signal min, sec: bcd_entries4;
    signal ten_min, ten_sec: bcd_entries3;
    
    signal cur_min, cur_sec: std_logic_vector(3 downto 0);
    signal cur_ten_min, cur_ten_sec: std_logic_vector(2 downto 0);
    signal next_min, next_sec: std_logic_vector(3 downto 0);
    signal next_ten_min, next_ten_sec: std_logic_vector(2 downto 0);
    signal cap_min, cap_sec: std_logic_vector(3 downto 0);
    signal cap_ten_min, cap_ten_sec: std_logic_vector(2 downto 0);
    signal dec_min, dec_sec: std_logic_vector(3 downto 0);
    signal dec_ten_min, dec_ten_sec: std_logic_vector(2 downto 0);
    
    signal fill_index: unsigned(width(10) - 1 downto 0);
    constant fill_end: unsigned(width(10) - 1 downto 0) := to_unsigned(10, width(10));
begin
    inc_cur: time_inc_dec
        port map(
            ten_min_in => cur_ten_min,
            min_in => cur_min,
            ten_sec_in => cur_ten_sec,
            sec_in => cur_sec,
            decrement => '0', 
            ten_min_out => next_ten_min,
            min_out => next_min,
            ten_sec_out => next_ten_sec,
            sec_out => next_sec
        );
        
    dec_cap: time_inc_dec
        port map(
            ten_min_in => cap_ten_min,
            min_in => cap_min,
            ten_sec_in => cap_ten_sec,
            sec_in => cap_sec,
            decrement => '1', 
            ten_min_out => dec_ten_min,
            min_out => dec_min,
            ten_sec_out => dec_ten_sec,
            sec_out => dec_sec
        ); 
    
    process(clk, reset) begin
        if (reset = '1') then
            cur_ten_min <= "000";
            cur_min <= "0000";
            cur_ten_sec <= "000";
            cur_sec <= "1001";
        elsif rising_edge(clk) and (update = '1') then
            cur_ten_min <= next_ten_min;
            cur_min <= next_min;
            cur_ten_sec <= next_ten_sec;
            cur_sec <= next_sec;
        end if;
    end process;
    
    process(clk, reset) begin
        if (reset = '1') then
            fill_index <= fill_end;
            cap_ten_min <= (others => '0');
            cap_min <= (others => '0');
            cap_ten_sec <= (others => '0');
            cap_sec <= (others => '0');
            ten_min <= (others => (others => '0'));
            min <= (others => (others => '0'));
            ten_sec <= (others => (others => '0'));
            sec <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if (fill_index < fill_end) then
                fill_index <= fill_index + 1;
                
                ten_min(to_integer(fill_index)) <= cap_ten_min;
                min(to_integer(fill_index)) <= cap_min;
                ten_sec(to_integer(fill_index)) <= cap_ten_sec;
                sec(to_integer(fill_index)) <= cap_sec;
                
                cap_ten_min <= dec_ten_min;
                cap_min <= dec_min;
                cap_ten_sec <= dec_ten_sec;
                cap_sec <= dec_sec;
            end if;
            
            if (frame = '1') then
                fill_index <= (others => '0');
                cap_ten_min <= cur_ten_min;
                cap_min <= cur_min;
                cap_ten_sec <= cur_ten_sec;
                cap_sec <= cur_sec;
            end if;
        end if;
    end process;
    
    process(ten_min, min, ten_sec, sec, print_index) begin
        ten_minutes <= '0' & ten_min(to_integer(unsigned(print_index)));
        minutes <= min(to_integer(unsigned(print_index)));
        ten_seconds <= '0' & ten_sec(to_integer(unsigned(print_index)));
        seconds <= sec(to_integer(unsigned(print_index)));
    end process;
end;
