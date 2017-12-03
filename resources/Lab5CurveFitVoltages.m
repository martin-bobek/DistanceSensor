function Lab5CurveFitVoltages
    analogVoltage = [2.73 2.35 2.02 1.775 1.56 1.4 1.26 1.06 0.93 0.81 0.73 0.65 0.52 0.42];
    distanceCm = [4 5 6 7 8 9 10 12 14 16 18 20 25 30];

    % fittedCurve = cftool(analogVoltage,distanceCm);

    n_i = 12;
    n_o = 12;
    sig = 5;
    
    F = @(v) (15.51.*v.^(-0.8618) - 2.529);
    V = linspace(0, 3.3, 2^n_i);
    d_original = F(V)*2^(n_o - sig);
    d_rounded = round(d_original, 0);
    d_saturated = min(d_rounded, 2^n_o - 1);
    d_binary = de2bi(d_saturated, n_o);

    fid = fopen('Curve.coe','wt');
    fprintf(fid, 'memory_initialization_radix = 2;\n');
    fprintf(fid, 'memory_initialization_vector =\n');
    for index = 2^n_i:-1:1
        fprintf(fid, '%d', d_binary(index,end:-1:1));
        if (index == 1)
            fprintf(fid, ';\n');
        else
            fprintf(fid, ',\n');
        end
    end
    fclose(fid);
end

function Bi = de2bi(De, n)
    Bi = zeros(length(De), n);
    for bit = 1:n
        Bi(:,bit) = round(mod(De,2),0);
        De = floor((De + 0.25)/2);
    end
end