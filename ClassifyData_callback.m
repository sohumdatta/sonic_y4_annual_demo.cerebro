% ClassifyData_callback.m: callback for pushbutton 'CLASSIFY', will begin classify incoming gestures through HD
function ClassifyData_callback(src, event, s)
	disp(' ');
	disp('ClassifyData_callback: Button ''CLASSIFY'' pressed! Start classifying data');
	evalin('base', 'flag_classify = 1;');
end %ClassifyData_callback
