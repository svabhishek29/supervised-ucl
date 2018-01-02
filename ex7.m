%%
clear
clear all
clc
seed = initialize();

%% ex-4
gammatrainarray = [];
gamma = 10.^[-6:3];
        
for i = -6:3
    msetrainarray = [];
    for j = 1:200
        nDim = 10;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

        wstar = inv((xitrain'*xitrain)+(10.^i*length(xitrain)*eye))*(xitrain'*yitrain);
        msetrain = mse(xitrain, yitrain, wstar);
        msetrainarray = [msetrainarray, msetrain];
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
end
gammatrainarray

%%
[v, i] = min(gammatrainarray);
mingamma = gamma(i);

msetestarray = [];
for j = 1:200
    nDim = 10;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

    wstar = inv((xitrain'*xitrain)+(mingamma*length(xitrain)*eye))*(xitrain'*yitrain);
    msetrain = mse(xitest, yitest, wstar);
    msetestarray = [msetestarray, msetrain];
end
testerror = mean(msetestarray)

%% ex-5
gammavalarray = [];
gamma = 10.^[-6:3];
        
for i = -6:3
    msevalarray = [];

    for j = 1:200
        nDim = 10;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
        
        valsetx = xitrain(1:20,:);
        valsety = yitrain(1:20,:);
        
        wstarval = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        mseval = mse(valsetx, valsety, wstarval);
        
        msevalarray = [msevalarray, mseval];
        
    end
    gammavalarray = [gammavalarray, mean(msevalarray)];
end
gammavalarray

%%
msetestarray = [];
[v, i] = min(gammavalarray);

for j = 1:200
    nDim = 10;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

    wstarval = inv((xitrain'*xitrain)+(gamma(i)*length(xitrain)*eye))*(xitrain'*yitrain);

    msetest = mse(xitest, yitest, wstarval);

    msetestarray = [msetestarray, msetest];

end
gammatestarrayerror = mean(msetestarray)

%% ex-6

gammatrainarray = [];
gamma = 10.^[-6:3];
        
for i = -6:3
    msetrainarray = [];
    msevalarray = [];

    for j = 1:200
        nDim = 10;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
        D = length(xitrain);
        folds = 5;

        validation = [];
        training = [];

        for i=1:folds
            validation = [validation ; ((D/folds)*(i-1)+1:(D/folds)*i)];
            training = [training ; mod(((D/folds)*i+1 -1 : (D/folds)*(i+folds-1) - 1), D)+1];
        end
        for fold=1:folds
            setx = xitrain(training(fold,:),:);
            sety = yitrain(training(fold,:),:);
            wstartrain = inv((setx'*setx)+(10.^i*length(setx)*eye))*(setx'*sety);
            mseval = mse(xitrain(validation(fold,:),:), yitrain(validation(fold,:),:), wstartrain);
            msevalarray = [msevalarray, mseval];
        end
        
        msetrainarray = [msetrainarray, mean(msevalarray)];
        
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
end
gammatrainarray

%%
msetestarray = [];
[v, i] = min(gammatrainarray);

for j = 1:200
    nDim = 10;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

    setx = xitrain(1:20,:);
    sety = yitrain(1:20,:);
    wstarval = inv((setx'*setx)+(10.^i*length(setx)*eye))*(setx'*sety);

    msetest = mse(xitest, yitest, wstarval);

    msetestarray = [msetestarray, msetest];

end
gammatestarrayerror = mean(msetestarray)