function error = winnow(Xtrain, Xtest, Ytrain, Ytest)
Xtrain = (Xtrain + 1) / 2;
Xtest = (Xtest + 1) / 2;
Ytrain = (Ytrain + 1) / 2;

w = ones(size(Xtrain, 2), 1);

for t=1:size(Xtrain, 1)
    
    ypred = (Xtrain(t, :) * w >= size(Xtrain, 2));
    
    if Ytrain(t) ~= ypred
        w = w .* 2.^((Ytrain(t) - ypred) * Xtrain(t, :)');
    end
end

Ypred = sign((Xtest * w >= size(Xtrain, 2)) - 0.5);

error = calc_error(Ypred, Ytest);
end