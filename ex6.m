%% clear all the variables and initiate a seed for the calculations 
clear
clear all
clc
seed = initialize();

%% for the entire gamma range perform 5 fold cross validation and get the average train test and validation errors for 100 data points
gammatestarray = [];
gammavalarray = [];
gammatrainarray = [];
trainerrorarray = [];
testerrorarray = [];
validationerror = [];
gamma = 10.^[-6:3];
        
for i = 1:10
    msetestarray = [];
    msevalarray = [];
    msetrainarray = [];
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
            wstartrain = wreg(setx, sety, gamma(i));
            mseval = mse(xitrain(validation(fold,:),:), yitrain(validation(fold,:),:), wstartrain);
            msevalarray = [msevalarray, mseval];
            trainerror = mse(setx, sety, wstartrain);
            msetrainarray = [msetrainarray, trainerror];
            testerror = mse(xitest, yitest, wstartrain);
            msetestarray = [msetestarray, testerror];
        end
        gammavalarray = [gammavalarray, mean(msevalarray)];
        gammatrainarray = [gammatrainarray, mean(msetrainarray)];
        gammatestarray = [gammatestarray, mean(msetestarray)];
        
    end
    trainerrorarray = [trainerrorarray, mean(gammatrainarray)]; 
    testerrorarray = [testerrorarray, mean(gammatestarray)];
    validationerror = [validationerror, mean(gammavalarray)];
end

col_1 = trainerrorarray';
col_2 = validationerror';
col_3 = testerrorarray';
%% plot the numbers in coloums
f = figure;
t = uitable(f, 'Data', [col_1 col_2 col_3]);
t.ColumnName = {'Training Error', 'Val Error', 'Test Error'};

%% plot the figure
figure
loglog(gamma,trainerrorarray,'-s')
hold on
loglog(gamma,testerrorarray,'-s')
hold on
loglog(gamma,validationerror,'-s')
hold on

%% for the entire gamma range perform 5 fold cross validation and get the average train test and validation errors for 10 data points
gammatestarray = [];
gammavalarray = [];
trainerrorarray = [];
testerrorarray = [];
validationerror = [];
gamma = 10.^[-6:3];
        
for i = -6:3
    msetestarray = [];
    msevalarray = [];
    for j = 1:200
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
            trainerror = mse(setx, sety, wstartrain);
            msetrainarray = [msetrainarray, trainerror];
            testerror = mse(xitest10, yitest10, wstartrain);
            msetestarray = [msetestarray, testerror];
        end
        gammavalarray = [gammavalarray, mean(msevalarray)];
        gammatrainarray = [gammatrainarray, mean(msetrainarray)];
        gammatestarray = [gammatestarray, mean(msetestarray)];
        
    end
    trainerrorarray = [trainerrorarray, mean(gammatrainarray)]; 
    testerrorarray = [testerrorarray, mean(gammatestarray)];
    validationerror = [validationerror, mean(gammavalarray)];
end

col_1 = trainerrorarray';
col_2 = validationerror';
col_3 = testerrorarray';
%% plot the numbers in coloums
f = figure;
t = uitable(f, 'Data', [col_1 col_2 col_3]);
t.ColumnName = {'Training Error', 'Val Error', 'Test Error'};
%% plot the figure
figure
loglog(gamma,trainerrorarray,'-s')
hold on
loglog(gamma,testerrorarray,'-s')
hold on
loglog(gamma,validationerror,'-s')
hold on