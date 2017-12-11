function [ w, ni, xi, yi, xitrain, xitest, yitrain, yitest, xitrain10, xitest10, yitrain10, yitest10 ] = generate( nDim, nData )
%GENERATE Summary of this function goes here
%   Detailed explanation goes here
w = randn(nDim,1);
ni = randn(nData, 1);
xi = randn(nData, nDim);
yi = (xi*w) + ni;

if (nDim == 1)
    xitrain = xi(1:100);
    xitest = xi(101:end);
    xitrain10 = xi(1:10);
    xitest10 = xi(11:end);
else
    xitrain = xi(1:100,:);
    xitest = xi(101:end,:);
    xitrain10 = xi(1:10, :);
    xitest10 = xi(11:end, :);
end

yitrain = yi(1:100);
yitest = yi(101:end);

yitrain10 = yi(1:10);
yitest10 = yi(11:end);
end

