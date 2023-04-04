close all;
clear all;
clc;

randn('state',0);
rand('state',0);

%Utiliza DE para otimizar população de neuronios(centros e raios)

carrega_series;
serie = rdjia;
clearvars -except serie;

serie = serie(end-1000+1:end);

Nneuronios = 5;
Ndelays = 2;%Número de atrasos (AR) a serem considerados para a criação do vetor de entrada TDNN
Nval = 0.15;
Ntest = 0.15;

tic
[xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);

%Define limites para a população
min_x = min(min(xtr));
max_x = max(max(xtr));

%Limite da pop. de  sigmas
limPop1 = repmat([1e-9 (max_x-min_x)],[Nneuronios 1]);
%Limite da pop. de neuronios (um limite min. e max. para cada dim.(delay)
%de cada neuronio)
limPop2 = repmat([min_x max_x],[Nneuronios*Ndelays 1]);
limPop = [limPop1; limPop2];
%limPop é organizado assim:
%Os primeiras Nneuronios linhas indicam os min. e max. dos raios de cada
%neuronio
%As linhas Nneuronios+1 a 2*Nneuronios tem os limites da primeira dim. de
%todos os neuronios, e assim por diante

maxGer = 10;
[melhor_pop, f] = myDE(@(pop) erro_rbf(pop,Nneuronios, xtr, ydtr, xval, ydval),1,limPop,maxGer)

melhores_sigma = melhor_pop(1:Nneuronios);

melhores_centros = reshape(melhor_pop(Nneuronios+1:end),Nneuronios,Ndelays);

modelo = estimaModeloRBF(xtr,ydtr,Nneuronios,melhores_sigma,melhores_centros);

yval = previsaoRBF(modelo,xval);
e = calculaErros(yval,ydval)

ytest = previsaoRBF(modelo,xtest);
e = calculaErros(ytest,ydtest)

plot(ydtest,'-r');
hold on;
plot(ytest,'-b');
hold off;

toc

% % 
% % melhor_sigma =
% % 
% %     7.0274
% %     5.4657
% %     4.4488
% %     6.9457
% %     6.2131
% % 
% % 
% % f =
% % 
% %     0.0259
% % 
% % 
% % e = 
% % 
% %        rmse: 0.0260
% %     rmse_rw: 0.0260
% %         mae: 0.0196
% %          pb: 50.4274
% %          u2: 1.0001
% %        mrae: 1.3980
% %       mdrae: 0.9987
% %       gmrae: 0.9556
% %       erros: [585x1 double]
% % 
% % 
% % e = 
% % 
% %        rmse: 0.0314
% %     rmse_rw: 0.0313
% %         mae: 0.0208
% %          pb: 47.2696
% %          u2: 1.0009
% %        mrae: 2.4002
% %       mdrae: 1.0283
% %       gmrae: 1.0557
% %       erros: [586x1 double]
% % 
% % Elapsed time is 37.863376 seconds.