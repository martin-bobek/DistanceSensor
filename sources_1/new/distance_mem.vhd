library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity distance_mem is 
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        distance_in: in std_logic_vector(11 downto 0);
        
        read_a: in std_logic;
        address_a: in std_logic_vector(9 downto 0);
        distance_a: out std_logic_vector(11 downto 0);
        ready_a: out std_logic;
        
        read_b: in std_logic;
        address_b: in std_logic_vector(9 downto 0);
        distance_b: out std_logic_vector(11 downto 0);
        ready_b: out std_logic
    );
end;

architecture behavioural of distance_mem is
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
    end component;
    
    constant mem_length: positive := 600;
    constant top_addr: unsigned(9 downto 0) := to_unsigned(mem_length - 1, 10);
    
    signal v_update: std_logic_vector(0 downto 0);
    signal write_addr: unsigned(9 downto 0);
    signal read_addr: unsigned(9 downto 0);
    signal distance_out: std_logic_vector(11 downto 0);
    
    signal latch_a, latch_b: std_logic;
    signal allow_hold_a, hold_a: std_logic;
    signal allow_hold_b, hold_b: std_logic;
    signal hold: std_logic;
    signal latch_update: std_logic;
    signal c_address_a, c_address_b: unsigned(9 downto 0);
    signal sum_address_a, sum_address_b: unsigned(10 downto 0);
    signal mem_address_a, mem_address_b: unsigned(9 downto 0);
    signal dist_hold_a, dist_hold_b: std_logic_vector(11 downto 0);
    signal i_ready_a, i_ready_b: std_logic;
begin
    dist_buffer: ring_buffer
        port map(
            clka => clk,
            wea => v_update,
            addra => std_logic_vector(write_addr),
            dina => distance_in,
            clkb => clk,
            rstb => reset,
            addrb => std_logic_vector(read_addr),
            doutb => distance_out
        );
    
    sum_address_a <= ('0' & c_address_a) + write_addr;
    sum_address_b <= ('0' & c_address_b) + write_addr;
    mem_address_a <= resize(sum_address_a, 10) when (sum_address_a <= top_addr) else resize(sum_address_a - (top_addr + 1), 10);
    mem_address_b <= resize(sum_address_b, 10) when (sum_address_b <= top_addr) else resize(sum_address_b - (top_addr + 1), 10);
    
    ready_a <= i_ready_a;
    ready_b <= i_ready_b;
    distance_a <= distance_out when (i_ready_a = '1') else dist_hold_a;
    distance_b <= distance_out when (i_ready_b = '1') else dist_hold_b;
    
    process(clk, reset) begin
        if (reset = '1') then
            write_addr <= top_addr;
            latch_update <= '0';
            v_update(0) <= '0';
        elsif rising_edge(clk) then
            v_update(0) <= '0';
            if (hold = '1') and (update = '1') then
                latch_update <= '1';
            elsif (hold = '0') and ((update = '1') or (latch_update = '1')) then
                latch_update <= '0';
                v_update(0) <= '1';
                write_addr <= write_addr - 1;
                if (write_addr = 0) then
                    write_addr <= top_addr;
                end if;
            end if;
        end if;
    end process;
    
    read_addr <= mem_address_a when (latch_a = '1') else mem_address_b;
    hold_a <= allow_hold_a and (read_a and not latch_a); 
    hold_b <= allow_hold_b and ((read_b and not latch_b) or (latch_b and not (not v_update(0) and not latch_a)));
    hold <= hold_a or hold_b;
    
    process(clk, reset) begin
        if (reset = '1') then
            c_address_a <= (others => '0');
            c_address_b <= (others => '0');
            i_ready_a <= '0';
            i_ready_b <= '0';
            latch_a <= '0';
            latch_b <= '0';
            dist_hold_a <= (others => '0');
            dist_hold_b <= (others => '0');
        elsif rising_edge(clk) then
            if (read_a = '1') then
                c_address_a <= unsigned(address_a);
                latch_a <= '1';
            end if;
            
            if (read_b = '1') then
                c_address_b <= unsigned(address_b);
                latch_b <= '1';
            end if;
            
            if (latch_a = '0') and (latch_b = '0') then
                allow_hold_a <= '1';
                allow_hold_b <= '1';
            end if;
            if (update = '1') and (read_b = '0') then
                allow_hold_b <= '0';
            end if;
            if (update = '1') and (read_a = '0') then
                allow_hold_a <= '0';
            end if;
            
            if (v_update(0) = '0') then
                if (latch_a = '1') then
                    latch_a <= '0';
                    i_ready_a <= '1';
                elsif (latch_b = '1') then
                    latch_b <= '0';
                    i_ready_b <= '1';
                end if;
            end if;
            
            if (i_ready_a = '1') then
                i_ready_a <= '0';
                dist_hold_a <= distance_out;
            end if;
            
            if (i_ready_b = '1') then
                i_ready_b <= '0';
                dist_hold_b <= distance_out;
            end if;
        end if;
    end process;
end;