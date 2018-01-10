%% clear all the variables and initiate a seed for the calculations 
clear
clear all
clc
seed = initialize();

%% Genereate the data using the generate method and pass the parameters of dimensions and data points
nDim = 10;
nData = 600;
[w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

%% calculate w for the 10 dim data and also find the train and test error over 100 training data points for different gamma values
msetrainarray = [];
msetestarray = [];
gamma = 10.^[-6:3];
for i=1:10
    wstar = wreg(xitrain, yitrain, gamma(i));
    msetrain = mse(xitrain, yitrain, wstar);
    msetrainarray = [msetrainarray, msetrain];
    msetest = mse(xitest, yitest, wstar);
    msetestarray = [msetestarray, msetest];
end


col_1 = msetrainarray';
col_2 = msetestarray';

f = figure;
t = uitable(f, 'Data', [col_1 col_2]);
t.ColumnName = {'Training Error', 'Test Error'};

%% plot the mes of the taining and test errors on a log scale for ease of comparison
figure
loglog(gamma,msetrainarray,'r-')
hold on
loglog(gamma,msetestarray,'b-')
hold on
legend('train error','test error')

%% calculate w for the 10 dim data and also find the train and test error over 10 training data points for different gamma values
msetrainarray = [];
msetestarray = [];
gamma = 10.^(-6:3);
for i=1:10
    wstar10 = wreg(xitrain10, yitrain10, gamma(i));
    msetrain10 = mse(xitrain10, yitrain10, wstar10);
    msetrainarray = [msetrainarray, msetrain10];
    msetest10 = mse(xitest10, yitest10, wstar10);
    msetestarray = [msetestarray, msetest10];
end
msetrainarray
msetestarray

col_1 = msetrainarray';
col_2 = msetestarray';

f = figure;
t = uitable(f, 'Data', [col_1 col_2]);
t.ColumnName = {'Training Error', 'Test Error'};
%% plot the mes of the taining and test errors on a log scale for ease of comparison
figure
loglog(gamma,msetrainarray,'r-')
hold on
loglog(gamma,msetestarray,'b-')
hold on
legend('train error','test error')

%% repeate the above process 200 times and average them
gammatrainarray = [];
gammatestarray = [];
gammatrain10array = [];
gammatest10array = [];
gamma = 10.^[-6:3];
        
for i = 1:10
    for j = 1:200
        msetrainarray = [];
        msetestarray = [];
        msetrain10array = [];
        msetest10array = [];
        nDim = 10;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

        wstar = wreg(xitrain, yitrain, gamma(i));
        msetrain = mse(xitrain, yitrain, wstar);
        msetrainarray = [msetrainarray, msetrain];
        msetest = mse(xitest, yitest, wstar);
        msetestarray = [msetestarray, msetest];
        
        wstar10 = wreg(xitrain10, yitrain10, gamma(i));
        msetrain10 = mse(xitrain10, yitrain10, wstar10);
        msetrain10array = [msetrain10array, msetrain10];
        msetest10 = mse(xitest10, yitest10, wstar10);
        msetest10array = [msetest10array, msetest10];
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
    gammatestarray = [gammatestarray, mean(msetestarray)];
    gammatrain10array = [gammatrain10array, mean(msetrain10array)];
    gammatest10array = [gammatest10array, mean(msetest10array)];
end
gammatrainarray
gammatestarray
gammatrain10array
gammatest10array

col_1 = gammatrainarray';
col_2 = gammatestarray';
col_3 = gammatrain10array';
col_4 = gammatest10array';

f = figure;
t = uitable(f, 'Data', [col_1 col_2 col_3 col_4], 'Position', [20 20 760 800]);
t.ColumnName = {'Training Error', 'Test Error', 'Training Error 10 pts', 'Test Error 10 pts'};
%% plot the mes of the taining and test errors on a log scale for ease of comparison
figure
loglog(gamma,gammatrainarray,'r-')
hold on
loglog(gamma,gammatestarray,'b-')
hold on
loglog(gamma,gammatrain10array,'r--')
hold on
loglog(gamma,gammatest10array,'b--')
hold on
legend('train error 100 points','test error 100 points', 'train error 10 points','test error 10 points')