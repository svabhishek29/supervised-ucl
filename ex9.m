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
trainerror_naive = mean(trainerrorarray);
testerror_naive = mean(testerrorarray);

std_train_naive = std(trainerrorarray);
std_test_naive = std(testerrorarray);

%% part 2
trainarray = [];
warray = [];
for i = 1:20
    train = datasample(boston,337,1);
    test = datasample(boston,169,1);

    trainy = train(:, 14);
    trainx = train(:,1:13);

    one = ones(length(trainx), 1);
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
trainerror_attr = mean(trainarray);
train_std_attr = std(trainarray);

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
testerror_attr = mean(testarray);
test_error_std = std(testarray);


%% part 3

trainarray = [];
w = 0;
for i = 1:20
    train = datasample(boston,337,1);
    test = datasample(boston,169,1);

    trainy = train(:, 14);
    trainx = train(:,1:13);

    one = ones(length(trainx), 1);
    set = horzcat(trainx, one);
    w = set \ trainy;
    msetrain = mse(set, trainy, w);
    trainarray = [trainarray; msetrain];
end
trainerror_all = mean(trainarray);
trainerror_all_std = std(trainarray);

testy = test(:, 14);
testx = test(:,1:13);

one = ones(length(testx), 1);
testarray = [];
for i = 1:20
    set = horzcat(testx, one);
    msetest = mse(set, testy, w);
    testarray = [testarray; msetest];
end
testerror_all = mean(testarray);
testerror_all_std = std(testarray);

%% plot the values on a figure

col_1 = [trainerror_naive; trainerror_attr'; trainerror_all];
col_2 = [std_train_naive; train_std_attr'; trainerror_all_std];

col_3 = [testerror_naive; testerror_attr'; testerror_all];
col_4 = [std_test_naive; test_error_std'; testerror_all_std];

f = figure;
t = uitable(f, 'Data', [col_1 col_2 col_3 col_4], 'Position', [20 20 900 900]);
t.ColumnName = {'train errror', '+/-std', 'test error', '+/-std'};
t.RowName = {'Naive Regression', 'attribute 1', 'attribute 2', 'attribute 3', 'attribute 4', 'attribute 5', 'attribute 6', 'attribute 7', 'attribute 8', 'attribute 9', 'attribute 10', 'attribute 11', 'attribute 12', 'attribute 13', 'attribute all'};