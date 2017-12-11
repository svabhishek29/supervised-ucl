%%
clear
clear all
clc
seed = initialize();

%% 
nDim = 10;
nData = 600;
[w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

%%
wstar = xitrain \ yitrain;

%%
msetrain = mse(xitrain, yitrain, wstar);

%%
msetest = mse(xitest, yitest,wstar);

%%
wstar10 = xitrain10 \ yitrain10;

%%
msetrain10 = mse(xitrain10, yitrain10, wstar10);

%%
msetest10 = mse(xitest10, yitest10, wstar10);

%%
msetrainarray = [];
msetestarray= [];
msetrain10array = [];
msetest10array = [];

for i = 1:200

    nDim = 10;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
    
    wstar = xitrain \ yitrain;
    wstar10 = xitrain10 \ yitrain10;
    
    msetrain = mse(xitrain, yitrain, wstar);
    msetest = mse(xitest, yitest,wstar);
    
    msetrain10 = mse(xitrain10, yitrain10, wstar10);
    msetest10 = mse(xitest10, yitest10, wstar10);
    
    msetrainarray = [msetrainarray, msetrain];
    msetestarray = [msetestarray, msetest];
    msetrain10array = [msetrain10array, msetrain10];
    msetest10array = [msetest10array, msetest10];
end

msetrainmean = mean(msetrainarray);
msetrain10mean = mean(msetrain10array);
msetestmean = mean(msetestarray);
msetest10mean = mean(msetest10array);

msearray = [msetrainmean msetrain10mean;msetestmean msetest10mean]