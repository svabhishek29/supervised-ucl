function [ mse ] = mse( x, y, w )
%MSE Summary of this function goes here
%   Detailed explanation goes here
mse = (1/length(x))*sum(((x*w) - y).^2);
end

