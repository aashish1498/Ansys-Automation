function [y]=ObjectiveFunction(x) 
load('net.mat');
x = mapminmax('apply', x', inputs);
y = abs(sim(net, x) - expectedPressure);
y = mapminmax('reverse', y, outputs);
end
