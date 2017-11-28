package functions is
    function max(num1: positive; num2: positive) return positive;
end;

package body functions is
    function max(num1: positive; num2: positive) return positive is begin
        if (num1 >= num2) then
            return num1;
        else
            return num2;
        end if;
    end;
end;
