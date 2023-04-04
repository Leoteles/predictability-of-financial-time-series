close all;
clear all;
clc;
randn('state',12);
N = 1000;

load('petr4_1995_2008.mat');
p_petr4 = petr4_1995_2008_ymd_ohlc(end-N:end,4);%fechamento

p0 = p_petr4(1);%100;
var_ret = 3 * var(price2ret(p_petr4));%0.001;

vec = randn(N,1)* sqrt(var_ret);
p_rw = ret2price(vec,p0);

carrega_series;
p_arch1 = ret2price(arch1(1001:2000)*sqrt(var_ret),p0);
p_garch11 = ret2price(garch11(2501:3500)*sqrt(var_ret),p0);


%Pre�o ARCH1
figure;
plot(p_arch1);
grid on;
ylabel('pre�o','fontsize',14);
xlabel('dias','fontsize',14);
axis([1 N+1 0 75]);
print -depsc 'arch1_preco';

%Pre�o GARCH11
figure;
plot(p_garch11);
grid on;
ylabel('pre�o','fontsize',14);
xlabel('dias','fontsize',14);
axis([1 N+1 0 75]);
print -depsc 'garch11_preco';



%Pre�o RW
figure;
plot(p_rw);
grid on;
ylabel('pre�o','fontsize',14);
xlabel('dias','fontsize',14);
axis([1 N+1 0 75]);
print -depsc 'rw_preco';


%Pre�o petr4
figure;
plot(p_petr4);
grid on;
ylabel('pre�o','fontsize',14);
xlabel('dias','fontsize',14);
axis([1 N+1 0 75]);
print -depsc 'petr4_preco';



% %Primeiro retorno
% figure;
% plot(p(1:end-1),p(2:end));


[h,p,ksstat,cv] = kstest(vec);
[h,p,ksstat,cv]

[h,p,ksstat,cv] = kstest(price2ret(p_rw));
[h,p,ksstat,cv]

[h,p,ksstat,cv] = kstest(price2ret(p_petr4));
[h,p,ksstat,cv]   
