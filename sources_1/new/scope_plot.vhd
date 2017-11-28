library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.functions.all;

entity scope_plot is
    generic(
        pwm_width: positive;
        trig_pulse: positive;
        trig_width: positive;
        blank_period: positive;
        blank_width: positive;
        ramp_period: positive;
        ramp_period_width: positive;
        distance_size: positive;
        address_size: positive;
        mem_length: positive
    );
    port(
        clk: in std_logic;
        reset: in std_logic;
        update: in std_logic;
        start: in std_logic;
        distance: in std_logic_vector(distance_size - 1 downto 0);
        address: out std_logic_vector(address_size - 1 downto 0);
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
            period_width: positive;
            distance_size: positive;
            pwm_width: positive
        );
        port(
            clk: in std_logic;
            reset: in std_logic;
            pwm_update: in std_logic;
            value_last: in std_logic_vector(distance_size - 1 downto 0);
            value_next: in std_logic_vector(distance_size - 1 downto 0);
            output: out std_logic_vector(pwm_width - 1 downto 0);
            update: out std_logic
        );
    end component;
    
    type state_type is (idle, sync, trigger, waveform, terminate);
    
    signal state: state_type;
    signal pwm_update, ramp_update: std_logic;
    signal pwm_value, ramp_value: std_logic_vector(pwm_width - 1 downto 0);
    signal value_last, value_next: std_logic_vector(distance_size - 1 downto 0);
    signal counter: unsigned(max(blank_width, trig_width) - 1 downto 0);
    signal i_address: unsigned(address_size - 1 downto 0);
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
            period_width => ramp_period_width,
            distance_size => distance_size,
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
        elsif rising_edge(clk) then
            case state is
                when idle =>
                    if (start = '1') then
                        i_address <= to_unsigned(mem_length - 1, address_size);
                        state <= sync;
                    end if;
                when sync =>
                    if (ramp_update = '1') then
                        counter <= to_unsigned(trig_pulse - 1, max(blank_width, trig_width));
                        state <= trigger;
                    end if;
                when trigger =>
                    if (pwm_update = '1') then
                        if (counter = 1) then
                            value_last <= distance;
                            if (update = '0') then
                                i_address <= i_address - 1;
                            end if;
                            counter <= counter - 1;
                        elsif (counter = 0) then
                            state <= waveform;
                            value_next <= distance;
                            if (update = '0') then
                                i_address <= i_address - 1;
                            end if;
                        else
                            counter <= counter - 1;     
                        end if;
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
