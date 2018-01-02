%%
clear
clear all
clc
seed = initialize();

%%
gammatestarray = [];
gammavalarray = [];
trainerrorarray = [];
testerrorarray = [];
gamma = 10.^[-6:3];
        
for i = -6:3
    msetestarray = [];
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
            testerror = mse(xitest, yitest, wstartrain);
            msetestarray = [msetestarray, testerror];
        end
        gammavalarray = [gammavalarray, mean(msevalarray)];
        gammatestarray = [gammatestarray, mean(msetestarray)];
    end
    trainerrorarray = [trainerrorarray, mean(gammavalarray)]; 
    testerrorarray = [testerrorarray, mean(gammatestarray)];
end

%%
figure
subplot(1,2,1)
loglog(gamma,trainerrorarray,'-s')
grid on
subplot(1,2,2)
loglog(gamma,testerrorarray,'-s')
grid on

%%
gammatestarray = [];
gammavalarray = [];
trainerrorarray = [];
testerrorarray = [];
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
            wstartrain = inv((setx'*setx)+(10.^i*length(setx)*eye))*(setx'*sety);
            mseval = mse(xitrain10(validation(fold,:),:), yitrain10(validation(fold,:),:), wstartrain);
            msevalarray = [msevalarray, mseval];
            testerror = mse(xitest10, yitest10, wstartrain);
            msetestarray = [msetestarray, testerror];
        end
        gammavalarray = [gammavalarray, mean(msevalarray)];
        gammatestarray = [gammatestarray, mean(msetestarray)];
    end
    trainerrorarray = [trainerrorarray, mean(gammavalarray)]; 
    testerrorarray = [testerrorarray, mean(gammatestarray)];
end

%%
figure
subplot(1,2,1)
loglog(gamma,trainerrorarray,'-s')
grid on
subplot(1,2,2)
loglog(gamma,testerrorarray,'-s')
grid on