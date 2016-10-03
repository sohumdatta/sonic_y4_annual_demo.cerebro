% classify_hd_callback.m: callback function to plot, process and classify data

function classify_hd_callback (s,event)
%	disp('mycallback entered.');   
	
	% the following global variables are already defined in the main.m
%	global entireRawData;
%	global entireFilteredData;
	global plottedRawData1;	
	global plottedRawData2;	
	global plottedRawData3;	
	global plottedRawData4;	
	global plottedRawData5;	
	global plottedRawData6;	
	global plottedRawData7;	
	global plottedRawData8;	
%	global NUM_CHANNELS;
	global PLOT_WINDOW;
	global flag_classify;

	global AM;
	global CiM;
	global iM;
	global D;
	global N;
	global percision;
	global NLABELS;

	NUM_BYTES = 22528;
    nbytes = get(s,'BytesAvailable');
    [buffer, readBytes] = fread (s, NUM_BYTES,'uint8');
    msg = sprintf ('BytesAvailable = %d; ReadByteFromFread = %d', nbytes, readBytes);
	disp(msg);
	channels = read_serial_port(buffer);   

%	hold on;
	figure(gcf);

	%% Note: at this point channels and filtered_channels have each row a data 
	% time instant and each column a channel value. We want to now update the variables
	% plottedRawData and plottedFilteredData where each row is a channel and each column
	% is a time instant.
	
	% changes this packet that will be plotted
	newRawData = channels';
	num_samples = size(newRawData, 2);

	% only retain at most the recent PLOT_WINDOW samples
	newRawData(:,1:num_samples-PLOT_WINDOW) = [];
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

	refreshdata			% NOTE: the plot must refresh now
	
KeySet = {1, 2, 3, 4};
valueSet = {'Rest', 'Index Finger', 'Fist closed', 'Palm up'};
mapObj = containers.Map(KeySet, valueSet);



%full dataset test
	clear test_set;
	window = 1024;
	DS = 20;
	%for i=1:window:size(predata,1)-window
    for c=1:1:4
       	predata(:,c) = preprocessing_simone_cancel_offset(channels(:,c));
    end
    %test_set(:,1:4) = predata(i:DS:i+window-1,1:4);
    test_set(:,1:4) = predata(1:DS:end,1:4);
	if(flag_classify == 1)
    	[predicLabel, freq] = hdctest (test_set, AM, CiM, iM, D, N, percision, NLABELS);
		evalin('base',['set(h_TextBox, ''String'', '' Gesture:', mapObj(predicLabel),  ''');']);
	else
		evalin('base',['set(h_TextBox, ''String'', '' Gesture: N/A '');']);
	end
%	switch (predicLabel)
%		case 1
%			str = 'REST';
%		case 2
%			str = 'INDEX FINGER';
%		case 3
%			str =  'FIST CLOSED';
%		case 4
%			str =  'PALM UP';
%		case 5
%			str =  'PALM DOWN';
%	end	%switch
end	%classify_hd_callback
