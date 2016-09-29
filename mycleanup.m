% mycleanup.m : A cleanup function called when the main is exited, and error occurs or Ctrl-C

function mycleanup(s)
	func = 'mycleanup'

	disp(sprintf('\n%s:Cleanup function called.', func));

	fwrite(s, ':');
	disp(sprintf('%s: the serial port is written ":" (STOP)', func));

	fclose(s); delete(s);
	disp(sprintf('%s: the serial object is closed and deleted.\n', funci));
end
