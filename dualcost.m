function [error] = dualcost(k, y, alpha)
error = (k*alpha-y)'*(k*alpha-y)/length(y);
end