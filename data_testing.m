% data_testing.m: main script for testing data for HD demo Cerebro

close all; clc;
HD_demo;

%% -- Global data defined here
% A member function only declares that variable as global which he needs

global NUM_CHANNELS;

global entireRawData;	% all of the RAW values, each column containing a channel
global entireFilteredData;	% filtered values of entire run, each column a channel
global MAXLEVELS;

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
global flag_classify;

flag_classify = 0;

PLOT_WINDOW = 2000;		% number of samples plotted at any time
NUM_CHANNELS = 4;
MAXLEVELS = 21;
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

% gestur images are loaded now, to be shown during classification
% ** NOTE **: The images must be in the folder '.pics/'
img_open_hand = imread('pics/open_hand.jpg');
img_closed_fist = imread('pics/closed_fist.jpg');
img_index_finger = imread('pics/index_finger.jpg');

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

% icon image widths and heights
image_width  = floor(screen_width/7); image_height = floor(screen_height/5);
	
% margins are maximum of width and height of buttons
screen_margin = min(button_width, button_height);

%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[1 1 screen_width screen_height]);
set(f, 'Name', 'Hyper-dimensional Computing for hand gesture recognition using EMG','NumberTitle','off');
  

[h_raw, h] = plot_channels(NUM_CHANNELS, plottedRawData, plottedFilteredData);		
for i = 1:NUM_CHANNELS
	h_raw(i).YDataSource = sprintf('plottedRawData%d',i);
%	h(i).YDataSource = sprintf('plottedFilteredData%d',i);	%TODO: uncomment these
end


%  Construct the components.
[left, bottom] = calculate_index(screen_width, screen_height, ...
					button_width, button_height, screen_margin, ...
					1, 2);
img_axes = axes('Units', 'pixels', 'Position', [left, bottom, image_width, image_height], 'Visible', 'off',...
				'XTickLabel','', 'YTickLabel','');

%imshow(img_open_hand); 	% TODO: remove the line below

[left, bottom] = calculate_index(screen_width, screen_height, ...
					button_width, button_height, screen_margin, ...
					1, 4);
		' Gesture: N/A (Press ''CLASSIFY'' to begin) '
h_TextBox = uicontrol('Style','text','String', 'Gesture: N/A (Press ''CLASSIFY'' to begin)',...
	 'FontSize', 42, 'Position', [left, bottom, screen_width/2, button_height], 'HorizontalAlignment', 'left');


[left, bottom] = calculate_index(screen_width, screen_height, ...
					button_width, button_height, screen_margin, ...
					5, 1);
h_ClassifyData = uicontrol('Style','pushbutton','String','CLASSIFY',...
   'Position', [left, bottom, button_width, button_height], 'Callback', {@ClassifyData_callback});


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
s.BytesAvailableFcn = {'classify_hd_callback'};
s.BytesAvailableFcnCount = 22528;
s.BytesAvailableFcnMode='byte';
s.InputBufferSize = 100000;
fopen (s);
disp('Serial Port opened');

fwrite (s, '=');

disp('Written = to serial, pausing till callback');
disp('exiting main script')

