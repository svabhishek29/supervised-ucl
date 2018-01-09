%% clear all the variables and initiate a seed for the calculations 
clear
clear all
clc
seed = initialize();

%% ex-4 - reduce the training error
gammatrainarray = [];
gamma = 10.^[-6:3];
        
for i = 1:10
    msetrainarray = [];
    for j = 1:200
        nDim = 10;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

        wstar = wreg(xitrain10, yitrain10, gamma(i));
        msetrain = mse(xitrain10, yitrain10, wstar);
        msetrainarray = [msetrainarray, msetrain];
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
end
mean_ex4 = mean(gammatrainarray);
std_ex4 = std(gammatrainarray);

%% take the lowes training error and fing the gamma that gave that error and find the test error with that
[v, i] = min(gammatrainarray);
mingamma = gamma(i);

msetestarray = [];
for j = 1:200
    nDim = 10;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

    wstar = wreg(xitrain10, yitrain10, mingamma);
    msetrain = mse(xitest10, yitest10, wstar);
    msetestarray = [msetestarray, msetrain];
end
testerror_ex4 = mean(msetestarray);

%% ex-5 - calculate the validation error and find the minimum
gammavalarray = [];
gamma = 10.^[-6:3];
        
for i = 1:10
    msevalarray = [];

    for j = 1:200
        nDim = 10;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
        
        valsetx = xitrain10(1:2,:);
        valsety = yitrain10(1:2,:);
        trainsetx = xitrain10(3:end,:);
        trainsety = yitrain10(3:end,:);
        
        wstarval = wreg(trainsetx, trainsety, gamma(i));
        
        mseval = mse(valsetx, valsety, wstarval);
        
        msevalarray = [msevalarray, mseval];
        
    end
    gammavalarray = [gammavalarray, mean(msevalarray)];
end
mean_ex5 = mean(gammavalarray);
std_ex5 = std(gammavalarray);

%% using the minimum vaildation error find the gamma and use that to find the test error
msetestarray = [];
[v, i] = min(gammavalarray);
mingamma = gamma(i);

for j = 1:200
    nDim = 10;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

    valsetx = xitrain10(1:2,:);
    valsety = yitrain10(1:2,:);
    trainsetx = xitrain10(3:end,:);
    trainsety = yitrain10(3:end,:);
    
    wstarval = wreg(trainsetx, trainsety, mingamma);

    msetest = mse(xitest10, yitest10, wstarval);

    msetestarray = [msetestarray, msetest];

end
testerror_ex5 = mean(msetestarray);

%% ex-6 - using cross validation to find the lowest validation score

gammatrainarray = [];
gamma = 10.^[-6:3];
        
for i = -6:3
    for j = 1:200
        msetrainarray = [];
        msevalarray = [];
        nDim = 10;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
        D = length(xitrain10);
        folds = 5;

        validation = [];
        training = [];

        for i=1:folds
            validation = [validation ; ((D/folds)*(i-1)+1:(D/folds)*i)];
            training = [training ; mod(((D/folds)*i+1 -1 : (D/folds)*(i+folds-1) - 1), D)+1];
        end
        for fold=1:folds
            setx = xitrain10(training(fold,:),:);
            sety = yitrain10(training(fold,:),:);
            wstartrain = wreg(setx, sety, gamma(i));
            mseval = mse(xitrain10(validation(fold,:),:), yitrain10(validation(fold,:),:), wstartrain);
            msevalarray = [msevalarray, mseval];
        end
        
        msetrainarray = [msetrainarray, mean(msevalarray)];
        
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
end
mean_ex6 = mean(gammatrainarray);
std_ex6 = std(gammatrainarray);

%% use the lowest validation score to find the gamma, with it find the test error
msetestarray = [];
[v, i] = min(gammatrainarray);
mingamma = gamma(i);
for j = 1:200
    nDim = 10;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);

    setx = xitrain10;
    sety = yitrain10;
    wstarval = wreg(setx, sety, mingamma);

    msetest = mse(xitest10, yitest10, wstarval);

    msetestarray = [msetestarray, msetest];

end
testerror_ex6 = mean(msetestarray);

%% plot the data on the output
col_1 = [mean_ex4; std_ex4; testerror_ex4];
col_2 = [mean_ex5; std_ex5; testerror_ex5];
col_3 = [mean_ex6; std_ex6; testerror_ex6];
f = figure;
t = uitable(f, 'Data', [col_1 col_2 col_3], 'Position', [20 20 500 300]);
t.ColumnName = {'Ex4', 'Ex5', 'Ex6'};
t.RowName = {'Mean Train Error', 'Std train error', 'Mean test error'};