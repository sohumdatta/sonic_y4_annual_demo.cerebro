function [filtrato] = preprocessing_simone_cancel_offset (in)
f_0 = 60; % 60 Hz for the US
Q = 50;
fs = 1000; %1KHz
wo = f_0/(fs/2);  bw = wo/Q;
[b,a] = iirnotch(wo,bw);
signal_filt = filter (b, a, in);

filtrato = diff_to_env(signal_filt);

end
 