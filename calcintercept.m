function [intercept] = calcintercept(x, y, slope)
    intercept = mean(y) - slope * mean(x);
end