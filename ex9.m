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
