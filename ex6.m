%%
clear
clear all
clc
seed = initialize();

%%
gammatrainarray = [];
gammatestarray = [];
gammavalarray = [];
gamma = 10.^[-6:3];
        
for i = -6:3
    msetrainarray = [];
    msetestarray = [];
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
        msetrain = mse(xitrain, yitrain, meanwstar);
        msetest = mse(xitest, yitest, meanwstar);
        
        msetrainarray = [msetrainarray, msetrain];
        msetestarray = [msetestarray, msetest];
        msevalarray = [msevalarray, mseval];
        
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
    gammatestarray = [gammatestarray, mean(msetestarray)];
    gammavalarray = [gammavalarray, mean(msevalarray)];
end

%%
figure
subplot(1,3,1)
loglog(gamma,gammatrainarray,'-s')
grid on
subplot(1,3,2)
loglog(gamma,gammatestarray,'-s')
grid on
subplot(1,3,3)
loglog(gamma,gammavalarray,'-s')
grid on

%%
gammatrainarray = [];
gammatestarray = [];
gammavalarray = [];
gamma = 10.^[-6:3];
        
for i = -6:3
    msetrainarray = [];
    msetestarray = [];
    msevalarray = [];

    for j = 1:200
        nDim = 10;
        nData = 600;
        [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
        
        valsetx = xitrain10(1:2,:);
        valsety = yitrain10(1:2,:);
        wstarval1 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        valsetx = xitrain10(3:4,:);
        valsety = yitrain10(3:4,:);
        wstarval2 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        valsetx = xitrain10(5:6,:);
        valsety = yitrain10(5:6,:);
        wstarval3 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        valsetx = xitrain10(7:8,:);
        valsety = yitrain10(7:8,:);
        wstarval4 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        valsetx = xitrain10(9:10,:);
        valsety = yitrain10(9:10,:);
        wstarval5 = inv((valsetx'*valsetx)+(10.^i*length(valsetx)*eye))*(valsetx'*valsety);
        
        meanwstar = (wstarval1 + wstarval2 + wstarval3 + wstarval4 + wstarval5) / 5;
        
        mseval = mse(valsetx, valsety, meanwstar);
        msetrain = mse(xitrain10, yitrain10, meanwstar);
        msetest = mse(xitest, yitest, meanwstar);
        
        msetrainarray = [msetrainarray, msetrain];
        msetestarray = [msetestarray, msetest];
        msevalarray = [msevalarray, mseval];
        
    end
    gammatrainarray = [gammatrainarray, mean(msetrainarray)];
    gammatestarray = [gammatestarray, mean(msetestarray)];
    gammavalarray = [gammavalarray, mean(msevalarray)];
end

%%
figure
subplot(1,3,1)
loglog(gamma,gammatrainarray,'-s')
grid on
subplot(1,3,2)
loglog(gamma,gammatestarray,'-s')
grid on
subplot(1,3,3)
loglog(gamma,gammavalarray,'-s')
grid on