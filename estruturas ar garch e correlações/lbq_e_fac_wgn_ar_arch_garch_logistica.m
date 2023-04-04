%Calcula FAC e LBQ das séries AR1, ARCH(1), GARCH(1,1) e mapa logístico

clear all;
close all;
clc;
randn('state',0);

carrega_series;
lags = 10;
alpha = 0.05;

resultados = [];


%Ruído branco gaussiano
randn('state',0);
wgn = randn(3500,1);
figure;
[ACF, Lags, Bounds] = autocorr(wgn,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_wgn';
[h,pValue,stat,cValue] = lbqtest(wgn,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(wgn.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_wgnquad';
[h,pValue,stat,cValue] = lbqtest(wgn.^2,lags,alpha);
resultados = [resultados; stat cValue];


%AR1

figure;
[ACF, Lags, Bounds] = autocorr(ar1,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_ar1';
[h,pValue,stat,cValue] = lbqtest(ar1,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(ar1.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_ar1quad';
[h,pValue,stat,cValue] = lbqtest(ar1.^2,lags,alpha);
resultados = [resultados; stat cValue];

%ARCH1

figure;
[ACF, Lags, Bounds] = autocorr(arch1,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_arch1';
[h,pValue,stat,cValue] = lbqtest(arch1,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(arch1.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_arch1quad';
[h,pValue,stat,cValue] = lbqtest(arch1.^2,lags,alpha);
resultados = [resultados; stat cValue];

%GARCH(1,1)

figure;
[ACF, Lags, Bounds] = autocorr(garch11,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_garch11';
[h,pValue,stat,cValue] = lbqtest(garch11,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(garch11.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_garch11quad';
[h,pValue,stat,cValue] = lbqtest(garch11.^2,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(logistica,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.2 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_logistica';
[h,pValue,stat,cValue] = lbqtest(logistica,lags,alpha);
resultados = [resultados; stat cValue];

figure;
[ACF, Lags, Bounds] = autocorr(logistica.^2,[],2);
stem(Lags,ACF,'MarkerFaceColor','green');
hold on;
plot(Lags,ones(size(Lags))*Bounds(1),'-b');
plot(Lags,ones(size(Lags))*Bounds(2),'-b');
hold off;
axis([-0.2 20 -0.4 1.2]);
title('');
grid on;
xlabel('Atrasos');
ylabel('Auto-correlação');
%print -depsc 'fig_fac_logisticaquad';
[h,pValue,stat,cValue] = lbqtest(logistica.^2,lags,alpha);
resultados = [resultados; stat cValue];


matrix2table(resultados)
