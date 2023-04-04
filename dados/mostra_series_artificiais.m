close all;
clear all;
clc;

carrega_series;

serie = wgn;
figure;
plot(serie(1:50));
xlabel('t','fontsize',14);
ylabel('y(t)','fontsize',14);
grid on;
print -depsc 'fig_wgn';

serie = ar1;
figure;
plot(serie(1:50));
xlabel('t','fontsize',14);
ylabel('y(t)','fontsize',14);
grid on;
print -depsc 'fig_ar1';

serie = arch1;
figure;
plot(serie(1:50));
xlabel('t','fontsize',14);
ylabel('y(t)','fontsize',14);
grid on;
print -depsc 'fig_arch1';

serie = garch11;
figure;
plot(serie(1:50));
xlabel('t','fontsize',14);
ylabel('y(t)','fontsize',14);
grid on;
print -depsc 'fig_garch11';

serie = logistica;
figure;
plot(serie(1:50));
xlabel('t','fontsize',14);
ylabel('y(t)','fontsize',14);
grid on;
print -depsc 'fig_logmap';