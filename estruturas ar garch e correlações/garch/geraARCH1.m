clear all;
close all;
clc;
randn('state',0);

%Cria-se um vetor de N posições representando uma estrutura ARCH1
N = 3500;
alfa0 = 1;
alfa1 = 0.3;
var_e(1) = alfa0;%Variância inicial
e(1) = sqrt(var_e(1))*randn(1,1);
y(1) = e(1);
for t = 2:N
    
    %Processo da variância
    var_e(t) = alfa0 + alfa1 * y(t-1)^2;
    
    %Inovação de variância var_e e média 0
    e(t) = sqrt(var_e(t)) * randn(1,1);
    
    %Valor da série no instante t
    y(t) = e(t);
        
end
y = y';%y é, por convenção, vetor coluna

serieARCH1 = y;

save('serieARCH1.mat','serieARCH1');