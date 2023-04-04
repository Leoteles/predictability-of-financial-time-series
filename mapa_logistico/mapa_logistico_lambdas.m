close all;
clear all;
clc;

N = 100;

lambda = 3.5;%Parâmetro de bifurcação do mapa
x(1) = 0.1;%Valor inicial;

for n = 2:N*100
    x(n) = lambda * x(n-1) * (1-x(n-1));
end
x = x(end-N+1:end);%Transitório

figure;
plot(x,'-r');
title('Mapa logistico');
grid on;
axis([1 N 0 1]);

lambda = 4;%Parâmetro de bifurcação do mapa
x(1) = 0.1;%Valor inicial;

for n = 2:N*100
    x(n) = lambda * x(n-1) * (1-x(n-1));
end
x = x(end-N+1:end);%Transitório

figure;
plot(x,'-r');
title('Mapa logistico');
grid on;
axis([1 N 0 1]);


% % % rw = randn(1,N);
% % % 
% % % figure;
% % % plot(rw,'-r');
% % % title('Ruído branco gaussiano');
% % % grid on;
