% SaveData_callback.m: callback for pushbutton 'SAVE', will save base workspace to save_<i>.mat
function SaveData_callback(src, event, s)
	disp(' ');
	disp('SaveData_callback: Button ''SAVE'' pressed! Saving workspace data');
	base = 'save';
	ext = '.mat';
	fname = strcat(base, ext);
	fileno = 1;
	while(exist(fname, 'file') == 2)
	%file exists, search for the next save_<i>.mat, <i> is the next highest integer. 	
		fname = strcat(base,'_',int2str(fileno),ext);
		fileno = fileno + 1;
	end %while

	disp(sprintf('saving workspace in a new file ''%s''', fname));
	evalin('base', ['save(''', fname, ''');']);
	disp('Workspace saved successfully!');

end %SaveData_callback
