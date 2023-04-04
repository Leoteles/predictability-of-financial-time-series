close all;
clear all;
clc;

%Teste BDS com as séries artificiais

carrega_series;
serie = wgn
clearvars -except serie;

rw = ret2price(serie,100);


for i = 1:length(rw)
    y = rw(1:i);
    range = max(y) - min(y);
    res_range(i) = range/std(y);
end


figure;
plot(log(1:length(rw)),log(res_range));

