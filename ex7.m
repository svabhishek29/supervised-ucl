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
mean(msetestarray)

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
        wstarval1 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        valsetx = xitrain(21:40,:);
        valsety = yitrain(21:40,:);
        wstarval2 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        valsetx = xitrain(41:60,:);
        valsety = yitrain(41:60,:);
        wstarval3 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        valsetx = xitrain(61:80,:);
        valsety = yitrain(61:80,:);
        wstarval4 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        valsetx = xitrain(81:100,:);
        valsety = yitrain(81:100,:);
        wstarval5 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        meanwstar = (wstarval1 + wstarval2 + wstarval3 + wstarval4 + wstarval5) / 5;
        
        mseval = mse(valsetx, valsety, meanwstar);
        
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

    valsetx = xitrain(1:20,:);
    valsety = yitrain(1:20,:);
    wstarval1 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);

    valsetx = xitrain(21:40,:);
    valsety = yitrain(21:40,:);
    wstarval2 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);

    valsetx = xitrain(41:60,:);
    valsety = yitrain(41:60,:);
    wstarval3 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);

    valsetx = xitrain(61:80,:);
    valsety = yitrain(61:80,:);
    wstarval4 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);

    valsetx = xitrain(81:100,:);
    valsety = yitrain(81:100,:);
    wstarval5 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);

    meanwstar = (wstarval1 + wstarval2 + wstarval3 + wstarval4 + wstarval5) / 5;

    msetest = mse(xitest, yitest, meanwstar);

    msetestarray = [msetestarray, msetest];

end
gammatestarrayerror = mean(msetestarray)