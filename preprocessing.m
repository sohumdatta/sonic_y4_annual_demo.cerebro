% preprocessing.m : preprocessor to filter raw data through a notch and smoothing, per channel.
% rawData is a 1D array containing channel values, MUST be >= 10 (not checked).
% chID is the channel number of the rawData passed.
function [f3Output] = preprocessing (rawData, chID)
	
	global entireRawData;	% all of the RAW values, each column containing a channel
	global entireFilteredData;	% filtered values of entire run, each column a channel

	%% -- Notch filter
	f_0 = 60;  %US Power supply freq is 60 Hz, but Simone used 50Hz
	Q = 60;
	fs = 1000; %1KHz
	wo = f_0/(fs/2);  
	bw = wo/Q;
	[bnotch, anotch] = iirnotch (wo,bw);


	%% -- Moving average filter
	% y[n] = (x[n] + x[n-1] + ... x[n-K+1])/K; K is the window size
	% using the MATLAB filter method, b = [1/K 1/K ... <K times> ], and a = [1];
	K = 128; % the window for moving average
	bavg = 1/K * ones(1,K);
	aavg = [1];


	%% --- Combined Moving average and Notch filters
	b = conv(bnotch, bavg);
	a = conv(anotch, aavg);

	L = max(length(a), length(b));	% maximum past states reqd for stream filtering
	
	if(~isequal(size(entireFilteredData), size(entireRawData))) 
		error('entireFilteredData and entireRawData have different sizes');
	end
	n_samples = size(entireRawData, 1);

	x_prev = []; y_prev = [];
	if(n_samples > 0)
		x_prev = entireRawData(:,chID); 
		y_prev = entireFilteredData(:,chID);

		% Now remove all values except the last L ones (if so many are there)
		x_prev(1:n_samples - L) = [];
		y_prev(1:n_samples - L) = [];
	end  %if(n_samples > 0)

	f12Output = sample_filter(b, a, rawData, x_prev, y_prev);	

	fabsOutput = abs(f12Output);

	
	% Simone's imperfect exponnential average
%	f3Output = v0_filtroesponenziale (0.99, fabsOutput);
	f3Output = fabsOutput;	%TODO: remove line, uncomment above		
end %preprocessing
