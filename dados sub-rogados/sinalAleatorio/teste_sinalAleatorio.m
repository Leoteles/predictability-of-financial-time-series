close all;
clear all;
clc;

%Teste BDS com séries heteroscedasticas

carrega_series;
clearvars -except garch11 ar1

Nsur = 5;


w = sinalAleatorio(garch11,Nsur);

% figure;
% autocorr(garch11);
% figure;
% autocorr(garch11.^2);
% [h,pValue,stat,cValue] = lbqtest(garch11);
% stat
% [h,pValue,stat,cValue] = lbqtest(garch11.^2);
% stat


for i = 1:Nsur
%     figure;
%     hist(w(:,i),20);
%     figure;
%     autocorr(w(:,i))
%     figure;
%     autocorr(w(:,i).^2)
%     [h,pValue,stat,cValue] = lbqtest(w(:,i));
%     stat
%     [h,pValue,stat,cValue] = lbqtest(w(:,i).^2);
%     stat
end



w = sinalAleatorio(ar1,Nsur);
% figure;
% autocorr(ar1);
% figure;
% autocorr(ar1.^2);
[h,pValue,stat,cValue] = lbqtest(ar1);
stat
% [h,pValue,stat,cValue] = lbqtest(ar1.^2);
% stat


for i = 1:Nsur
%     figure;
%     hist(w(:,i),20);
%     figure;
%     autocorr(w(:,i))
%     figure;
%     autocorr(w(:,i).^2)
    [h,pValue,stat,cValue] = lbqtest(w(:,i));
    stat
%     [h,pValue,stat,cValue] = lbqtest(w(:,i).^2);
%     stat
end