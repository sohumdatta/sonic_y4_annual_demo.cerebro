% SaveData_callback.m: callback for pushbutton 'SAVE', will save base workspace to save_<i>.mat
function SaveData_callback(src, event)
	disp(' ');
	disp('SaveData_callback: Button ''SAVE'' pressed! Saving workspace data');
	ext = '.mat';
	fileno = 1;
	BASE_DIR = '../cerebro_dumps/';


	% the file name will be <Day>_<day_no>_<month>_<year>_<hr>_<min>,
	% if by chance the file name exists (because of different time zone,
	% it will be replaced by <filename>_no<i>

	t = datetime;
	t.Format = 'eee_ee_MMM_y_HH_mm';

	base = strcat(BASE_DIR, char(t)); 
	fname = base;

	while(exist(fname, 'file') == 2)
	%file exists, search for the next save_<i>.mat, <i> is the next highest integer. 	
		fname = strcat(base,'_no',int2str(fileno),ext);
		fileno = fileno + 1;
	end %while

	disp(sprintf('Saving in NEW FILE ''%s''', fname));
	evalin('base', ['save(''', fname, ''');']);
	disp('Workspace saved successfully!');

end %SaveData_callback
