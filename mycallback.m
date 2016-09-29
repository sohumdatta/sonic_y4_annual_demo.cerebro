function mycallback (s,event)
%	disp('mycallback entered.');   

	NUM_BYTES = 22528;
    nbytes = get(s,'BytesAvailable');
    [buffer, readBytes] = fread (s, NUM_BYTES,'uint8');
    msg = sprintf ('BytesAvailable = %d; ReadByteFromFread = %d', nbytes, readBytes);
	disp(msg);
	channels = read_serial_port(buffer);   

%	hold on;
	figure(gcf);
	plot(channels);		
%	buffer_bluetooth = buffer;
%	assignin('base', 'buffer_bluetooth', buffer);
%	assignin('base', 'flag', 1);
%	disp('mycallback exit\n');   
end
