% filtroesponenziale.m : (Defunct) exponential averaging filter
function [vettorefiltrato] = filtroesponenziale (coeff, vettore, chID)
	persistent yn_1;	
	vettorefiltrato = vettore;
	if(~isempty(vettore))

		if isempty(yn_1)	% if it is the first time executing filter
			yn_1 = zeros (1,8);
			vettorefiltrato(1,1) = yn_1(chID);
			disp ('          >>> Initializing averaging filter to zeros <<<<    ');
		else			%load the latest yn value into yn-1
			vettorefiltrato(1,1) = yn_1(chID);
		end

		[n,m]= size(vettore);
		for i = 2 : n
			vettorefiltrato(i,1) = vettorefiltrato(i-1,1)*coeff + vettorefiltrato(i,1)*(1-coeff);
		end
		yn_1(chID) = vettorefiltrato(n,1);	% save the last value into yn_1 for the next iteration to be used
	end %if(~isempty(vettore))
end

