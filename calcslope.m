function [slope] = calcslope( x, y )
    num = sum((x - mean(x)).*(y - mean(y)));
    den = sum((x-mean(x)).^2);
    if num == 0 && den == 0
        slope = 0;
    else
        slope = num/den;
    end
end