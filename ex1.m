%% clear all the variables and initiate a seed for the calculations 
clear
clear all
clc
seed = initialize();

%% Q1.a Genereate the data using the generate method and pass the parameters of dimensions and data points
nDim = 1;
nData = 600;
gamma = 0;
[w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

%% Q1.b calculate wstar using the function wreg below and passing in the xitrain and yitrain parameters
wstar = wreg(xitrain,yitrain, gamma);

%% Q1.b calculate mean sq error for training set using the function mse and passing the parameters of xitrain, yitrain and wstar calculated from from prev step
msetrain = mse(xitrain, yitrain, wstar);

%% Q1.b calculate mean sq error for test set using the function mse and passing the parameters of xitest, yitest and wstar calculated from prev step
msetest = mse(xitest, yitest,wstar);

%% Q1.c calculate wstar10 using the function wreg and passing in the xitrain10 and yitrain10 parameters for 10 data points
wstar10 = wreg(xitrain10,yitrain10, gamma);

%% Q1.c calculate mean sq error for training set using the function mse and passing the parameters of xitrain10, yitrain10 and wstar10 calculated from prev step
msetrain10 = mse(xitrain10, yitrain10, wstar10);

%% Q1.c calculate mean sq error for test set using the function mse and passing the parameters of xitest10, yitest10 and wstar10 calculated from prev step
msetest10 = mse(xitest10, yitest10, wstar10);

%% Q1.d repeating the above 3 steps 200 times and averaging the results for both 100 and 10 taining data points
msetrainarray = [];
msetestarray= [];
msetrain10array = [];
msetest10array = [];

for i = 1:200

    nDim = 1;
    nData = 600;
    gamma = 0;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
    
    wstar = wreg(xitrain, yitrain, gamma);
    wstar10 = wreg(xitrain10, yitrain10, gamma);
    
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