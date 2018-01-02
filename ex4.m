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
msetrainarray = [];
msetestarray = [];
gamma = 10.^[-6:3];
for i=-6:3
    wstar = inv((xitrain'*xitrain)+(10.^i*nDim*eye(nDim)))*(xitrain'*yitrain);
    msetrain = mse(xitrain, yitrain, wstar);
    msetrainarray = [msetrainarray, msetrain];
    msetest = mse(xitest, yitest, wstar);
    msetestarray = [msetestarray, msetrain];
end

%%
figure
subplot(1,2,1)
loglog(gamma,msetrainarray,'-s')
grid on
subplot(1,2,2)
loglog(gamma,msetestarray,'-s')
grid on

%%
msetrainarray = [];
msetestarray = [];
gamma = 10.^(-6:3);
for i=-6:3
    wstar10 = inv((xitrain10'*xitrain10)+(10.^i*nDim*eye(nDim)))*(xitrain10'*yitrain10);
    msetrain10 = mse(xitrain10, yitrain10, wstar10);
    msetrainarray = [msetrainarray, msetrain10];
    msetest10 = mse(xitest10, yitest10, wstar10);
    msetestarray = [msetestarray, msetrain10];
end

%%
figure
subplot(1,2,1)
loglog(gamma,msetrainarray,'-s')
grid on
subplot(1,2,2)
loglog(gamma,msetestarray,'-s')
grid on

%%
gammatrainarray = [];
gammatestarray = [];
gammatrain10array = [];
gammatest10array = [];
gamma = 10.^[-6:3];
        
for i = -6:3
    msetrainarray = [];
    msetestarray = [];
    msetrain10array = [];
    msetest10array = [];
    for j = 1:200
        nDim = 10;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

        wstar = inv((xitrain'*xitrain)+(10.^i*nDim*eye(nDim)))*(xitrain'*yitrain);
        msetrain = mse(xitrain, yitrain, wstar);
        msetrainarray = [msetrainarray, msetrain];
        msetest = mse(xitest, yitest, wstar);
        msetestarray = [msetestarray, msetrain];
        
        wstar10 = inv((xitrain10'*xitrain10)+(10.^i*nDim*eye(nDim)))*(xitrain10'*yitrain10);
        msetrain10 = mse(xitrain10, yitrain10, wstar10);
        msetrain10array = [msetrain10array, msetrain10];
        msetest10 = mse(xitest10, yitest10, wstar10);
        msetest10array = [msetest10array, msetrain10];
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
    gammatestarray = [gammatestarray, mean(msetestarray)];
    gammatrain10array = [gammatrain10array, mean(msetrain10array)];
    gammatest10array = [gammatest10array, mean(msetest10array)];
end

%%
figure
subplot(2,2,1)
loglog(gamma,gammatrainarray,'-s')
grid on
subplot(2,2,2)
loglog(gamma,gammatestarray,'-s')
grid on
subplot(2,2,3)
loglog(gamma,gammatrain10array,'-s')
grid on
subplot(2,2,4)
loglog(gamma,gammatest10array,'-s')
grid on