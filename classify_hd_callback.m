% classify_hd_callback.m: callback function to plot, process and classify data

function classify_hd_callback (s,event)
	% the following global variables are already defined in the main.m
	global plottedRawData1;	
	global plottedRawData2;	
	global plottedRawData3;	
	global plottedRawData4;	
	global plottedRawData5;	
	global plottedRawData6;	
	global plottedRawData7;	
	global plottedRawData8;	
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

	figure(gcf);

	%% Note: at this point channels have each row a data 
	% time instant and each column a channel value. 
	
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
	
	KeySet = {1, 2, 3, 4, 5, 6};
	valueSet = {'Resting', 'Index Finger', 'Fist closed', 'Palm up', 'Three fingers', 'V shaped'};
	imageSet = {'[]', 'img_index_finger', 'img_closed_fist', 'img_open_hand', '[]', '[]'};
	mapDesc = containers.Map(KeySet, valueSet);		% A container map of gesture descriptions
	mapImg = containers.Map(KeySet, imageSet);		% A container map of image names used in the calling main

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

		evalin('base',['set(h_TextBox, ''String'', '' Gesture: ', mapDesc(predicLabel),  ''');']);	
		evalin('base', ['axes(img_axes); imshow(', mapImg(predicLabel),');']);	% plot the corresponding image in the space
	else
		evalin('base','axes(img_axes); imshow([]);');	% clear the image being shown
	end
end	%classify_hd_callback
