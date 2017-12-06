function Centimeters
   Dist_cm = 0:(1/2^7):(1 - 1/2^7);
   dist_str = int32(round(100*Dist_cm));
   hundredths = rem(dist_str,10);
   dist_str = idivide(dist_str,10,'floor');
   tenths = rem(dist_str,10);
   
   hundredths_b = de2bi(hundredths,4);
   tenths_b = de2bi(tenths,4);
   
   fid = fopen('Centimeters.coe','wt');
   fprintf(fid, 'memory_initialization_radix = 2;\n');
   fprintf(fid, 'memory_initialization_vector =\n');
   for index = 1:2^7
        fprintf(fid, '%d', tenths_b(index,end:-1:1));
        fprintf(fid, '%d', hundredths_b(index,end:-1:1));
        if (index == 2^12)
            fprintf(fid, ';\n');
        else
            fprintf(fid, ',\n');
        end
    end
    fclose(fid);
end
