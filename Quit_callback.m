% Quit_callback.m: callback for pushbutton 'Quit', will save workspace into save_<i>.mat, close all ports and figures, finally quit
function Quit_callback(src, event, s)
	base = 'save';
	ext = '.mat';
	fname = strcat(base, ext);
	fileno = 1;
	while(exist(fname, 'file') == 2)
	%file exists, search for the next save_<i>.mat, <i> is the next highest integer. 	
		fname = strcat(base,'_',int2str(fileno),ext);
		fileno = fileno + 1;
	end %while

	disp(' ');
	disp('Quit_callback: Button ''QUIT'' pressed! Starting quit sequence');
	disp('Requesting to stop sending data by writing ":" to serial');
	evalin('base','fwrite(s, '':'')');
	
	disp(sprintf('saving workspace in a new file ''%s''', fname));
	evalin('base', ['save(''', fname, ''');']);
	disp('Workspace saved successfully');

	disp('closing port and deleting serial object');
	evalin('base', 'fclose(s); delete(s);');

	disp('closing the figure, goodbye...');
	evalin('base','close all;');
end %Quit_callback
