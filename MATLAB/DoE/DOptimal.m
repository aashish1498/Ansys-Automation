filepath = "C:\Users\aashi\Documents\Uni\Final year\Final Year Project\Automation\DOEParameters.csv";
nfactors = 5;
nruns = 80;

inletAngle = [4;35];
outletAngle = [40;55];
diffInlet = [4;35];
impLen = [5;18];
diffLen = [5;18];

bounds = [inletAngle, outletAngle, diffInlet, impLen, diffLen];

levels = [12, 19, 16, 14, 18];
[dCE,X] = cordexch(nfactors,nruns, 'linear', 'categorical', [1 2 3 4 5], 'levels', levels, 'bounds', bounds);
dCE
%writematrix(dCE, filepath)