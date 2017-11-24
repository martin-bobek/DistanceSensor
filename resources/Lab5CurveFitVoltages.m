analogVoltage = [2.73 2.35 2.02 1.775 1.56 1.4 1.26 1.06 0.93 0.81 0.73 0.65 0.52 0.42];
distanceCm = [4 5 6 7 8 9 10 12 14 16 18 20 25 30];

length(distanceCm)
length(analogVoltage)

%fittedCurve = cftool(analogVoltage,distanceCm);

curveFunc = @(v) 100.*(15.51.*v.^(-0.8618) - 2.529);

stepSize = (3.30)/(2^12-1);

analogVoltage12bits = 0.42 : stepSize : 2.73;

fittedVals = curveFunc(analogVoltage12bits);

fid = fopen('Curve.txt','wt');
fittedMatrix = zeros(2867,12);
for index = 1 : (2^12)*0.7
    fittedVals(index) = round(fittedVals(index),0);
    binaryfittedVals = de2bi(fittedVals(index),12);
    for bit = 1 : 12
        fittedMatrix(index, (bit)) = binaryfittedVals(13-bit);
        fprintf(fid, '%d', fittedMatrix(index,bit));
    end
    fprintf(fid, '\n');
end
fclose(fid);

b = de2bi(23)
