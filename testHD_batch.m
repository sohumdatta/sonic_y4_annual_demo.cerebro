
%full dataset test
clear all_labels;
clear test_set;
window = 1024;
DS = 20;
%for i=1:window:size(predata,1)-window
for i=1:window:size(entireRawData,1)-window
    for c=1:1:4
        predata(:,c) = preprocessing_simone_cancel_offset(entireRawData(i:i+window-1,c));
    end
    %test_set(:,1:4) = predata(i:DS:i+window-1,1:4);
    test_set(:,1:4) = predata(1:DS:end,1:4);
    [predicLabel, freq] = hdctest (test_set, AM, CiM, iM, D, N, percision, NLABELS);
    size(test_set);
    for j=i:1:i+window-1
        all_labels(j) = predicLabel;
    end
end



%{

%single test
for i=1:1:size(test,1)
    index = test(i,1);
    test_set(i,1) = predata (index, ch1);
    test_set(i,2) = predata (index, ch2);
    test_set(i,3) = predata (index, ch3);
    test_set(i,4) = predata (index, ch4);
end
[predicLabel, freq] = hdctest (test_set, AM, CiM, iM, D, N, percision, NLABELS)
%}




%{
%read a block of data
for t = 1:1:N
    for c = 1:1:4
        dataBlock(t,c) = 
    end
end

%stride should be 1 over the train data
[AM] = hdctrainsample (dataBlock, label, AM, CiM, iM, D, N, percision);


%stride should be N over the test data
[predicLabel] = hdcpredict (testSet, AM, CiM, iM, D, N, percision, NLABELS)



%offline 
clear;
ICRC;
D = 10000;
N = 4;
MAXLEVELS = 21;
NLABELS = 5;
percision = 1;

[CiM, iM] = initItemMemories (D, MAXLEVELS);
AM = containers.Map ('KeyType','double','ValueType','any');
for label = 1:1:NLABELS
    AM (label) = zeros (1,D);
end

load('../../COMPLETE.mat');
learningFrac = 0.25;
downSampRate = 250;
[TS_COMPLETE_1, L_TS_COMPLETE_1] = downSampling (COMPLETE_1, LABEL_1, downSampRate);
[L_SAMPL_DATA_1, SAMPL_DATA_1] = genTrainData (TS_COMPLETE_1, L_TS_COMPLETE_1, learningFrac, '-------');

for s=1:1:length(L_SAMPL_DATA_1)-N
    for t = 1:1:N
        for c = 1:1:4
            dataBlock(t,c) = SAMPL_DATA_1(s+t,c); 
        end
    end
    [AM] = hdctrainsample (dataBlock, L_SAMPL_DATA_1(s), AM, CiM, iM, D, N, percision); 
end

correct = 0;
total = 0;
for s=1:N:length(L_TS_COMPLETE_1)-N
    for t = 1:1:N
        for c = 1:1:4
            dataBlock(t,c) = TS_COMPLETE_1(s+t,c); 
        end
    end
    [predicLabel] = hdcpredict (dataBlock, AM, CiM, iM, D, N, percision, NLABELS);
    if predicLabel == mode(L_TS_COMPLETE_1(s:s+N))
        correct = correct + 1;
    end
    total = total + 1;
end
correct/total
        

%cuttingAngle = 0.9;
%[numpat, hdc_model_1] = hdctrain (L_SAMPL_DATA_1, SAMPL_DATA_1, CiM, iM, D, N, percision, cuttingAngle);
%[accExcTrnz, accuracy] = hdctest (L_TS_COMPLETE_1, TS_COMPLETE_1, hdc_model_1, CiM, iM, D, N, percision);

%}

