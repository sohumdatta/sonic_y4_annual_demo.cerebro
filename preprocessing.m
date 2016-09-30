% preprocessing.m : preprocessor to filter raw data through a notch and smoothing, per channel.
% rawData is a 1D array containing channel values, MUST be >= 10 (not checked).
% chID is the channel number of the rawData passed.
function [f3Output] = preprocessing (rawData, chID)
	
	global entireRawData;	% all of the RAW values, each column containing a channel
	global entireFilteredData;	% filtered values of entire run, each column a channel
	global movingAverageBuffer;

	MOVING_AVERAGE_BUFFER_SIZE = 128;	%moving average buffer, expanded and used only here
		
	%% -- Notch filter
	f_0 = 60;  %US Power supply freq is 60 Hz, but Simone used 50Hz
	Q = 60;
	fs = 1000; %1KHz
	wo = f_0/(fs/2);  
	bw = wo/Q;
	[b,a] = iirnotch (wo,bw);
	L = max(length(a), length(b));	% maximum past states reqd for stream filtering
	
	if(~isequal(size(entireFilteredData), size(entireRawData))) 
		error('entireFilteredData and entireRawData have different sizes');
	end
	n_samples = size(entireRawData, 1);

	x_prev = []; y_prev = [];
	if(n_samples > 0)
		x_prev = entireRawData(n_samples - L + 1 : n_samples, chID);
		y_prev = entireFilteredData(n_samples - L + 1 : n_samples, chID);
	end  %if(n_samples > 0)

	f1Output = sample_filter(b, a, rawData, x_prev, y_prev);	


	%% -- Moving average filter
	favgOutput = []; 
	for i = 1:length(rawData)
		%TODO: May need to move this statement at the end of for loop
    	favgOutput(i) = f1Output(i) - mean(movingAverageBuffer(:,chID));
		
	    if(size(movingAverageBuffer, 1) < MOVING_AVERAGE_BUFFER_SIZE)
    	    movingAverageBuffer(:, chID) = [movingAverageBuffer(:,chID); rawData(i)];
    	else
       		movingAverageBuffer(:, chID) = [movingAverageBuffer(2:MOVING_AVERAGE_BUFFER_SIZE, chID); rawData(i)];
    	end
	end
	f2Output = abs(favgOutput);
	f3Output = v0_filtroesponenziale (0.99, f2Output);
	
end %preprocessing
