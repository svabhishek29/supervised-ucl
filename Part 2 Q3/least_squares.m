function error = least_squares(Xtrain, Xtest, Ytrain, Ytest)

% Add bias terms
Xtrain = [ones(size(Xtrain, 1),1) Xtrain];
Xtest = [ones(size(Xtest, 1),1) Xtest];

% Least squares training
w = ((Xtrain' * Xtrain) \ Xtrain') * Ytrain;

% Calculate Ypred
Ypred = sign(Xtest * w);

% Calculate error
error = calc_error(Ypred, Ytest);
end