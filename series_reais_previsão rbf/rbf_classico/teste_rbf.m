close all;
clear all;
clc;

%load('rpetc_resGARCH11.mat');
carrega_series;
serie = rpetc;
clearvars -except serie;



Ndelays = 20;%Número de atrasos (AR) a serem considerados para a criação do vetor de entrada TDNN
Nval = 0.15;
Ntest = 0.15;
Nneuronios = 50;


[xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);

modelo = estimaModeloRBF(xtr,ydtr,Nneuronios);


for i = 1:length(ydtest)
    ytest(i,:) = previsaoRBF(modelo,xtest(i,:));
end

e = calculaErros(ytest,ydtest)
