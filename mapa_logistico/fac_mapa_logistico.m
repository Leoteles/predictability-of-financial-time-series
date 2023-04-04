close all;
clear all;
clc;

N = 3500;
%lambda = 3.6;%Parâmetro de bifurcação do mapa
lambda = 3.82;%Parâmetro de bifurcação do mapa
%lambda = 3.9999;%Parâmetro de bifurcação do mapa
%lambda = 4;%Parâmetro de bifurcação do mapa
x(1) = 0.1;%Valor inicial;

for n = 2:N
    x(n) = lambda * x(n-1) * (1-x(n-1));
end
% 
% figure;
% plot(x,'-r');
% title('Mapa logistico');
% grid on;

figure;
autocorr(x-mean(x),[],2);
title('FAC - Mapa logistico');

figure;
autocorr(x.^2-mean(x.^2),[],2);
title('FAC - Quadrado da série do Mapa logistico');

disp('Teste Ljung-Box para x');
[H,P,Qstat,CV] = lbqtest(x, [10 15 20]', 0.05);
[H,P,Qstat,CV]
disp('Teste Ljung-Box para x^2');
[H,P,Qstat,CV] = lbqtest(x.^2-mean(x.^2), [10 15 20]', 0.05);
[H,P,Qstat,CV]

% [H,pValue,Stat,CriticalValue] = archtest(x-mean(x),[10 15 20]',0.05);
% [H  pValue  Stat  CriticalValue]


rw = randn(1,N);
% figure;
% autocorr(rw,[],2);
% title('FAC - Random Walk');

% [H,P,Qstat,CV] = lbqtest(rw, [10 15 20]', 0.05);
% [H,P,Qstat,CV]
% 
% [H,P,Qstat,CV] = lbqtest(rw.^2-mean(rw.^2), [10 15 20]', 0.05);
% [H,P,Qstat,CV]