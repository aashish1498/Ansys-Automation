function [M, beta, thetaDMax] = betaCurveFitterImpeller(beta1, beta2, X1, doplot, N) 
close all;
r = 1;
r2 = 3.9;
rmid = (r + r2)/2;
f = 0.99; % factor
b = -log(f*beta2 - beta1);
a = (-log((f - 1)*beta2) - b)/X1;

%%
% equation is: beta = -exp(-(a*M + b)) + f*beta2

beta = zeros(N,1);
theta = zeros(N,1);
M = linspace(0,X1,N);
for i = 1:N
 theta(i) = trapz(tand(beta))/r * (M(2) - M(1))/rmid; % in radians
 beta(i) = -exp(-(a*M(i) + b)) + f*beta2;

end

thetaD = theta * 180/pi;
%% Plot
if(doplot)
    plot(M, beta);
    xlim([0 X1]);
    figure
    plot(M, thetaD);
    xlim([0 X1]);
end
%% Export
thetaDMax = max(abs(thetaD));
if(thetaDMax > 360)
    warning(strcat("For input angles ", num2str(beta1), " and ", num2str(beta2), ...
        ", theta exceeds 360 degrees. Max theta  = ", num2str(thetaDMax)));
end

