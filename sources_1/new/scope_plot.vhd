library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

entity scope_plot is
    generic(
        pwm_width: positive;
        trig_pulse: positive;
        blank_period: positive;
        ramp_period: positive;
        distance_width: positive;
        mem_length: positive
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        start: in std_logic;
        distance: in std_logic_vector(distance_width - 1 downto 0);
        address: out std_logic_vector(width(mem_length - 1) - 1 downto 0);
        mem_read: out std_logic;
        mem_ready: in std_logic;
        pwm: out std_logic;
        test_pwm_value: out std_logic_vector(pwm_width - 1 downto 0)
    );
end;

architecture behavioral of scope_plot is
    component pwm_gen is
        generic(
            width: positive
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            input: in std_logic_vector(width - 1 downto 0);
            output: out std_logic;
            update: out std_logic
        );
    end component;
    
    component ramp is
        generic(
            period: positive;
            distance_width: positive;
            pwm_width: positive
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            pwm_update: in std_logic;
            value_last: in std_logic_vector(distance_width - 1 downto 0);
            value_next: in std_logic_vector(distance_width - 1 downto 0);
            output: out std_logic_vector(pwm_width - 1 downto 0);
            update: out std_logic
        );
    end component;
    
    type state_type is (idle, sync, trigger, waveform, terminate);
    
    constant address_width: positive := width(mem_length - 1);
    constant counter_width: positive := max(width(blank_period), width(trig_pulse - 1));
    
    signal state: state_type;
    signal pwm_update, ramp_update: std_logic;
    signal pwm_value, ramp_value: std_logic_vector(pwm_width - 1 downto 0);
    signal value_last, value_next: std_logic_vector(distance_width - 1 downto 0);
    signal counter: unsigned(counter_width - 1 downto 0);
    signal i_address: unsigned(address_width - 1 downto 0);
    signal hold: std_logic;
begin
    test_pwm_value <= pwm_value;
    address <= std_logic_vector(i_address);
    pwm_value <= (others => '1') when (state = trigger) else ramp_value;

    dac: pwm_gen
        generic map(
            width => pwm_width
        )
        port map(
            clk => clk,
            reset => reset,
            input => pwm_value,
            output => pwm,
            update => pwm_update
        );
        
    ramp_gen: ramp
        generic map(
            period => ramp_period,
            distance_width => distance_width,
            pwm_width => pwm_width
        )
        port map(
            clk => clk,
            reset => reset,
            pwm_update => pwm_update,
            value_last => value_last,
            value_next => value_next,
            output => ramp_value,
            update => ramp_update
        );
    
    process(clk, reset) begin
        if (reset = '1') then
            state <= idle;
            counter <= (others => '0');
            i_address <= (others => '0');
            value_last <= (others => '0');
            value_next <= (others => '0');
            hold <= '0';
        elsif rising_edge(clk) then
            mem_read <= '0';
            case state is
                when idle =>
                    if (start = '1') then
                        i_address <= to_unsigned(mem_length - 1, address_width);
                        mem_read <= '1';
                        state <= sync;
                    end if;
                when sync =>
                    if (ramp_update = '1') then
                        counter <= to_unsigned(trig_pulse - 1, counter_width);
                        state <= trigger;
                    end if;
                when trigger =>
                    if (counter = 1) then
                        if (pwm_update = '1') then
                            if (hold = '0') then
                                value_last <= distance;
                                if (update = '0') then
                                    i_address <= i_address - 1;
                                end if;
                            end if;
                            hold <= '0';
                            counter <= counter - 1;
                        elsif (update = '1') then
                            hold <= '1';
                            value_last <= distance;
                        end if;
                    elsif (counter = 0) then
                        if (pwm_update = '1') then
                            state <= waveform;
                            value_next <= distance;
                            if (update = '0') then
                                i_address <= i_address - 1;
                            end if;
                        elsif (update = '1') then
                            i_address <= i_address + 1;
                        end if;
                    elsif (pwm_update = '1') then
                        counter <= counter - 1;     
                    end if;
                when waveform => 
                    if (ramp_update = '1') then
                        value_last <= value_next;
                        value_next <= distance;
                        if (update = '0') then
                            if (i_address = 0) then
                                state <= terminate;
                                counter <= (others => '0');
                            else
                                i_address <= i_address - 1;
                            end if;
                        end if;
                    elsif (update = '1') then
                        i_address <= i_address + 1;
                    end if;
                when terminate =>
                    if (ramp_update = '1') then
                        if (counter = blank_period) then
                            state <= idle;
                        else
                            counter <= counter + 1;
                        end if;
                        value_last <= (others => '0');
                        value_next <= (others => '0');
                    end if; 
            end case;
        end if;
    end process;
end;
