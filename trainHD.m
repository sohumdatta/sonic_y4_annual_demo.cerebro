%trainHD.m: trains HD on gestures

global AM;
global CiM;
global iM;
global D;
global N;
global percision;
global NLABELS;
global MAXLEVELS;

for i=1:1:8
   %predata(:,i) = preprocessing_simone(entireRawData(:,i)); 
   predata(:,i) = preprocessing_simone_cancel_offset(entireRawData(:,i)); 
end

%list best channels
ch1 = 1;
ch2 = 2;
ch3 = 3;
ch4 = 4;
for i=1:1:size(T1,1)
    index = T1(i,1);
    g1_train_set(i,1) = predata (index, ch1);
    g1_train_set(i,2) = predata (index, ch2);
    g1_train_set(i,3) = predata (index, ch3);
    g1_train_set(i,4) = predata (index, ch4);
end
for i=1:1:size(T2,1)
    index = T2(i,1);
    g2_train_set(i,1) = predata (index, ch1);
    g2_train_set(i,2) = predata (index, ch2);
    g2_train_set(i,3) = predata (index, ch3);
    g2_train_set(i,4) = predata (index, ch4);
end
for i=1:1:size(T3,1)
    index = T3(i,1);
    g3_train_set(i,1) = predata (index, ch1);
    g3_train_set(i,2) = predata (index, ch2);
    g3_train_set(i,3) = predata (index, ch3);
    g3_train_set(i,4) = predata (index, ch4);
end
for i=1:1:size(T4,1)
    index = T4(i,1);
    g4_train_set(i,1) = predata (index, ch1);
    g4_train_set(i,2) = predata (index, ch2);
    g4_train_set(i,3) = predata (index, ch3);
    g4_train_set(i,4) = predata (index, ch4);
end
for i=1:1:size(T5,1)
    index = T5(i,1);
    g5_train_set(i,1) = predata (index, ch1);
    g5_train_set(i,2) = predata (index, ch2);
    g5_train_set(i,3) = predata (index, ch3);
    g5_train_set(i,4) = predata (index, ch4);
end
% for i=1:1:size(T6,1)
%     index = T6(i,1);
%     g6_train_set(i,1) = predata (index, ch1);
%     g6_train_set(i,2) = predata (index, ch2);
%     g6_train_set(i,3) = predata (index, ch3);
%     g6_train_set(i,4) = predata (index, ch4);
% end
skip = 1;
percision = 20/max(max([predata(skip:end,ch1), predata(skip:end,ch2), predata(skip:end,ch3), predata(skip:end,ch4)]));

%real-time training
HD_demo;
D = 10000;
N = 1;
MAXLEVELS = 21; %21;
NLABELS = 5;
%percision = 0.0083; %1;
cuttingAngle = 0.9;

%initialize item meory and associative memory
[CiM, iM] = initItemMemories (D, MAXLEVELS);
AM = containers.Map ('KeyType','double','ValueType','any');
for label = 1:1:NLABELS
    AM (label) = zeros (1,D);
end

[AM] = hdctrain (g1_train_set, 1, AM, CiM, iM, D, N, percision, cuttingAngle);
[AM] = hdctrain (g2_train_set, 2, AM, CiM, iM, D, N, percision, cuttingAngle);
[AM] = hdctrain (g3_train_set, 3, AM, CiM, iM, D, N, percision, cuttingAngle);
[AM] = hdctrain (g4_train_set, 4, AM, CiM, iM, D, N, percision, cuttingAngle);
[AM] = hdctrain (g5_train_set, 5, AM, CiM, iM, D, N, percision, cuttingAngle);
% [AM] = hdctrain (g6_train_set, 6, AM, CiM, iM, D, N, percision, cuttingAngle);

visualizeAM (AM);

save('trained.mat');
