function [ mse ] = bostonmse( prediction, target )
%MSE Summary of this function goes here
%   Detailed explanation goes here
mse = (1/length(prediction))*sum((prediction - target).^2);
end