library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package records is
    type time_v is record
        ten_min: std_logic_vector(2 downto 0);
        min: std_logic_vector(3 downto 0);
        ten_sec: std_logic_vector(2 downto 0);
        sec: std_logic_vector(3 downto 0);
    end record;
    
    type time_u is record
        ten_min: unsigned(2 downto 0);
        min: unsigned(3 downto 0);
        ten_sec: unsigned(2 downto 0);
        sec: unsigned(3 downto 0);
    end record;
    
    function to_unsigned(conv: time_v) return time_u;
    function to_vector(conv: time_u) return time_v;
end;

package body records is
    function to_unsigned(conv: time_v) return time_u is 
        variable output: time_u;
    begin
        output.ten_min := unsigned(conv.ten_min);
        output.min := unsigned(conv.min);
        output.ten_sec := unsigned(conv.ten_sec);
        output.sec := unsigned(conv.sec);
        return output;
    end;
    
    function to_vector(conv: time_u) return time_v is 
        variable output: time_v;
    begin
        output.ten_min := std_logic_vector(conv.ten_min);
        output.min := std_logic_vector(conv.min);
        output.ten_sec := std_logic_vector(conv.ten_sec);
        output.sec := std_logic_vector(conv.sec);
        return output;
    end;
end;
