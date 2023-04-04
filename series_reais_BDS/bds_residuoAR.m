close all;
clear all;
clc;

%Teste BDS com as séries reais

%Modelagem AR e teste BDS com seus resíduos

carrega_series;

Nsur = 50;

series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_bds_resAR_';


% % % series = {ribov};
% % % series_str = {'ibov'};
% % % 
% % % serie = rdjia;



for i = 1:size(series,2)
    disp(series_str{i});
    serie = series{i};
    %Estima modelo AR para a série real i
    modelo = estimaModeloAR(serie);
    disp('Ordem do modelo AR:');disp(modelo.k);
    %A nova série a ser analisada será a dos resíduos do modelo AR(k)
    serie = modelo.residuos;
    
    tic
    [estrutura, prev] = analiseBDS(serie,Nsur);
    est(i) = estrutura;
    disp('PREV(serie)');prev
    toc
    str = strcat(strfig,series_str{i});
    print('-depsc',str);

end


%Testa normalidade dos sub-rogados gerados
for i = 1:size(series,2)
    resultados = testanormal(est(i).w_sur);
    normalidade(i,:) = resultados;%Resultados da série i para o teste kolmogorov-smirnov
end
%resultado da rejeição | valor da estatistica | valor limite
normalidade
% 
% normalidade =
% 
%          0    0.0767    0.1884
%          0    0.1085    0.1884
%          0    0.1002    0.1884
%          0    0.1218    0.1884
%          0    0.1538    0.1884
%          0    0.0887    0.1884
%          0    0.0912    0.1884

% Resultados
% w2
% djia 43.2469
% sp500 26.713
% ibov 32.8288
% peto 22.2946
% peth 21.1324
% petl 22.8458
% petc 21.1835

% prev
% djia 45.7390
% sp500 27.4448
% ibov 31.7758
% peto 20.1341
% peth 21.0826
% petl 22.2033
% petc 21.3992

% Ordens AR
% djia 6
% sp500 15
% ibov 15
% peto 3
% peth 2
% petl 6
% petc 3
