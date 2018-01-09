%% clear all the variables and initiate a seed for the calculations 
clear
clear all
clc
seed = initialize();

%%
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

%%
figure
loglog(gamma,gammatrainarray,'-s')
hold on
loglog(gamma,gammatestarray,'-s')
hold on
loglog(gamma,gammavalarray,'-s')
hold on

%%        
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

%%
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

%%
figure
loglog(gamma,gammatrainarray,'-s')
hold on
loglog(gamma,gammatestarray,'-s')
hold on
loglog(gamma,gammavalarray,'-s')
hold on

%%        
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
