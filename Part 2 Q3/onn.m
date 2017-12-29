function error = onn(Xtrain, Xtest, Ytrain, Ytest)

Ypred = zeros(size(Xtest, 1), 1);

for m=1:size(Xtest, 1)
    Xdiff = Xtrain - Xtest(m, :);
    Xdist = sum(Xdiff.^2, 2);
    [value, index] = min(Xdist);
    Ypred(m) = Ytrain(index);
end

[Ypred Ytest];

error = calc_error(Ypred, Ytest);
end