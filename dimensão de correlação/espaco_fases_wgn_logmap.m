close all;
clear all;
clc;

carrega_series;

serie = wgn;
y = serie(2:end);
x = serie(1:end-1);
figure;
plot(x,y,'.b');
grid on;
ylabel('y(t)','fontsize',14);
xlabel('y(t-1)','fontsize',14);
print -depsc 'fig_fase_wgn';


serie = logistica;
y = serie(2:end);
x = serie(1:end-1);
figure;
plot(x,y,'.b');
grid on;
ylabel('y(t)','fontsize',14);
xlabel('y(t-1)','fontsize',14);
print -depsc 'fig_fase_logmap';