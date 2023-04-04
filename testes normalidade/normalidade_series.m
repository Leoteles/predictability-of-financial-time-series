close all;
clear all;
clc;
warning off all;

%Carrega as series
load('djia_1896_2005.mat');
load('sp500_1950_2009.mat');
load('ibov_1968_2007.mat');
load('petr4_1995_2008.mat');

dow = djia_1896_2005_ymd_c(:,4);
rdow = price2ret(dow);
ibo = ibov_1968_2007_ymd_c(:,4);
ribo = price2ret(ibo);
peto = petr4_1995_2008_ymd_ohlc(:,4);
peth = petr4_1995_2008_ymd_ohlc(:,5);
petl = petr4_1995_2008_ymd_ohlc(:,6);
petc = petr4_1995_2008_ymd_ohlc(:,7);
rpeto = price2ret(peto);
rpeth = price2ret(peth);
rpetl = price2ret(petl);
rpetc = price2ret(petc);
sp5 = sp500_1950_2009_ymd_c(:,4);
rsp5 = price2ret(sp5);
    

i = 1;


load 'serieRuidoBranco.mat';
x = serieRuidoBranco;
disp('ruidobranco:');
resultados(i,:) = testanormal(x);
i = i+1;
disp(resultados(end,:));

disp('varuniforme:');
%Para x uniforme
x = rand(3500,1);
resultados(i,:) = testanormal(x);
i = i+1;
disp(resultados(end,:));


disp('rdow:');
resultados(i,:) = testanormal(rdow);
disp(resultados(end,:));
i = i+1;
disp('rsp5:');
resultados(i,:) = testanormal(rsp5);
disp(resultados(end,:));
i = i+1;
disp('ribo:');
resultados(i,:) = testanormal(ribo);
disp(resultados(end,:));
i = i+1;
disp('rpeto:');
resultados(i,:) = testanormal(rpeto);
i = i+1;
disp(resultados(end,:));
disp('rpeth:');
resultados(i,:) = testanormal(rpeth);
i = i+1;
disp(resultados(end,:));
disp('rpetl:');
resultados(i,:) = testanormal(rpetl);
i = i+1;
disp(resultados(end,:));
disp('rpetc:');
resultados(i,:) = testanormal(rpetc);
i = i+1;
disp(resultados(end,:));

resultados

tabela = matrix2table(resultados)


%Estima a gaussiana da distribuição de ret dow
y = rdow;
media = mean(y);
desvio = std(y);
liminf = media - 4 * desvio;
limsup = media + 4 * desvio;
eixo_x = linspace(liminf,limsup,100);
pdf_sur = pdf('Normal',eixo_x,media,desvio);

[n,xout] = hist(y,40);
n = n / (sum(n) * (xout(2)-xout(1)));
figure;
bar(xout,n,'FaceColor',[.89 .94 .9],'EdgeColor','k');
hold on;
plot(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Hist. norm. dos Retornos','Distribuição Estimada','location','northwest');
axis([-0.1 0.1 -1 50]);
hold off;
print -depsc 'fig_dist_ret_dow';

%Estima a gaussiana da distribuição de ret ibo
y = ribo;
media = mean(y);
desvio = std(y);
liminf = media - 4 * desvio;
limsup = media + 4 * desvio;
eixo_x = linspace(liminf,limsup,100);
pdf_sur = pdf('Normal',eixo_x,media,desvio);

[n,xout] = hist(y,40);
n = n / (sum(n) * (xout(2)-xout(1)));
figure;
bar(xout,n,'FaceColor',[.89 .94 .9],'EdgeColor','k');
hold on;
plot(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Hist. norm. dos Retornos','Distribuição Estimada','location','northeast');
%axis([-0.25 0.3 -1 20]);
hold off;
print -depsc 'fig_dist_ret_ibo';


%%%%%%%%%%%%%%%%%%%%%%%%%escala logaritmica
figure;
semilogy(xout,n);
hold on;
semilogy(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Histograma normalizado dos Retornos','Distribuição Normal Estimada','location','south');
axis([-0.1 0.1 -1 50]);
hold off;
print -depsc 'fig_dist_ret_ibo_log';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Estima a gaussiana da distribuição de ret.sp500
y = rsp5;
media = mean(y);
desvio = std(y);
liminf = media - 4 * desvio;
limsup = media + 4 * desvio;
eixo_x = linspace(liminf,limsup,100);
pdf_sur = pdf('Normal',eixo_x,media,desvio);

[n,xout] = hist(y,40);
n = n / (sum(n) * (xout(2)-xout(1)));
figure;
bar(xout,n,'FaceColor',[.89 .94 .9],'EdgeColor','k');
hold on;
plot(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Hist. norm. dos Retornos','Distribuição Estimada','location','northwest');
axis([-0.1 0.1 -1 50]);
hold off;
print -depsc 'fig_dist_ret_sp5';


%Estima a gaussiana da distribuição de PETR4O
y = rpeto;
media = mean(y);
desvio = std(y);
liminf = media - 4 * desvio;
limsup = media + 4 * desvio;
eixo_x = linspace(liminf,limsup,100);
pdf_sur = pdf('Normal',eixo_x,media,desvio);

[n,xout] = hist(y,40);
n = n / (sum(n) * (xout(2)-xout(1)));
figure;
bar(xout,n,'FaceColor',[.89 .94 .9],'EdgeColor','k');
hold on;
plot(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Hist. norm. dos Retornos','Distribuição Estimada','location','northwest');
axis([-0.15 0.15 -1 25]);
hold off;
print -depsc 'fig_dist_ret_peto';

%Estima a gaussiana da distribuição de PETR4H
y = rpeth;
media = mean(y);
desvio = std(y);
liminf = media - 4 * desvio;
limsup = media + 4 * desvio;
eixo_x = linspace(liminf,limsup,100);
pdf_sur = pdf('Normal',eixo_x,media,desvio);

[n,xout] = hist(y,40);
n = n / (sum(n) * (xout(2)-xout(1)));
figure;
bar(xout,n,'FaceColor',[.89 .94 .9],'EdgeColor','k');
hold on;
plot(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Hist. norm. dos Retornos','Distribuição Estimada','location','northwest');
axis([-0.15 0.15 -1 25]);
hold off;
print -depsc 'fig_dist_ret_peth';

%Estima a gaussiana da distribuição de PETR4L
y = rpetl;
media = mean(y);
desvio = std(y);
liminf = media - 4 * desvio;
limsup = media + 4 * desvio;
eixo_x = linspace(liminf,limsup,100);
pdf_sur = pdf('Normal',eixo_x,media,desvio);

[n,xout] = hist(y,40);
n = n / (sum(n) * (xout(2)-xout(1)));
figure;
bar(xout,n,'FaceColor',[.89 .94 .9],'EdgeColor','k');
hold on;
plot(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Hist. norm. dos Retornos','Distribuição Estimada','location','northwest');
axis([-0.15 0.15 -1 25]);
hold off;
print -depsc 'fig_dist_ret_petl';

%Estima a gaussiana da distribuição de PETR4C
y = rpetc;
media = mean(y);
desvio = std(y);
liminf = media - 4 * desvio;
limsup = media + 4 * desvio;
eixo_x = linspace(liminf,limsup,100);
pdf_sur = pdf('Normal',eixo_x,media,desvio);

[n,xout] = hist(y,40);
n = n / (sum(n) * (xout(2)-xout(1)));
figure;
bar(xout,n,'FaceColor',[.89 .94 .9],'EdgeColor','k');
hold on;
plot(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Hist. norm. dos Retornos','Distribuição Estimada','location','northwest');
axis([-0.15 0.15 -1 25]);
hold off;
print -depsc 'fig_dist_ret_petc';

