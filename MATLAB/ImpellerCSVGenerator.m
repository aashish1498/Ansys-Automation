function [thetaDMax] = ImpellerCSVGenerator(beta1,beta2, X1)
r1 = 1;
r2 = 3.9;
mypath = 'C:/Users/aashi/Documents/Uni/Final year/Final Year Project/Automation/CSV/Impeller/';
doplot = false;
%% HUB_INNER_DATA
filename = 'HUB_INNER_DATA';
MatrixExp = zeros(5, 2);

MatrixExp(:,1) = [0; X1/4; X1/2; 3*X1/4; X1];
MatrixExp(:,2) = r1;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DOWNSTREAM_INNER_DATA
filename = 'DOWNSTREAM_INNER_DATA';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1; X1+0.2];
MatrixExp(:,2) = r1;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% HUB_OUTER_DATA
filename = 'HUB_OUTER_DATA';
MatrixExp = zeros(5, 2);

MatrixExp(:,1) = [0; X1/4; X1/2; 3*X1/4; X1];
MatrixExp(:,2) = r2;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DOWNSTREAM_OUTER_DATA
filename = 'DOWNSTREAM_OUTER_DATA';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1; X1+0.2];
MatrixExp(:,2) = r2;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% EXHAUST_MERIDIONAL_DATA
filename = 'EXHAUST_MERIDIONAL_DATA';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1+0.2; X1+0.2];
MatrixExp(:,2) = [r1; r2];

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% M_DATA_1
filename = 'M_DATA_1';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1; X1];
MatrixExp(:,2) = [r1; r2];

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% M_DATA_2
filename = 'M_DATA_2';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [0; X1];
MatrixExp(:,2) = 0.5;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_TO_CHANGE
filename = 'DATA_TO_CHANGE';
N = 30;
[M, beta, thetaDMax] = betaCurveFitterImpeller(beta1, beta2, X1, doplot, N);
MatrixExp = zeros(N, 2); % M, Beta
MatrixExp(:,1) = M;
MatrixExp(:,2) = beta;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))


