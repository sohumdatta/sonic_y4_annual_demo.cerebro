% Quit_callback.m: callback for pushbutton 'Quit', close all ports and figures, finally quit
function Quit_callback(src, event, s)
	disp(' ');
	disp('Quit_callback: Button ''QUIT'' pressed! Starting quit sequence');
	%disp('Requesting to stop sending data by writing ":" to serial');
	%evalin('base','fwrite(s, '':'')');
	
%	ext = '.mat';
%	fileno = 1;
%	BASE_DIR = '../cerebro_dumps/';
%
%	% the file name will be <data_tag>_<day>_<month>_<year>_<hr>_<min>_<sec>,
%	% if by chance the file name exists (because of different time zone,
%	% it will be replaced by <filename>_no<i>
%	fn = char(datetime);
%	fn = strrep(fn, '-', '_');
%	fn = strrep(fn, ':', '_');
%	fn = strrep(fn, ' ', '_');
%	base = strcat(BASE_DIR, '_', fn); 
%	fname = base;
%	
%	while(exist(fname, 'file') == 2)
%	%file exists, search for the next save_<i>.mat, <i> is the next highest integer. 	
%		fname = strcat(base,'_no',int2str(fileno),ext);
%		fileno = fileno + 1;
%	end %while
%
%	disp(sprintf('Saving in NEW FILE ''%s''', fname));
%	evalin('base', ['save(''', fname, ''');']);
%	disp('Workspace saved successfully!');
	disp('** WARNING: Workspace variables will be lost if you haven''t saved them earlier.');

	disp('closing port and deleting serial object');
	evalin('base', 'fclose(s); delete(s);');

	disp('closing the figure, goodbye...');
	evalin('base','close all;');
end %Quit_callback
