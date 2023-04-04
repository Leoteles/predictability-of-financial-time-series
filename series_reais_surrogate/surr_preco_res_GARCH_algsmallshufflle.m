close all;
clear all;
clc;

carrega_series;

%Par�metros da rotina de analise de dados sub-rogados
Nsur = 50;%N�mero de surrogates
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'ami';%Mostra todas as estatisticas

rand('state',0);
randn('state',0);


algoritmo = 'ss';%Algoritmo utilizado

series = {djia sp500 ibov peto peth petl petc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_preco_resGARCH_ss_';



for i = 1:size(series,2)
    disp(series_str{i});
    serie = series{i};
    
    ret = price2ret(serie);
    
    %Estima modelo garch
    spec = garchset();
    spec.Comment
    [Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(spec,ret);
    %Calcula s�rie passada por filtro GARCH estimado
    ret = (Innovations./Sigmas);
    
    serie = ret2price(ret,serie(1));

    
    tic
    [estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
    disp('PREV(serie)');prev(1)
    toc
end



for fig = 1:size(series,2)%Para cada figura da s�rie
    figure(fig);
    str = strcat(strfig,series_str{fig},'_ami');
    print('-depsc',str);
end

