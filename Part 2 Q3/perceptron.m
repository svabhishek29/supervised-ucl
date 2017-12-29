function error = perceptron(Xtrain, Xtest, Ytrain, Ytest)

w = zeros(size(Xtrain, 2), 1);
M = 0;

for t=1:size(Xtrain, 1)
    ypred = sign(Xtrain(t, :) * w);
    
    if ypred * Ytrain(t) <= 0
        w = w + Ytrain(t) * Xtrain(t, :)';
        M = M + 1;
    end
end

Ypred = sign(Xtest * w);

error = calc_error(Ypred, Ytest);