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
	[b,a] = iirnotch (wo,bw);
	L = max(length(a), length(b));	% maximum past states reqd for stream filtering
	
	n_samples = size(entireRawData, 1);
	
	if (n_samples == 0) 
		% the the fz_notch is empty, this the first batch
		f1Output = filter (b, a, rawData);
	else
		if(~all(size(entireFilteredData, 1) == size(entireRawData))) 
			error('entireFilteredData and entireRawData have different sizes');
		end
	
		NUM_CHANNELS = size(entireRawData, 2);
	
		if((chID <= 0) || (chID > NUM_CHANNELS)) 
			error('chID passed is either <= 0 or > NUM_CHANNELS);
		end
	
		x_prev = flip(entireRawData(:, n_samples - L + 1 : n_samples));
		y_prev = flip(entireFilteredData(:, n_samples - L + 1 : n_samples));
	
		fz = filtic(b, a, y_prev, x_prev);	%calculate the previous delay conditions	
		f1Output = filter(b, a, rawData, fz);	%calculate output and update delay vals
	end %if (isempty(fz_notch)) 
	
	%% -- Moving average filter
	BUFFER_SIZE = 128;
	favgOutput = []; buffer = [];
	for i = 1:length(f1Output)
	    if(i <= BUFFER_SIZE)
	        buffer = [buffer, rawData(i)];
	    else
	        buffer = [buffer(2:BUFFER_SIZE), rawData(i)];
	    end
	    favgOutput(i) = f1Output(i) - mean(buffer);
	end
	f2Output = abs (favgOutput);
	f3Output = v0_filtroesponenziale (0.99, f2Output);
	
end %preprocessing
