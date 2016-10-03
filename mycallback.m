% mycallback.m: callback function on BytesAvailable to fetch new data, process, stores into variables for HD and plotting

function mycallback (s,event)
%	disp('mycallback entered.');   
	
	% the following global variables are already defined in the main.m
	global entireRawData;
	global entireFilteredData;
	global plottedRawData1;	
	global plottedRawData2;	
	global plottedRawData3;	
	global plottedRawData4;	
	global plottedRawData5;	
	global plottedRawData6;	
	global plottedRawData7;	
	global plottedRawData8;	
	global plottedFilteredData1;
	global plottedFilteredData2;
	global plottedFilteredData3;
	global plottedFilteredData4;
	global plottedFilteredData5;
	global plottedFilteredData6;
	global plottedFilteredData7;
	global plottedFilteredData8;
	global NUM_CHANNELS;
	global PLOT_WINDOW;


	NUM_BYTES = 22528;
    nbytes = get(s,'BytesAvailable');
    [buffer, readBytes] = fread (s, NUM_BYTES,'uint8');
    msg = sprintf ('BytesAvailable = %d; ReadByteFromFread = %d', nbytes, readBytes);
	disp(msg);
	channels = read_serial_port(buffer);   

%	hold on;
	figure(gcf);

	for j = 1:8
%    	filtered_channels(:,j) = preprocessing (channels(:,j), j);
	end
	%% Note: at this point channels and filtered_channels have each row a data 
	% time instant and each column a channel value. We want to now update the variables
	% plottedRawData and plottedFilteredData where each row is a channel and each column
	% is a time instant.
	
	% changes this packet that will be plotted
	newRawData = channels';
%	newFilteredData = filtered_channels';
	num_samples = size(newRawData, 2);

	% only retain at most the recent PLOT_WINDOW samples
	newRawData(:,1:num_samples-PLOT_WINDOW) = [];
%	newFilteredData(:,1:num_samples-PLOT_WINDOW) = [];
	num_samples = size(newRawData, 2);

	% Update rules for the plot link sources
		plottedRawData1 = [plottedRawData1(num_samples+1:end), newRawData(1,:)];
		plottedRawData2 = [plottedRawData2(num_samples+1:end), newRawData(2,:)];
		plottedRawData3 = [plottedRawData3(num_samples+1:end), newRawData(3,:)];
		plottedRawData4 = [plottedRawData4(num_samples+1:end), newRawData(4,:)];
		plottedRawData5 = [plottedRawData5(num_samples+1:end), newRawData(5,:)];
		plottedRawData6 = [plottedRawData6(num_samples+1:end), newRawData(6,:)];
		plottedRawData7 = [plottedRawData7(num_samples+1:end), newRawData(7,:)];
		plottedRawData8 = [plottedRawData8(num_samples+1:end), newRawData(8,:)];

%		plottedFilteredData1 = [plottedFilteredData1(num_samples+1:end), newFilteredData(1,:)]; 
%		plottedFilteredData2 = [plottedFilteredData2(num_samples+1:end), newFilteredData(2,:)]; 
%		plottedFilteredData3 = [plottedFilteredData3(num_samples+1:end), newFilteredData(3,:)]; 
%		plottedFilteredData4 = [plottedFilteredData4(num_samples+1:end), newFilteredData(4,:)]; 
%		plottedFilteredData5 = [plottedFilteredData5(num_samples+1:end), newFilteredData(5,:)]; 
%		plottedFilteredData6 = [plottedFilteredData6(num_samples+1:end), newFilteredData(6,:)]; 
%		plottedFilteredData7 = [plottedFilteredData7(num_samples+1:end), newFilteredData(7,:)]; 
%		plottedFilteredData8 = [plottedFilteredData8(num_samples+1:end), newFilteredData(8,:)]; 
	%end	%TODO: remove
	refreshdata			% NOTE: the plot must refresh now

	
%	plot_channels(NUM_CHANNELS, channels, filtered_channels);		

	entireRawData = [entireRawData; channels];
	%entireFilteredData = [entireFilteredData; filtered_channels];
	
%	buffer_bluetooth = buffer;
%	assignin('base', 'buffer_bluetooth', buffer);
%	assignin('base', 'flag', 1);
%	disp('mycallback exit\n');   
end
