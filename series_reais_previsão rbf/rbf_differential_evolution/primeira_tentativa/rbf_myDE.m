close all;
clear all;
clc;

randn('state',0);
rand('state',0);


carrega_series;
serie = rpetc;
clearvars -except serie;

Nneuronios = 10;
Ndelays = 2;%Número de atrasos (AR) a serem considerados para a criação do vetor de entrada TDNN
Nval = 0.15;
Ntest = 0.15;

tic
[xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);


limPop = repmat([1e-9 10],[Nneuronios 1]);
maxGer = 2;
[melhor_sigma, f] = myDE(@(sigma) erro_rbf(sigma,Nneuronios, xtr, ydtr, xval, ydval),1,limPop,maxGer)


modelo = estimaModeloRBF(xtr,ydtr,Nneuronios,melhor_sigma);

yval = previsaoRBF(modelo,xval);
e = calculaErros(yval,ydval)

ytest = previsaoRBF(modelo,xtest);
e = calculaErros(ytest,ydtest)

plot(ydtest,'-r');
hold on;
plot(ytest,'-b');
hold off;

toc
% melhor_sigma =
% 
%     1.9389
%     9.0481
%     5.6921
%     6.3179
%     2.3441
%     5.4878
%     9.3158
%     6.4822
%     6.5553
%     3.9190
% 
% 
% f =
% 
%     0.0259
% 
% e = 
% 
%        rmse: 0.0260
%     rmse_rw: 0.0260
%         mae: 0.0197
%          pb: 50.4274
%          u2: 1.0028
%        mrae: 1.4710
%       mdrae: 0.9956
%       gmrae: 0.9278
%       erros: [585x1 double]
% 
% 
% e = 
% 
%        rmse: 0.0313
%     rmse_rw: 0.0313
%         mae: 0.0208
%          pb: 47.2696
%          u2: 1.0000
%        mrae: 2.8261
%       mdrae: 1.0288
%       gmrae: 1.0716
%       erros: [586x1 double]
% 
% Elapsed time is 175.009499 seconds.