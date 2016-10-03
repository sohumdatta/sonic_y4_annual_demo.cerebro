% FlushClassifyData_callback.m: callback for pushbutton 'FLUSH DATA', will flush entireRawData and entireFilteredData
function FlushClassifyData_callback(src, event, s)
	disp(' ');
	disp('FlushData_callback: Button ''FLUSH & CLASSIFY'' pressed! Start classifying data');
	evalin('base', 'flag_classify = 1;');
end %FlushData_callback
