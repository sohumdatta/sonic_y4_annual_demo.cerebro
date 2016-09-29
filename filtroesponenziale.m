function [vettorefiltrato] = filtroesponenziale (coeff, vettore)
	vettorefiltrato = vettore;
	if(~isempty(vettore))
		[n,m]= size(vettore);
		vettorefiltrato(1,1) = 0;
		for i = 2 : n
			vettorefiltrato(i,1) = vettorefiltrato(i-1,1)*coeff + vettorefiltrato(i,1)*(1-coeff);
		end
	end %if(~isempty(vettore))
end

