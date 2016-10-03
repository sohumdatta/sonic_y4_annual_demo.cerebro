% diff_to_env.m: filter to subtract mean, absolute value, exponential averaging
function [ sig_out ] = diff_to_env( signal_in )
	%UNTITLED2 Summary of this function goes here
	%   Detailed explanation goes here
	zero_offset = signal_in - mean(signal_in);
	single_ended = abs(zero_offset);
	sig_out = filtroesponenziale(0.99,single_ended);
	
end
