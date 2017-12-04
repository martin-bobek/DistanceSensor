function Characters(input, output, height, width, true_width)
    offset = 3; %-floor(-(true_width - width)/2 + 0.25);
    fid_i = fopen(input);
    fid_o = fopen(output, 'w');
    for n = 1:height
        string = fgetl(fid_i);
        char_num = 1;
        fprintf(fid_o,'"');
        for m = 1:offset
            fprintf(fid_o,'0');
        end
        string_i = 3;
        while (char_num <= width)
            bin = de2bi(hex2dec(string(string_i:string_i+1)),8);
            bin_i = 8;
            while (bin_i ~= 0) && (char_num <= width)
                fprintf(fid_o,'%d',bin(bin_i));
                bin_i = bin_i - 1;
                char_num = char_num + 1;
            end
            string_i = string_i + 6;
        end
        for m = 1:(true_width - width - offset) 
            fprintf(fid_o,'0');
        end
        fprintf(fid_o,'",\n');
    end
    fclose(fid_i);
    fclose(fid_o);
end