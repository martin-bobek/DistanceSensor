library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Slow_clk is
	generic(
      N: integer := 4;
      M: integer := 10
   );
	port(
      clk_in, reset : in std_logic;
      slow_clock_out : out std_logic
   );
end Slow_clk;

architecture Behavioral of Slow_clk is
   signal print_right_now: unsigned(N-1 downto 0);
   signal print_next: unsigned(N-1 downto 0);
   begin
   process(clk_in, reset)
      begin
         if (reset = '1') then
            print_right_now <= (others => '0');
         elsif (clk_in'event and clk_in='1') then
            print_right_now <= print_next;
         end if;
   end process;

   print_next <= (others => '0') when print_right_now=(M-1) else print_right_now + 1;
   slow_clock_out <= '1' when print_right_now=(M-1) else '0';
end Behavioral;
------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SevenSeg_Control is
port(
		clk, reset : in std_logic;
		digit1: in std_logic_vector(2 downto 0); -- 0 - 7
		cathodes : out std_logic_vector(7 downto 0);
		anodes : out std_logic_vector(3 downto 0)
	);
end SevenSeg_Control;

 architecture Behavioral of SevenSeg_Control is

   type state_type is (idle, digit1_state,win);
   signal stateright_now, state_next : state_type; 
	
   signal led_clk_tick : std_logic;
   signal cathoderight_now, cathode_next : std_logic_vector(7 downto 0);
   signal anoderight_now, anode_next: std_logic_vector(3 downto 0);
   signal display_control : std_logic_vector(2 downto 0);
   signal display_number : std_logic_vector(7 downto 0);

begin
    -- Connect output signals
    cathodes <= not cathoderight_now; -- 0 turns on, 1 turns off
    anodes   <= not anoderight_now;

      LED_Clk_inst: entity work.Slow_clk(Behavioral)
      generic map ( N=>15, M=>25000) 
      port map (clk_in => clk, reset => reset, slow_clock_out => led_clk_tick);

	-- Numbers
	with display_control select
            display_number <=           "00111111" when "000",    -- 0
                                        "00000110" when "001",    -- 1
                                        "01011011" when "010",    -- 2
                                        "01001111" when "011",    -- 3
                                        "01100110" when "100",    -- 4
                                        "01101101" when "101",    -- 5
                                        "01111101" when "110",    -- 6
                                        "00000111" when "111",    -- 7
--                                        "01111111" when "1000",    -- 8
--                                        "01101111" when "1001",    -- 9
                                        "00000000" when others;    -- 0



   process (clk, reset) is 
      begin 
         if (reset = '1') then 
            stateright_now <= idle;
            cathoderight_now <= (others => '1'); -- '1' is off
            anoderight_now <= (others => '1');   -- '1' is off
        elsif (clk'event and clk = '1') then 
            stateright_now <= state_next;
            cathoderight_now <= cathode_next;
            anoderight_now <= anode_next;
        end if;
    end process;

   FSM_proc: process (stateright_now, cathoderight_now, anoderight_now, led_clk_tick, display_number, digit1) is 
      begin 

-- Default assignment statements
      state_next <= stateright_now;
      cathode_next <= cathoderight_now;
      anode_next <= anoderight_now;
      display_control <= "000";
        
-- FSM state processing 
      case stateright_now is 
         when digit1_state => 
            cathode_next <= display_number;
            anode_next <= "0100";
            display_control<= digit1;
            state_next <= digit1_state;
              
         when others => 
            state_next <= digit1_state;
        end case;
    end process;
	 
end Behavioral;
