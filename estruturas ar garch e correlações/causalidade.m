%Uso de funções de correlação cruzada para se identificar causalidade
%x é um vetor aleatório e y é uma versão atrasada de x.
%x gera (ou, causa) y.
clear all;
close all;
clc;
randn('state',0);

x = randn(100,1);               % 100 Gaussian deviates, N(0,1).
y = lagmatrix(x,4);             % Delay it by 4 samples.
y(isnan(y)) = 0;                % Replace NaNs with zeros.
crosscorr(x,y);                 % Compute the XCF with
                                % 95 percent confidence.