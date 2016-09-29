function [f3Output] = preprocessing (rawData)
% Notch filter
f_0 = 60;
Q = 50;
fs = 1000; %1KHz
wo = f_0/(fs/2);  
bw = wo/Q;
[b,a] = iirnotch (wo,bw);
f1Output = filter (b, a, rawData);

f2Output = abs (f1Output);
f3Output = filtroesponenziale (0.99, f2Output);
end

