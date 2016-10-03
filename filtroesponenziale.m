% filtroesponenziale.m: Simone's original exponential averaging filter (batch mode only)
function [ vettorefiltrato ] = filtroesponenziale(coeff, vettore)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
vettorefiltrato = vettore ;
[n,m]= size(vettore);
vettorefiltrato(1,1) = 0;
for i = 2 : n
    vettorefiltrato(i,1) = vettorefiltrato(i-1,1)*coeff + vettorefiltrato(i,1)*(1-coeff);
    
end


end
