function [ filtre ] = filtroesponenziale_abbas(adc_raw, filt_prev)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
 
filtre = abs(adc_raw)*0.01 + filt_prev*0.99;
 
end