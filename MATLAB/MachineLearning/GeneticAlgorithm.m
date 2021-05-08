fitnessfcn=@ObjectiveFunction; %call function
nvars=5;
lb=[4 40 4 5 5]; % Variable lower bounds
ub=[35 55 35 18 18]; % Variable upper bounds
A=[];
b=[]; 
Aeq=[];
beq=[];
n = 34;

options=optimoptions('gamultiobj', 'PopulationSize', n, 'Display', 'final'); 
%setup
[x,fval, exitflag,output]=gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options);
disp("Impeller inlet angle: " + num2str(x(1)));
disp("Impeller outlet angle: " + num2str(x(2)));
disp("Diffuser inlet angle: " + num2str(x(3)));
disp("Impeller length: " + num2str(x(4)));
disp("Diffuser length: " + num2str(x(5)));