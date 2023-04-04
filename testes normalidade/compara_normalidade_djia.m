close all;
clear all;
clc;

carrega_series;

%Cria série de retornos (em porcentagem)
rdjia = 100 * (djia(2:end)-djia(1:end-1)) ./ djia(1:end-1);

figure;
plot(rdjia);

%transforma a série rdjia para que possua média zero
ndjia = (rdjia - mean(rdjia));
std_djia =  std(rdjia);
disp('Desvio padrao:')
std(ndjia)


%x = -20:0.5:20;
%Para plotar, o intervalo abaixo é melhor, pois evita o log(0)
x = -7:0.5:7;

[n,x] = hist(ndjia,x);
intervalo = x(2)-x(1);
n = n / (sum(n) * (intervalo));

normal = pdf('Normal',x,0,std_djia);

figure;
plot(x,normal,'--b');
hold on;
plot(x,n,'-r');
hold off;


figure;
semilogy(x,normal,'--b','LineWidth',3);
hold on;
semilogy(x,n,'-r','LineWidth',3);
grid on;
hold off;
legend('Frequência dos Retornos','Distribuição Normal','location','south');
%print -depsc 'fig_compara_ret_dow_normal';

%Calculo da probabilidade de se ter números maiores que 5 ou menores que
%-5
%........../Para a dist. gaussiana
disp('Probabilidade de grandes retornos(|r|>=5) gaussianos:')
p_normal = 2 * cdf('Normal',-5,0,std_djia)

%........../Para a dist. empírica do ret. de djia
%Para esse calculo, usa um intervalo maior do que o do gráfico
x = -20:0.5:20;

[n,x] = hist(ndjia,x);
intervalo = x(2)-x(1);
n = n / (sum(n) * (intervalo));
indices = [find(x<=-5) find(x>=5)];
disp('Probabilidade de grandes retornos(|r|>=5) djia:')
p_rdjia = sum(n(indices)*intervalo)

disp('Grandes retornos são P vezes mais prováveis (do que se os ret. fossem gaussianos):')
format bank;
P =  p_rdjia/p_normal