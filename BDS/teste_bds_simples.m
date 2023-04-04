clear all;
close all;
clc;


carrega_series;




series = [wgn ar1 arch1 garch11 logistica];

for i = 1:size(series,2)
    i
    %Calcula a estatística BDS para a série i
    [W, SIG, C, C1, K] = bds (series(:,i));
    w_series(i) = W;
end

w_series'
