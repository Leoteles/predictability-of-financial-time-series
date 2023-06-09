close all;
clear all;
clc;

randn('state',0);
rand('state',0);

%Utiliza DE para otimizar popula��o de neuronios(apenas raios)

carrega_series;
serie = rpetc;
clearvars -except serie;

%serie = serie(end-1000+1:end);
%Retira a m�dia
%serie = serie - mean(serie);

Nneuronios = 5;
Ndelays = 2;%N�mero de atrasos (AR) a serem considerados para a cria��o do vetor de entrada TDNN
Nval = 0.15;
Ntest = 0.15;

tic
[xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);

%Define limites para a popula��o
min_x = min(min(xtr));
max_x = max(max(xtr));

%Limite da pop. de  sigmas
limPop = repmat([1e-9 (max_x-min_x)],[Nneuronios 1]);

modelo = estimaModeloRBF(xtr,ydtr,Nneuronios);


maxGer = 30;
[melhores_sigma, f] = myDE(modelo,@(modelo) erro_rbf(modelo, xval, ydval),1,limPop,maxGer)

modelo.sigma = melhores_sigma;

yval = previsaoRBF(modelo,xval);
e = calculaErros(yval,ydval)

ytest = previsaoRBF(modelo,xtest);
e = calculaErros(ytest,ydtest)

figure;
plot(ydtest,'-r');
hold on;
plot(ytest,'-b');
hold off;

toc
% % % 
% % %        rmse: 0.0879
% % %     rmse_rw: 0.3577
% % %         mae: 0.0764
% % %          pb: 88.0795
% % %          u2: 0.2459
% % %        mrae: 0.7069
% % %       mdrae: 0.2469
% % %       gmrae: 0.2332
% % %       erros: [151x1 double]