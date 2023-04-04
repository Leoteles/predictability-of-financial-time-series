clear all;
close all;
clc;
randn('state',0);

%Cria-se um vetor de N posi��es representando uma estrutura GARCH(1,1)
N = 3500;
alfa0 = 1;
alfa1 = 0.3;
beta1 = 0.3;
var_e(1) = alfa0;%Vari�ncia inicial
e(1) = sqrt(var_e(1))*randn(1,1);
y(1) = e(1);
for t = 2:N
    
    %Processo da vari�ncia
    var_e(t) = alfa0 + alfa1 * y(t-1)^2 + beta1 * var_e(t-1);
    
    %Inova��o de vari�ncia var_e e m�dia 0
    e(t) = sqrt(var_e(t)) * randn(1,1);
    
    %Valor da s�rie no instante t
    y(t) = e(t);
        
end
y = y';%y �, por conven��o, vetor coluna

serieGARCH11 = y;


% 
% [coeff,errors,LLF,innovations,sigmas,summary] = garchfit(y);
% 
% garchdisp(coeff,errors);

save('serieGARCH11.mat','serieGARCH11');

