%% clear all the variables and initiate a seed for the calculations 
clear
clear all
clc
seed = initialize();

%% for entire gamma range repeate the ridge regression 200 times and average the validation, train, test errors for 100 datapoints
gammatrainarray = [];
gammatestarray = [];
gammavalarray = [];
gamma = 10.^[-6:3];
        
for i = 1:10
    msetrainarray = [];
    msetestarray = [];
    msevalarray = [];

    for j = 1:200
        nDim = 1;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
        
        valsetx = xitrain(1:20,:);
        valsety = yitrain(1:20,:);
        trainsetx = xitrain(21:end,:);
        trainsety = yitrain(21:end,:);
        
        wstarval = wreg(trainsetx, trainsety, gamma(i));
        
        mseval = mse(valsetx, valsety, wstarval);
        msetrain = mse(trainsetx, trainsety, wstarval);
        msetest = mse(xitest, yitest, wstarval);
        
        msetrainarray = [msetrainarray, msetrain];
        msetestarray = [msetestarray, msetest];
        msevalarray = [msevalarray, mseval];
        
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
    gammatestarray = [gammatestarray, mean(msetestarray)];
    gammavalarray = [gammavalarray, mean(msevalarray)];
end
gammavalarray

%% plot the figures
figure
loglog(gamma,gammatrainarray,'r-')
hold on
loglog(gamma,gammatestarray,'b-')
hold on
loglog(gamma,gammavalarray,'r--')
hold on
legend('train error','test error', 'validation error')

%% by taking the minimum of the validation error from the previous step we get the gamma index and use that to find the test error
msetestarray = [];
[v, i] = min(gammavalarray);

for j = 1:200
    nDim = 1;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

    wstarval = inv((xitrain'*xitrain)+(gamma(i)*nDim*eye(nDim)))*(xitrain'*yitrain);

    msetest = mse(xitest, yitest, wstarval);

    msetestarray = [msetestarray, msetest];

end
gammatestarrayerror = mean(msetestarray)

%% for entire gamma range repeate the ridge regression 200 times and average the validation, train, test errors for 10 datapoints
gammatrainarray = [];
gammatestarray = [];
gammavalarray = [];
gamma = 10.^[-6:3];
        
for i = 1:10
    msetrainarray = [];
    msetestarray = [];
    msevalarray = [];

    for j = 1:200
        nDim = 1;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
        
        valsetx = xitrain10(1:2,:);
        valsety = yitrain10(1:2,:);
        trainsetx = xitrain10(3:end,:);
        trainsety = yitrain10(3:end,:);
        
        wstarval = wreg(trainsetx, trainsety, gamma(i));
        
        mseval = mse(valsetx, valsety, wstarval);
        msetrain = mse(trainsetx, trainsety, wstarval);
        msetest = mse(xitest, yitest, wstarval);
        
        msetrainarray = [msetrainarray, msetrain];
        msetestarray = [msetestarray, msetest];
        msevalarray = [msevalarray, mseval];
        
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
    gammatestarray = [gammatestarray, mean(msetestarray)];
    gammavalarray = [gammavalarray, mean(msevalarray)];
end
gammavalarray

%% plot the figures
figure
loglog(gamma,gammatrainarray,'r-')
hold on
loglog(gamma,gammatestarray,'b-')
hold on
loglog(gamma,gammavalarray,'r--')
hold on
legend('train error','test error', 'validation error')

%% by taking the minimum of the validation error from the previous step we get the gamma index and use that to find the test error        
msetestarray = [];
[v, i] = min(gammavalarray);

for j = 1:200
    nDim = 1;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

    wstarval = inv((xitrain10'*xitrain10)+(gamma(i)*nDim*eye(nDim)))*(xitrain10'*yitrain10);

    msetest = mse(xitest, yitest, wstarval);

    msetestarray = [msetestarray, msetest];

end
gammatestarrayerror = mean(msetestarray)
