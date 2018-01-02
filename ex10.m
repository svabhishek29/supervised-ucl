clear all;
clc;
load('boston.mat');
close all;

gammas = 2.^(-40:-26); %-6
sigmas = 2.^(7:0.5:13); %23
K_all_norm = zeros(length(boston));

for i = 1:length(boston)
    for j = i:length(boston)
        x = (boston(i,1:end-1) - boston(j, 1:end-1));
        K_all_norm(i,j) = x*x';
        K_all_norm(j,i) = x*x';
    end
end

train = boston(1:340,:);
test = boston(341:end,:);

D = length(train);
folds = 5;

validation = [];
training = [];

for i=1:folds
    validation = [validation ; ((D/folds)*(i-1)+1:(D/folds)*i)];
    training = [training ; mod(((D/folds)*i+1 -1 : (D/folds)*(i+folds-1) - 1), D)+1];
end

costmatrix = zeros(length(sigmas), length(gammas));
for s=1:length(sigmas)
    sigma = sigmas(s);
    K_all = exp(-K_all_norm/(2*sigma^2));
    for g=1:length(gammas)
        gamma = gammas(g);
        alpha = [];
        costarray = [];
        for fold=1:folds
            K_train_train = K_all(training(fold,:), training(fold, :));
            K_val_train = K_all(validation(fold,:), training(fold, :));
            y_train = boston(training(fold,:),end);
            y_val = boston(validation(fold,:),end);
            
            alphastar = kridgereg(K_train_train,y_train,gamma);
            cost = dualcost(K_val_train, y_val, alphastar);
            costarray = [costarray, cost];
        end
        meancost = mean(costarray);
        costmatrix(s,g) = meancost;
    end
end

figure;
heatmap(costmatrix);

error = min(min(costmatrix));
[row,col] = find(costmatrix == error)

mingamma = gammas(col);
minsigma = sigmas(row);

K_all_best = exp(-K_all_norm/(2*minsigma^2));
K_test_train = K_all_best(341:end, 1:340);
K_train_train = K_all_best(1:340,1:340);

y_train = boston(1:340,end);
y_test = boston(341:end,end);

alphabest = kridgereg(K_train_train,y_train,mingamma);
trainerror = dualcost(K_train_train, y_train, alphabest)
testerror = dualcost(K_test_train, y_test, alphabest)
