% StopStream_callback.m: callback for pushbutton 'Stop Stream', will write ':'
function StopStream_callback(src, event, s)
	evalin('base','fwrite(s, '':'')');
	disp(' ');
	disp('StopStream_callback: Button ''STOP STREAM'' pressed! Requesting to pause sending data by writing ":" to serial...');
end %StopStream_callback
