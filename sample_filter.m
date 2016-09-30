% sample_filter.m: this internal function does the iir filtering even while guaranteeing batch functionaliy	
function output = sample_filter(b, a, rawData, prevData, prevFilteredData)
	L = max(length(a), length(b));	% maximum past states reqd for stream filtering

	if(~isequal(size(prevData), size(prevFilteredData)))
		error('sample_filter: prevData and prevFilteredData have different sizes');	
	end	%if(~isequal(size(prevData), size(prevFilteredData)))

	if(a(1) == 0) 
		error('a coefficients first element must be non-zero'); 
	end

	x_prev = flip(prevData);
	y_prev = flip(prevFilteredData);
	
	% this is because x_prev in filtic needs [x(-1) x(-2) ...], same for y_prev
	if(isempty(x_prev))
		output = filter(b, a, rawData);
	else
		if((length(x_prev) <= L) || (length(y_prev) <= L))
			error('sample_filter:x_prev and y_prev must be atleast as large as L');
		end

		x_prev(L+1:end) = [];
		y_prev(L+1:end) = [];		

		fz = filtic(b, a, y_prev, x_prev);	%calculate initial conditions
		output = filter(b, a, rawData, fz);
	end %if(isempty(x_prev))
end %sample_filter

