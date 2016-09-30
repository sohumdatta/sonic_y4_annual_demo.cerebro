% main.m: main script for cerebro demo of HD gesture recognition using matlab bluetooth driver

clear all; close all; clc;

%% -- Global data defined here
% A member function only declares that variable as global which he needs

global NUM_CHANNELS;

global entireRawData;	% all of the RAW values, each column containing a channel
global entireFilteredData;	% filtered values of entire run, each column a channel

% the linked source variables of fixed length used by the plotter
global plottedRawData1;	
global plottedRawData2;	
global plottedRawData3;	
global plottedRawData4;	
global plottedRawData5;	
global plottedRawData6;	
global plottedRawData7;	
global plottedRawData8;	
global plottedFilteredData1;
global plottedFilteredData2;
global plottedFilteredData3;
global plottedFilteredData4;
global plottedFilteredData5;
global plottedFilteredData6;
global plottedFilteredData7;
global plottedFilteredData8;

global PLOT_WINDOW;


PLOT_WINDOW = 2000;		% number of samples plotted at any time
NUM_CHANNELS = 8;
plottedRawData1 = zeros(1,PLOT_WINDOW);
plottedRawData2 = zeros(1,PLOT_WINDOW);
plottedRawData3 = zeros(1,PLOT_WINDOW);
plottedRawData4 = zeros(1,PLOT_WINDOW);
plottedRawData5 = zeros(1,PLOT_WINDOW);
plottedRawData6 = zeros(1,PLOT_WINDOW);
plottedRawData7 = zeros(1,PLOT_WINDOW);
plottedRawData8 = zeros(1,PLOT_WINDOW);
plottedFilteredData1 = zeros(1,PLOT_WINDOW);
plottedFilteredData2 = zeros(1,PLOT_WINDOW);
plottedFilteredData3 = zeros(1,PLOT_WINDOW);
plottedFilteredData4 = zeros(1,PLOT_WINDOW);
plottedFilteredData5 = zeros(1,PLOT_WINDOW);
plottedFilteredData6 = zeros(1,PLOT_WINDOW);
plottedFilteredData7 = zeros(1,PLOT_WINDOW);
plottedFilteredData8 = zeros(1,PLOT_WINDOW);

plottedRawData = zeros(NUM_CHANNELS, PLOT_WINDOW);
plottedFilteredData = zeros(NUM_CHANNELS, PLOT_WINDOW);

%% -- This portion is added for execution in Linux
port_no = 0;
SERIAL_PORT = strcat('/dev/rfcomm', int2str(port_no))

openPorts = instrfind;
        
if ~isempty(openPorts);
%        	fclose(openPorts);
	for i = openPorts
		delete(i);	% SOHUM: Added to clear previous attempts
	end
end
s = serial(SERIAL_PORT);
%% -- End of portion added for execution in Linux


%global buffer_bluetooth;
buffer_bluetooth = [];
flag = 0;


%% -- Generate the screen (GUI goes here) and plot initially, save link variable names
screen_sz = get(groot, 'ScreenSize');
screen_width = screen_sz(3); screen_height = screen_sz(4);
	
% button widths and heights are 1/20th the size of a screen
button_width = floor(screen_width/20);	button_height = floor(screen_height/20);	
	
% margins are maximum of width and height of buttons
screen_margin = min(button_width, button_height);

%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[1 1 screen_width screen_height]);
set(f, 'Name', 'Hyper-dimensional Computing on EMG Demo','NumberTitle','off');
  

[h_raw, h] = plot_channels(NUM_CHANNELS, plottedRawData, plottedFilteredData);		
for i = 1:NUM_CHANNELS
	h_raw(i).YDataSource = sprintf('plottedRawData%d',i);
	h(i).YDataSource = sprintf('plottedFilteredData%d',i);
end


%  Construct the components.
[left, bottom] = calculate_index(screen_width, screen_height, ...
					button_width, button_height, screen_margin, ...
					5, 1);
h_FlushData = uicontrol('Style','pushbutton','String','FLUSH DATA',...
   'Position', [left, bottom, button_width, button_height], 'Callback', {@FlushData_callback});


[left, bottom] = calculate_index(screen_width, screen_height, ...
					button_width, button_height, screen_margin, ...
					4, 1);
h_SaveData = uicontrol('Style','pushbutton','String','SAVE DATA',...
   'Position', [left, bottom, button_width, button_height], 'Callback', {@SaveData_callback});


[left, bottom] = calculate_index(screen_width, screen_height, ...
					button_width, button_height, screen_margin, ...
					3, 1);
h_StopStream = uicontrol('Style','pushbutton','String','STOP STREAM',...
   'Position', [left, bottom, button_width, button_height], 'Callback', @StopStream_callback);


[left, bottom] = calculate_index(screen_width, screen_height, ...
					button_width, button_height, screen_margin, ...
					2, 1);
h_StartStream = uicontrol('Style','pushbutton','String','RESUME STREAM',...
	   'Position', [left, bottom, button_width, button_height], 'Callback', @StartStream_callback);


[left, bottom] = calculate_index(screen_width, screen_height, ...
					button_width, button_height, screen_margin, ...
					1, 1);
h_Quit = uicontrol('Style','pushbutton','String','QUIT',...
   'Position', [left, bottom, button_width, button_height], 'Callback', @Quit_callback);





% next line commented for linux
%s = Bluetooth('CerebroBRD Fine Mondo 1000', 1);
s.BytesAvailableFcn = {'mycallback'};
s.BytesAvailableFcnCount = 22528;
s.BytesAvailableFcnMode='byte';
s.InputBufferSize = 100000;
fopen (s);
disp('Serial Port opened');

fwrite (s, '=');

disp('Written = to serial, pausing till callback');
%while (1)
%	pause(0.01);
%	if(flag) disp('flag set');
%	end
%	flag = 0;
%end %while (1)
%
%clc;
%s = open_serial_port(5);
%s = Bluetooth('CerebroBRD Fine Mondo 1000', 1);
%fopen(s);

%rawData = zeros (1,8);
%filterData = zeros (1,8);
%
%NUM_CHANNELS = 8;
%NUM_SAMPLES = 10000;  % the sliding window of samples shown
%
%[h_raw, h] = plot_channels(NUM_SAMPLES, NUM_CHANNELS);	%plot initially
%
%channel = zeros(NUM_CHANNELS, NUM_SAMPLES);
%channel_raw = zeros(NUM_CHANNELS, NUM_SAMPLES);
%
%
%% forever, fetch the data and plot it
%while(1)
% 	clear currentFilterData;	%need to clear it as prev data fetched may have been longer
%
%    currentData = read_serial_port(s); 	%read a set of sampled data from port
%
%	%apply filtering
%	% raw channel data = 'currentData(time, channel)'
%	% filtered channel data = 'currentFilterData(time, channel)'
%	for j = 1:NUM_CHANNELS
%    	currentFilterData(:,j) = preprocessing (currentData(:,j));
%	end
%
%	% Lines for plot refresh
%	n = size(currentData, 1);	% number of samples loaded this time
%    if(n <= NUM_SAMPLES) 
%		channel = [channel(:, (n+1):NUM_SAMPLES), currentFilterData(:,1:NUM_CHANNELS)'];
%    	channel_raw = [channel_raw(:, (n+1):NUM_SAMPLES), currentData(:,1:NUM_CHANNELS)'];
%	else
%		channel = currentFilterData(:,1:NUM_CHANNELS)';
%    	channel_raw = currentData(:,1:NUM_CHANNELS)';
%		n = size(channel, 2);
%		channel = channel(:,n - NUM_SAMPLES + 1:n);
%		channel_raw = channel_raw(:,n - NUM_SAMPLES + 1:n);
%	end	
%	
%    for j = 1:NUM_CHANNELS
%		h(j).YData = channel(j,:);
%		h_raw(j).YData = channel_raw(j,:);
%	end
%
%	pause(0.01);	% This delay is very important for refreshing the plots
%    refreshdata 	% End of Lines for plot refresh
%
% 	rawData = [rawData; currentData];
% 	filterData = [filterData; currentFilterData];
%end %while(1)
disp('exiting main script')
