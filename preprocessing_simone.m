% preprocessing_simone.m: exact preprocessing (batch) used by Simone without offset cancellation
function [filtrato] = preprocessing_simone (in)
	f_0 = 60; % 60 Hz for the US
	Q = 50;
	fs = 1000; %1KHz
	wo = f_0/(fs/2);  bw = wo/Q;
	[b,a] = iirnotch(wo,bw);
	signal_filt = filter (b, a, in);
	
	
	data_abs= abs(signal_filt);
	
	filt_prev = 0;
	adc_raw = 0;
	buf_prev = 0;
	filtrato = zeros(length(data_abs(:,1)),1);
	 
	 
	for i = 2 : length(data_abs(:,1))
	     cur = buf_prev; %cur = filtrato(i-1);
	    filtrato(i) = filtroesponenziale_abbas(data_abs(i-1,1), cur);
	    buf_prev = filtrato(i);
	end
	 
end
 
