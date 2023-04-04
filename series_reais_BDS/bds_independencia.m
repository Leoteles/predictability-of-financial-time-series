close all;
clear all;
clc;

%Teste BDS com as séries reais


carrega_series;

Nsur = 50;

%series = {ribov};
series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_bds_indep_';


for i = 1:size(series,2)
    disp(series_str{i});
    serie = series{i};
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
%          0    0.1011    0.1884
%          0    0.1054    0.1884
%          0    0.1154    0.1884
%          0    0.1151    0.1884
%          0    0.1856    0.1884
%          0    0.1294    0.1884
%          0    0.0730    0.1884

% Resultados
% w2
%    42.8429
%    26.7113
%    35.9950
%    22.3272
%    22.7651
%    25.4337
%    21.2577
% prev
% 53.2131
% 22.7317
% 33.9484
% 21.2804
% 22.8321
% 27.5177
% 24.5221

