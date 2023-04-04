close all;
clear all;
clc;

N = 100;

lambda = 3.5;%Par�metro de bifurca��o do mapa
x(1) = 0.1;%Valor inicial;

for n = 2:N*100
    x(n) = lambda * x(n-1) * (1-x(n-1));
end
x = x(end-N+1:end);%Transit�rio

figure;
plot(x,'-r');
title('Mapa logistico');
grid on;
axis([1 N 0 1]);

lambda = 4;%Par�metro de bifurca��o do mapa
x(1) = 0.1;%Valor inicial;

for n = 2:N*100
    x(n) = lambda * x(n-1) * (1-x(n-1));
end
x = x(end-N+1:end);%Transit�rio

figure;
plot(x,'-r');
title('Mapa logistico');
grid on;
axis([1 N 0 1]);


% % % rw = randn(1,N);
% % % 
% % % figure;
% % % plot(rw,'-r');
% % % title('Ru�do branco gaussiano');
% % % grid on;
