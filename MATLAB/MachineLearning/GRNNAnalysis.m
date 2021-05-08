filepath = "C:\Users\aashi\Documents\Uni\Final year\Final Year Project\Automation\ParameterResultsRefined.csv";
filepath2 = "C:\Users\aashi\Documents\Uni\Final year\Final Year Project\Automation\TrainingRefined.csv";

[inAng, outAng, inAngDiff, L1, L2, pressure] = readvars(filepath);
p_full = [inAng, outAng, inAngDiff, L1, L2]'; % input
t_full = pressure'; % output

[inAng, outAng, inAngDiff, L1, L2, pressure] = readvars(filepath2);
p_test_original = [inAng, outAng, inAngDiff, L1, L2]'; % input
t_test = pressure'; % output



% testnum = 10;
% 
% p_test = p_full([10 20 30 40 50 60 70 80], :);
% 
% t_test = t_full([10 20 30 40 50 60 70 80], :);

resultNum = [27];
errorArray = zeros(1, length(resultNum));

for j = 1:length(resultNum)
    clear 'net' 'inputs' 'outputs' nnPressure
    n = resultNum(j);
    p = p_full(:, 1:n);
    t = t_full(:, 1:n);
    resultnum = length(p);
    testnum = round(resultnum/10);
    trainnum = resultnum - testnum;
    
    p_train = p;
    %p_test = p(trainnum+1:end, :);
    [p_train, inputs] = mapminmax(p_train);
    
    t_train = t;
    %t_test = t(trainnum+1:end, :);
    [t_train, outputs] = mapminmax(t_train);
    
    p_test = mapminmax('apply', p_test_original, inputs);
    
    net = newgrnn(p_train, t_train, 0.5);

    %% Validation
    errors = zeros(testnum, 1);
    nnPressure = sim(net, p_test);
    nnPressure = mapminmax('reverse', nnPressure, outputs);
    diff = abs((nnPressure - t_test)./t_test);
    avgError = mean(diff);
    %sim(net, p_test)
    errorArray(j) = avgError;
    
    
end
close all
plot(resultNum, errorArray*100, 'bx--')
grid
xlabel('Number of inputs', 'fontsize', 14);
ylabel('Percentage error', 'fontsize', 14);

disp("Average percentage error: " + num2str(avgError*100));