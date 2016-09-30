% FlushData_callback.m: callback for pushbutton 'FLUSH DATA', will flush entireRawData and entireFilteredData
function FlushData_callback(src, event, s)
	disp(' ');
	disp('FlushData_callback: Button ''FLUSH DATA'' pressed! Flushing entireFilteredData and entireRawData');
	evalin('base', 'entireRawData = [];');
	evalin('base', 'entireFilteredData = [];');
end %FlushData_callback
