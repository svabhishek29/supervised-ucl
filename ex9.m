%%
clear
clear all
clc
seed = initialize();
load('boston.mat');

%% part 1
trainerrorarray = [];
testerrorarray = [];
for i = 1:20
    train = datasample(boston,337,1);
    test = datasample(boston,169,1);

    trainy = train(:, 14);
    trainx = ones(length(train),1);

    testy = test(:, 14);
    testx = ones(length(test),1);

    slope = calcslope(trainx, trainy);
    intercept = calcintercept(trainx, trainy, slope);

    prediction_train = prediction(slope, trainx, intercept);
    prediction_test = prediction(slope, testx, intercept);

    train_error = bostonmse(prediction_train, trainy);
    trainerrorarray = [trainerrorarray, train_error];
    test_error = bostonmse(prediction_test, testy);
    testerrorarray = [testerrorarray, test_error];
end
trainerror = mean(trainerrorarray)
testerror = mean(testerrorarray)

%% part 2

train = datasample(boston,337,1);
test = datasample(boston,169,1);

trainy = train(:, 14);
trainx = train(:,1:13);

one = ones(length(trainx), 1);
trainarray = [];
warray = [];
for i = 1:20
    setarray = [];
    for j = 1:13
        set = horzcat(trainx(:,j), one);
        w = set \ trainy;
        msetrain = mse(set, trainy, w);
        setarray = [setarray, msetrain];
        warray = [warray, w];
    end
    trainarray = [trainarray; setarray];
end
trainerror = mean(trainarray)

testy = test(:, 14);
testx = test(:,1:13);

one = ones(length(testx), 1);
testarray = [];

for i = 1:20
    setarray = [];
    for j = 1:13
        set = horzcat(testx(:,j), one);
        msetest = mse(set, testy, warray(:,j));
        setarray = [setarray, msetest];
    end
    testarray = [testarray; setarray];
end
testerror = mean(testarray)

%% part 3

train = datasample(boston,337,1);
test = datasample(boston,169,1);

trainy = train(:, 14);
trainx = train(:,1:13);

one = ones(length(trainx), 1);
trainarray = [];
w = 0;
for i = 1:20
    set = horzcat(trainx, one);
    w = set \ trainy;
    msetrain = mse(set, trainy, w);
    trainarray = [trainarray; msetrain];
end
trainerror = mean(trainarray)

testy = test(:, 14);
testx = test(:,1:13);

one = ones(length(testx), 1);
testarray = [];
for i = 1:20
    set = horzcat(testx, one);
    msetest = mse(set, testy, w);
    testarray = [testarray; msetest];
end
testerror = mean(testarray)

