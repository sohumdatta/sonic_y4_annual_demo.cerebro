
function randomHV = lookupItemMemeory (itemMemory, rawKey, D, percision)
%
% DESCRIPTION   : recalls a vector from item Memory based on inputs
%
% INPUTS:
%   itemMemory  : item memory
%   rawKey      : the input key
%   D           : Dimension of vectors
%   percision   : percision used in quantization of input EMG signals
%
% OUTPUTS:
%   randomHV    : return the related vector

 	global MAXLEVELS;
    key = int64 (rawKey * percision);
	if (key > MAXLEVELS)
		key = MAXLEVELS;
	end
    %if key < 0
    %    key = 0;
    %    fprintf ('A negative key (raw=%d) is found: %d\n', rawKey, key);  
    %end
    
    if itemMemory.isKey (key) 
        randomHV = itemMemory (key);
    else
        fprintf ('CANNOT FIND THIS KEY: %d\n', key);       
    end
end

