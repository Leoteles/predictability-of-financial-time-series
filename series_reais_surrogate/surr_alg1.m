close all;
clear all;
clc;

carrega_series;

%Par�metros da rotina de analise de dados sub-rogados
Nsur = 50;%N�mero de surrogates
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'todas';%Mostra todas as estatisticas

rand('state',0);
randn('state',0);


algoritmo = 'alg1';%Algoritmo utilizado

series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_surr1_';


% % series = {rpetl rpetc};
% % series_str = {'rpetl' 'petc'};


for i = 1:size(series,2)
    disp(series_str{i});
    serie = series{i};
    tic
    [estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
    disp('PREV(serie)');prev(1)
    toc
end

ser = 1;%Incrementa o vetor dos nomes das s�ries
for fig = 1:3:size(series,2)*3%Para cada figura da s�rie
    figure(fig);
    str = strcat(strfig,series_str{ser},'_d2');
    print('-depsc',str);
    figure(fig+1);
    str = strcat(strfig,series_str{ser},'_sampen');
    print('-depsc',str);
    figure(fig+2);
    str = strcat(strfig,series_str{ser},'_ami');
    print('-depsc',str);
    ser = ser + 1;
end

% %PREV
% djia 45.2718
% sp500 13.1725
% ibov 11.6890
% peto 2.8265
% peth 4.8063
% petl 1.6863
% petc 3.4408

