% mycallback.m: callback function that fetches new data, processes them and stores into variables

function mycallback (s,event)
%	disp('mycallback entered.');   
	
	% the following global variables are already defined in the main.m
	global entireRawData;
	global entireFilteredData;

	NUM_CHANNELS = 8;

	NUM_BYTES = 22528;
    nbytes = get(s,'BytesAvailable');
    [buffer, readBytes] = fread (s, NUM_BYTES,'uint8');
    msg = sprintf ('BytesAvailable = %d; ReadByteFromFread = %d', nbytes, readBytes);
	disp(msg);
	channels = read_serial_port(buffer);   

%	hold on;
	figure(gcf);

	for j = 1:NUM_CHANNELS
    	filtered_channels(:,j) = preprocessing (channels(:,j), j);
	end

	plot_channels(NUM_CHANNELS, channels, filtered_channels);		

	entireRawData = [entireRawData; channels];
	entireFilteredData = [entireFilteredData; filtered_channels];
	
%	buffer_bluetooth = buffer;
%	assignin('base', 'buffer_bluetooth', buffer);
%	assignin('base', 'flag', 1);
%	disp('mycallback exit\n');   
end
