% main.m: main script for cerebro demo of HD gesture recognition using matlab bluetooth driver

clear all; close all; clc;

%% -- Global data defined here

global entireRawData;	% all of the RAW values, each column containing a channel
global entireFilteredData;	% filtered values of entire run, each column a channel
global movingAverage;		% the moving average for each channel is stored here

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

%% -- next line commented for linux
%s = Bluetooth('CerebroBRD Fine Mondo 1000', 1);
s.BytesAvailableFcn = {'mycallback'};
s.BytesAvailableFcnCount = 22528;
s.BytesAvailableFcnMode='byte';
s.InputBufferSize = 100000;
fopen (s);
disp('Serial Port opened');

fwrite (s, '=');

screen_sz = get(groot, 'ScreenSize');
figure('Position', screen_sz);

%disp('Written = to serial, pausing till callback');
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
