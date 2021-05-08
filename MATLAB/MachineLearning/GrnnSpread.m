clear
filepath = "C:\Users\aashi\Documents\Uni\Final year\Final Year Project\Automation\ParameterResults.csv";
[inAng, outAng, inAngDiff, L1, L2, pressure] = readvars(filepath);
p = [inAng, outAng, inAngDiff, L1, L2]'; % input
t = pressure'; % output

resultnum = length(p);
testnum = round(resultnum/10);
trainnum = resultnum - testnum;

p_train = p(:, 1:trainnum);
p_test = p(:, trainnum+1:end);

[p_train, inputs] = mapminmax(p_train);

t_train = t(:, 1:trainnum);
t_test = t(:, trainnum+1:end);

[t_train, outputs] = mapminmax(t_train);

p_test = mapminmax('apply', p_test, inputs);

spreads = [0.05:0.05:2];
for j = 1:length(spreads)
    spread = spreads(j);
    for i = 1:10
        net = newgrnn(p_train, t_train, spread);
    end
    
    %% Validation
    nnPressure = sim(net, p_test);
    nnPressure = mapminmax('reverse', nnPressure, outputs);
    diff = abs((nnPressure - t_test)./t_test);
    avgError = mean(diff);
    errorArr(j) = avgError;
    
end
%sim(net, p_test)
disp("Average percentage error: " + num2str(avgError*100));

expectedPressure = 8000;

plot(spreads, errorArr*100, 'bx--')
grid
xlabel('Spread', 'FontSize', 14)
ylabel('Percentage error', 'FontSize', 14)
