% calculate_index.m: function to calculate left and bottom pixels for GUI object placement

% Implementation notes:
% 1. the screen is tiled in the form of rows and columns of the objects (whose widths and heights are given)
% 2. IMP: the rows begin from the _left_ corner and columns from _below_ 
% 3. the distance between adjacent elements in a row or column is 'margin', and that between corner elements and screen limit
% 4. the return values are checked against the screen limits, if exceeding the limits, the limit +- margin is given

function [left, bottom] = calculate_index(screen_width, screen_height, obj_width, obj_height, margin_sz, row_no, col_no)

	% error checks
	if((margin_sz >= screen_width) || (margin_sz >= screen_height))
		error('margin_sz of object larger than width or height of screen'); end

	row = floor(row_no); col = floor(col_no);
	if((row < 1) || (col < 1)) error('row or col required is less than 1'); end
 

	% calculate the margin limits
	lefts =  margin_sz : (margin_sz + obj_width) : (screen_width - (margin_sz + obj_width));
	bottoms = margin_sz : margin_sz + obj_height : (screen_height - (margin_sz + obj_height));
	n_left = length(lefts); n_bottom = length(bottoms);

	% saturate the indices
	if (col > n_left) col = n_left; end
	if (row > n_bottom) row = n_bottom; end

	left = lefts(col);	
	bottom = bottoms(row);
end %function [left, bottom] = calculate_index(row_no, col_no, margin_sz, obj_width, obj_height)
