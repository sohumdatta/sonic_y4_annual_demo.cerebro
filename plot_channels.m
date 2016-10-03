% plot_channels.m : plot all channel values, returns pointers to the plots
%----------------------------------------------------------------------
% Plot lines
% TODO: Find a way to send value by reference, and send the plot to a 
% new function
function [h_raw, h] = plot_channels(NUM_CHANNELS, channels, filtered_channels)

%	TODO: remove on final cleanup, not required
%	if(NUM_SAMPLES < 1000) error('Window for plot must be larger than 1000'); end

	if(NUM_CHANNELS < 4) error('Number of channels for plot must be larger than 4'); end

	n = size(filtered_channels, 2);
	xrange = 1:n;
	yrange = [-5000 , 5000];
	yfilterrange = [0 , 5000];

	channel_raw = channels;
	channel = filtered_channels;

	%%%% Beginnning  of Plot lines

	h = [];	%TODO: remove this 
%	clf	% clear frame
	figure(gcf); 	%plot on current figure or create new one
	for i = 1:NUM_CHANNELS
		%subplot(NUM_CHANNELS,2,2*i-1)	%TODO: uncomment this and remove the line below
		subplot(NUM_CHANNELS+1,1,i)
		h_raw(i) = plot(xrange, channel_raw(i,:)); title(['Channel ', int2str(i)]);
		ylim(yrange); xlim([1 n]);

%		subplot(NUM_CHANNELS,2,i)
%		h(i) = plot(xrange, channel(i,:)); title(['Filtered ', int2str(i)]);
%		ylim(yfilterrange); xlim([1 n]);
	end

%	drawnow
% END OF PLOT LINES
%----------------------------------------------------------------------
end %function
