close all;
clear all;
clc;
warning off all;

%Carrega as series
carrega_series
lags = 10;
alpha = 0.05;

resultados = [];

rdow = price2ret(djia);
ribo = price2ret(ibov);
rpeto = price2ret(peto);
rpeth = price2ret(peth);
rpetl = price2ret(petl);
rpetc = price2ret(petc);
rsp5 = price2ret(sp500);

%DJIA
figure;
[ACF, Lags, Bounds] = autocorr(rdow,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_ret_dow';
[h,pValue,stat,cValue] = lbqtest(rdow,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(rdow.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_rdowquad';
[h,pValue,stat,cValue] = lbqtest(rdow.^2,lags,alpha);
resultados = [resultados; stat cValue];



%S&P500
figure;
[ACF, Lags, Bounds] = autocorr(rsp5,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_ret_sp5';
[h,pValue,stat,cValue] = lbqtest(rsp5,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(rsp5.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_rspquad';
[h,pValue,stat,cValue] = lbqtest(rsp5.^2,lags,alpha);
resultados = [resultados; stat cValue];


%IBOVESPA
figure;
[ACF, Lags, Bounds] = autocorr(ribo,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_ret_ibo';
[h,pValue,stat,cValue] = lbqtest(ribo,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(ribo.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_riboquad';
[h,pValue,stat,cValue] = lbqtest(ribo.^2,lags,alpha);
resultados = [resultados; stat cValue];

%PETR4O
figure;
[ACF, Lags, Bounds] = autocorr(rpeto,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_ret_peto';
[h,pValue,stat,cValue] = lbqtest(rpeto,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(rpeto.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_rpetoquad';
[h,pValue,stat,cValue] = lbqtest(rpeto.^2,lags,alpha);
resultados = [resultados; stat cValue];

%PETR4H
figure;
[ACF, Lags, Bounds] = autocorr(rpeth,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_ret_peth';
[h,pValue,stat,cValue] = lbqtest(rpeth,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(rpeth.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_rpethquad';
[h,pValue,stat,cValue] = lbqtest(rpeth.^2,lags,alpha);
resultados = [resultados; stat cValue];

%PETR4L
figure;
[ACF, Lags, Bounds] = autocorr(rpetl,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_ret_petl';
[h,pValue,stat,cValue] = lbqtest(rpetl,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(rpetl.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_rpetlquad';
[h,pValue,stat,cValue] = lbqtest(rpetl.^2,lags,alpha);
resultados = [resultados; stat cValue];

%PETR4C
figure;
[ACF, Lags, Bounds] = autocorr(rpetc,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_ret_petc';
[h,pValue,stat,cValue] = lbqtest(rpetc,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(rpetc.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos','fontsize',14);
ylabel('Auto-correlação','fontsize',14);
print -depsc 'fig_fac_rpetcquad';
[h,pValue,stat,cValue] = lbqtest(rpetc.^2,lags,alpha);
resultados = [resultados; stat cValue];

tabela = matrix2table(resultados)
