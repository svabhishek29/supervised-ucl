function [ w ] = wreg( X, Y, gamma )
w = ((X' * X + gamma * size(X,1) * eye(size(X,2))) \ X') * Y;
end

