function sample_complexity(model, test_size_max, nmax, avg_size)
tic
switch model
    case 'onn'
        classifier = @onn;
        name = '1 Nearest Neighbour';
        
    case 'ls'
        classifier = @least_squares;
        name = 'Least Squares';
        
    case 'p'
        classifier = @perceptron;
        name = 'Perceptron';
        
    case 'w'
        classifier = @winnow;
        name = 'Winnow';
end

figure;

ms = [];
sds = [];

for n=1:nmax
    unsatisfied = true;
    
    m = 1;
    test_size = min(2^n, test_size_max);
    
    while unsatisfied
        error = 0;
        errors = [];
        for i=1:avg_size
            X = 2 * (randi([0 1], m+test_size, n) - 0.5);
            Y = X(:,1);

            Xtrain = X(1:m, :);
            Ytrain = Y(1:m, :);

            Xtest = X(m+1:end, :);
            Ytest = Y(m+1:end, :);

            errors = [error classifier(Xtrain, Xtest, Ytrain, Ytest)];
            
        end
        
        error = mean(errors);
        fprintf("n=%d m=%d error=%f\n", n, m, error);
        
        if error <= 0.1
            unsatisfied = false;
            ms = [ms m];
            sds = [sds std(errors)];
            
            errorbar(1:length(ms),ms,sds)
            xlabel('n')
            ylabel('m')
            title(name + " time elapsed: " +string(floor(toc))+"s")
            pause(0.0001)
            
            break
        end               
        m = m + 1;
    end    
end
end