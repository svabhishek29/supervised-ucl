function [ mse ] = mse( X, Y, w )
mse = (w' * X' * X * w - 2 * Y' * X * w + Y' * Y) / size(X,1);
end

