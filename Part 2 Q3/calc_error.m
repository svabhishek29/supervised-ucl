function error = calc_error(Ypred, Ytest)
error = sum((Ypred - Ytest) ~= 0) / length(Ytest);
end