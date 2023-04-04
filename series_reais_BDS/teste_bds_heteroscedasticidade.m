close all;
clear all;
clc;

%Teste BDS com séries heteroscedasticas

carrega_series;
clearvars -except garch11

Nsur = 50;

randn('state',0);
wgn = randn(3500,1);
wgn_het1 = wgn .* randn(3500,1);
wgn_het2 = [wgn(1:1000)*10*randn; wgn(1001:2000)*10*randn; wgn(2001:3000)*10*randn; wgn(3001:3500)];
garch11 = garch11;

series = {wgn wgn_het1 wgn_het2 garch11};



for i = 1:size(series,2)
    serie = series{i};
    
    
    tic
    [estrutura, prev] = analiseBDS(serie,Nsur);
    disp('PREV(serie)');prev
    toc

end

