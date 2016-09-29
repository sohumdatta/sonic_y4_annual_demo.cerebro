% plot_channels.m : Plot channel values and change them as value changes
%----------------------------------------------------------------------
% Plot lines
% TODO: Find a way to send value by reference, and send the plot to a 
% new function
function [h_raw, h] = plot_channels(NUM_CHANNELS, channels, filtered_channels)

%	if(NUM_SAMPLES < 1000) error('Window for plot must be larger than 1000'); end
	if(NUM_CHANNELS < 4) error('Number of channels for plot must be larger than 4'); end

	NUM_SAMPLES = size(filtered_channels, 1);
	xrange = 1:NUM_SAMPLES;
	yrange = [-10000 , 10000];
	yfilterrange = [0 , 21000];

	channel_raw = channels';
	channel = filtered_channels';


%	figure

	%%%% Beginnning  of Plot lines

%	clf	% clear frame
	figure(gcf); 
	for i = 1:NUM_CHANNELS
		subplot(NUM_CHANNELS,2,2*i-1)
		h_raw(i) = plot(xrange, channel_raw(i,:)); title(['Channel ', int2str(i)]);
		ylim(yrange);

		subplot(NUM_CHANNELS,2,2*i)
		h(i) = plot(xrange, channel(i,:)); title(['Filtered ', int2str(i)]);
		ylim(yfilterrange);
	end

%	drawnow
%%%% End of Plot lines
% END OF PLOT LINES
%----------------------------------------------------------------------
end %function
