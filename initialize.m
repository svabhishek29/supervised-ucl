function [Seed] = initialize()
%INITIALIZE Summary of this function goes here
%   Detailed explanation goes here
    Seed = 45645;
    s = RandStream('mt19937ar','Seed', Seed);
    RandStream.setGlobalStream(s);
end

