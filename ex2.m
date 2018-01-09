%% clear all the variables and initiate a seed for the calculations 
clear
clear all
clc
seed = initialize();

%% Q2.a Genereate the data using the generate method and pass the parameters of dimensions and data points
nDim = 10;
nData = 600;
gamma = 0;
[w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

%% calculate w for the 10 dim data
wstar = wreg(xitrain,yitrain, gamma);

%% calculate mse for the train set
msetrain = mse(xitrain, yitrain, wstar);

%% calculate mse for the test set
msetest = mse(xitest, yitest,wstar);

%% calculate w for the 10 dim data for just 10 data
wstar10 = wreg(xitrain10,yitrain10, gamma);

%% calculate mse for the train set
msetrain10 = mse(xitrain10, yitrain10, wstar10);

%% calculate mse for the test set
msetest10 = mse(xitest10, yitest10, wstar10);

%% repeate the process 200 times and average them
msetrainarray = [];
msetestarray= [];
msetrain10array = [];
msetest10array = [];

for i = 1:200

    nDim = 10;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
    
    wstar = wreg(xitrain,yitrain, gamma);
    wstar10 = wreg(xitrain10,yitrain10, gamma);
    
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

col_small = [msetrain10mean; msetest10mean];
col_big = [msetrainmean; msetestmean];

%% plot the reults on a figure
f = figure;
t = uitable(f, 'Data', [col_small col_big], 'RowName', {'Training set', 'Test set'}, 'Position', [20 20 760 100]);
t.ColumnName = {'10 point training', '100 point training'};