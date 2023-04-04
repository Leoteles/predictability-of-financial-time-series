%Teste da estima��o de uma estrutura ARCH1

%???????????????????????????????
%por minimos quadrados classico
%???????????????????????????????

clear all;
close all;
clc;
randn('state',0);

%Cria-se um vetor de N posi��es representando uma estrutura ARCH(1)
N = 3500;
alfa0 = 1;
alfa1 = 0.3;

var_e(1) = alfa0;%Vari�ncia inicial
e(1) = sqrt(var_e(1))*randn(1,1);
y(1) = e(1);
for t = 2:N
    
    %Processo da vari�ncia
    var_e(t) = alfa0 + alfa1 * y(t-1)^2;
    
    %Inova��o de vari�ncia var_e e m�dia 0
    e(t) = sqrt(var_e(t)) * randn(1,1);
    
    %Valor da s�rie no instante t
    y(t) = e(t);
        
end
y = y';%y �, por conven��o, vetor coluna

figure;
plot(y(1:end),'-r');

figure;
autocorr(y);

figure;
autocorr(y.^2-mean(y.^2));


[H,P,Qstat,CV] = lbqtest(y , [10 15 20]' , 0.05);
disp('lbq y(t)');
[H,P,Qstat,CV]
[H,P,Qstat,CV] = lbqtest(y.^2-mean(y.^2) , [10 15 20]' , 0.05);
disp('lbq y(t)^2');
[H,P,Qstat,CV]

var_jan = var_janela(y,100);

figure;
plot(var_jan,'-r');

[coeff,errors,LLF,innovations,sigmas,summary] = garchfit(y);

garchdisp(coeff,errors);
%                              Standard          T     
%   Parameter       Value          Error       Statistic 
%  -----------   -----------   ------------   -----------
%            C    0.0038928      0.011027         0.3530
%            K    0.99252        0.031493        31.5154
%     GARCH(1)    0.0069375      0.016584         0.4183
%      ARCH(1)    0.38464        0.017561        21.9029
%
% Modelo ARCH1:
% %Processo da vari�ncia
% var_e(t) = alfa0 + alfa1 * y(t-1)^2;
% 
% %Inova��o de vari�ncia var_e e m�dia 0
% e(t) = sqrt(var_e(t)) * randn(1,1);
% 
% %Valor da s�rie no instante t
% y(t) = e(t);
% 
% em que:
% alfa0 = K
% alfa1 = ARCH(1)


