%% clear all the variables and initiate a seed for the calculations 
clear
clear all
clc
seed = initialize();

%% for every 200 iterations iterate over the gamma range and find the validation error, then use that that find the index of the gamma that gave the least validation error
gamma_min_iter_small = zeros(200:1);
gamma_min_iter_big = zeros(200:1);
gamma = 10.^[-6:3];

for iter=1:200
    nDim = 10;
    nData = 600;
    [w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10] = generate(nDim, nData);
    
    MSE_Reg_Validation_Small = zeros(10:1);
    MSE_Reg_Validation_Big = zeros(10:1);
    
    valsetx = xitrain(1:20,:);
    valsety = yitrain(1:20,:);
    trainsetx = xitrain(21:end,:);
    trainsety = yitrain(21:end,:);

    valsetx10 = xitrain10(1:2,:);
    valsety10 = yitrain10(1:2,:);
    trainsetx10 = xitrain10(3:end,:);
    trainsety10 = yitrain10(3:end,:);
    
    for i = 1:10        
        wstarval = wreg(trainsetx, trainsety, gamma(i));
        mseval = mse(valsetx, valsety, wstarval);
        MSE_Reg_Validation_Big(i) = mseval;
        
        wstarval = wreg(trainsetx10, trainsety10, gamma(i));
        mseval = mse(valsetx10, valsety10, wstarval);
        MSE_Reg_Validation_Small(i) = mseval;
    end
    
    [~, min_index_small] = min(MSE_Reg_Validation_Small);
    [~, min_index_big] = min(MSE_Reg_Validation_Big);  
    
    gamma_min_iter_small(iter) = 10^(min_index_small - 7);
    gamma_min_iter_big(iter) = 10^(min_index_big - 7);
end

%% average over the mean values for the 100 and 10 data points gamma values
gamma_min_small_mean = mean(gamma_min_iter_small)
gamma_min_small_big = mean(gamma_min_iter_big)