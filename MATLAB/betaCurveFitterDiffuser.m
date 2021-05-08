function [M, beta, thetaDMax] = betaCurveFitterDiffuser(beta1, X2, doplot, N) 
close all;
r = 1;
r2 = 3.9;
rmid = (r + r2)/2;
a = beta1/X2^2;
%%
% equation is: beta = a*(M-x1)^2

beta = zeros(N,1);
theta = zeros(N,1);
M = linspace(0,X2,N);
for i = 1:N
 theta(i) = trapz(tand(beta))/r * (M(2) - M(1))/rmid; % in radians
 beta(i) = a*(M(i)-X2)^2;
end

thetaD = theta * 180/pi;
%% Plot
if(doplot)
    plot(M, beta);
    xlim([0 X2]);
    figure
    plot(M, thetaD);
    xlim([0 X2]);
end

%% Export
thetaDMax = max(abs(thetaD));
if(thetaDMax > 360)
    warning(strcat("For diffuser input angle ", num2str(beta1), ...
        ", theta exceeds 360 degrees. Max theta  = ", num2str(thetaDMax)));
end

