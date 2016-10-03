function [votedLabel, frequency] = hdctest (testSet, AM, CiM, iM, D, N, percision, NLABELS)
%
% DESCRIPTION   : test accuracy based on input testing data
%
% INPUTS:
%   labelTestSet: testing labels
%   testSet     : EMG test data
%   AM          : Trained associative memory
%   CiM         : Cont. item memory
%   iM          : item memory
%   D           : Dimension of vectors
%   N           : size of n-gram, i.e., window size
%   percision   : percision used in quantization of input EMG signals
%
% OUTPUTS:
%   accuracy    : classification accuracy for all situations
%   accExcTrnz  : classification accuracy excluding the transitions between gestutes
%
    predictedLabel = 0;
    %for i = 1:1:length(testSet)-N+1
    for i = 1:N:size(testSet,1)-N+1
        sigHV = computeNgram (testSet (i : i+N-1,:), CiM, D, N, percision, iM);
        maxAngle = -1;
        predicLabel = -1;
        for label = 1:1:NLABELS
            angle = cosAngle(AM (label), sigHV);
            if (angle > maxAngle)
                maxAngle = angle;
                predicLabel = label;
            end
        end
        predictedLabel = [predictedLabel; predicLabel];
    end
    predictedLabel(1) = [];
    [votedLabel, frequency] = mode(predictedLabel);
    frequency = frequency/length(predictedLabel);
end
