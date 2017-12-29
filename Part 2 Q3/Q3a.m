clc
clear all
close all
warning('off', 'all')

test_size_max = 100000;
nmax = 100;
avg_size = 100;

% Choose model: onn=1 nearest neighbour, ls=least squares, p=perceptron, w=winnow    
sample_complexity('w', test_size_max, nmax, avg_size)
sample_complexity('p', test_size_max, nmax, avg_size)
sample_complexity('ls', test_size_max, nmax, avg_size)
sample_complexity('onn', test_size_max, nmax, avg_size)

