close all;
clear all;
clc;

carrega_series;
serie = logistica;
clearvars -except serie;

Nneuronios = 5;
Ndelays = 2;%N�mero de atrasos (AR) a serem considerados para a cria��o do vetor de entrada TDNN
Nval = 0.15;
Ntest = 0.15;


[xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);

modelo = estimaModeloRBF(xtr,ydtr,Nneuronios);


for i = 1:length(ydtest)
    ytest(i,:) = previsaoRBF(modelo,xtest(i,:));
end

e = calculaErros(ytest,ydtest)
