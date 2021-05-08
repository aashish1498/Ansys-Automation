function [thetaDMax] = DiffuserCSVGenerator(beta1, X1, X2)
r1 = 1;
r2 = 3.9;
mypath = 'C:/Users/aashi/Documents/Uni/Final year/Final Year Project/Automation/CSV/Diffuser/';
doplot = false;
%% DATA_1
filename = 'DATA_1';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1+0.2; X1+0.5];
MatrixExp(:,2) = r1;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_2
filename = 'DATA_2';
MatrixExp = zeros(5, 2);

MatrixExp(:,1) = [X1+0.5; X1+0.5+X2/4; X1+0.5+X2/2; X1+0.5+3*X2/4; X1+0.5+X2];
MatrixExp(:,2) = r1;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_3
filename = 'DATA_3';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1+X2+0.5; X1+X2+2];
MatrixExp(:,2) = r1;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))
%% DATA_4
filename = 'DATA_4';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1+0.2; X1+0.5];
MatrixExp(:,2) = r2;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_5
filename = 'DATA_5';
MatrixExp = zeros(5, 2);

MatrixExp(:,1) = [X1+0.5; X1+0.5+X2/4; X1+0.5+X2/2; X1+0.5+3*X2/4; X1+0.5+X2];
MatrixExp(:,2) = r2;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_6
filename = 'DATA_6';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1+X2+0.5; X1+X2+2];
MatrixExp(:,2) = r2;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_7
filename = 'DATA_7';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1+0.2; X1+0.2];
MatrixExp(:,2) = [r1; r2];

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_8
filename = 'DATA_8';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1+X2+2; X1+X2+2];
MatrixExp(:,2) = [r1; r2];

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_9
filename = 'DATA_9';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1+0.5; X1+0.5];
MatrixExp(:,2) = [r1; r2];

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_10
filename = 'DATA_10';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [X1+X2+0.5; X1+X2+0.5];
MatrixExp(:,2) = [r1; r2];

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA__11
filename = 'DATA_11';
MatrixExp = zeros(2, 2);

MatrixExp(:,1) = [0; X2];
MatrixExp(:,2) = [0.5; 0.5];

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))

%% DATA_TO_CHANGE
filename = 'DATA_TO_CHANGE';
N = 30;
[M, beta, thetaDMax] = betaCurveFitterDiffuser(beta1, X2, doplot, N);
MatrixExp = zeros(N, 2); % M, Beta
MatrixExp(:,1) = M;
MatrixExp(:,2) = beta;

writematrix(MatrixExp, strcat(mypath, filename, '.csv'))