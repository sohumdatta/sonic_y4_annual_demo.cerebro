% preprocessing_batch.m: a batch-only preprocessing of channel samples
function [output] = preprocessing_batch(input)
	%% -- Notch filter
	f_0 = 60;  %US Power supply freq is 60 Hz, but Simone used 50Hz
	Q = 50;
	fs = 1000; %1KHz
	wo = f_0/(fs/2);  
	bw = wo/Q;
	[b,a] = iirnotch (wo,bw);
	output1 = filter(b, a, input);

	%% -- moving average (centering and shifting to unsigned)
	% y[n] = (x[n] + x[n-1] + ... x[n-K+1])/K; K is the window size
	% using the MATLAB filter method, b = [1/K 1/K ... <K times> ], and a = [1];
	K = 128; % the windor for moving average
	b = 1/K * ones(1,K);
	a = 1;
	output2 = filter(b, a, output1);
	output_abs = abs(output2);

	%% -- Exponential averaging (slight smoothing)
	% y[n] = alpha x[n] + (1 - alpha) y[n-1]
	% Hence, a = [1, -(1 - alpha)], b = [alpha]
	alpha = 0.99;	
	a = [1, -(1 - alpha)];
	b = [alpha];
	output = filter(b, a, output_abs);

end %notch_filter
