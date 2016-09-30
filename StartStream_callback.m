% StartStream_callback.m: callback for pushbutton 'Start Stream', will write '='
function StartStream_callback(src, event, s)
	evalin('base','fwrite(s, ''='')');
	disp(' ');
	disp('StartStream_callback: Button ''RESUME STREAM'' pressed! Requesting to send data by writing "=" to serial...');
end %StartStream_callback
