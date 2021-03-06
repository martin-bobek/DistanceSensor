function Inches
   Dist_cm = 0:(1/2^7):(2^5 - 1/2^7);
   Dist_in = 0.393701*Dist_cm;
   dist_str = int32(round(100*Dist_in));
   hundredths = rem(dist_str,10);
   dist_str = idivide(dist_str,10,'floor');
   tenths = rem(dist_str,10);
   dist_str = idivide(dist_str,10,'floor');
   ones = rem(dist_str,10);
   dist_str = idivide(dist_str,10,'floor');
   tens = rem(dist_str,10);
   
   hundredths_b = de2bi(hundredths,4);
   tenths_b = de2bi(tenths,4);
   ones_b = de2bi(ones,4);
   tens_b = de2bi(tens,1);
   
   fid = fopen('Inches.coe','wt');
   fprintf(fid, 'memory_initialization_radix = 2;\n');
   fprintf(fid, 'memory_initialization_vector =\n');
   for index = 1:2^12
        fprintf(fid, '%d', tens_b(index));
        fprintf(fid, '%d', ones_b(index,end:-1:1));
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
