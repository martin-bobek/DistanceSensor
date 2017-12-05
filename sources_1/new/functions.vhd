package functions is
    function max(num1: positive; num2: positive) return positive;
    function width(max_val: positive) return positive;
end;

package body functions is
    function max(num1: positive; num2: positive) return positive is begin
        if (num1 >= num2) then
            return num1;
        else
            return num2;
        end if;
    end;
    
    function width(max_val: positive) return positive is
        variable bits: positive := 1;
        variable val: natural := max_val / 2;  
    begin
        while (val /= 0) loop
            bits := bits + 1;
            val := val / 2;
        end loop;
        
        return bits;
    end;
end;
