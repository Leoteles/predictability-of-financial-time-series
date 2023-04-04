close all;
clear all;
clc;


carrega_series;
serie = ibov;
clearvars -except serie;


N = 1000;%Últimos N valores da série 
%serie = serie(end-N+1:end);
Max_lag = 30;%Atraso máxima para ser calculada a média móvel. O min. é 2.


metade = floor(length(serie)/2);
serie1 = serie(1:metade);
serie2 = serie(metade+1:end);


%Otimiza mm para a primeira metade da série
for lag = 2:Max_lag
    
    [short,mm]= movavg(serie1,2,lag,1);
    mm = mm(lag:end);
    y = serie1(lag:end);
        
    sinais = [0;diff(y-mm>0)];
    
    portfolio_inicial = 0;
    dinheiro_inicial = 1000;
    
    portfolio =  portfolio_inicial;
    dinheiro = dinheiro_inicial;
    for i = 1:length(sinais)
        if sinais(i) == 1 && dinheiro~=0%Compra
            portfolio = dinheiro / y(i);%Investe todo o dinheiro
            dinheiro = 0;
        end
        if sinais(i) == -1 && portfolio~=0%Vende
            dinheiro = portfolio * y(i);%"Liquida";
            portfolio = 0;
        end
    end
    dinheiro = dinheiro + portfolio * y(end);%"Liquida";
    
    lucro(lag) = 100 * (dinheiro - dinheiro_inicial) / dinheiro_inicial;
    
end
lucro = lucro(2:end);
lags = 2:Max_lag;

lucro_buy_and_hold = 100*(y(end)-y(1))/y(1)

figure;
plot(lags(1:15),lucro(1:15),'-r','LineWidth',2);
grid on;
ylabel('Lucro','fontsize',14);
xlabel('\tau','fontsize',14);
hold on;
line([lags(1) lags(15)],[lucro_buy_and_hold lucro_buy_and_hold],'LineStyle','--','Color','b','LineWidth',3);
hold off;
lh = legend('Média Móvel(\tau)','Lucro Buy and Hold','location','northeast')
set(lh,'fontSize',14)
print('-depsc','fig_mm_lucro1');


[melhor_lucro indice] = max(lucro);
melhor_lucro
melhor_lag = lags(indice)


%Mostra resultado com melhor lag na serie1
[short,melhor_mm]= movavg(serie1,2,melhor_lag,1);
melhor_mm = melhor_mm(lag:end);
y = serie1(lag:end)';

figure;
plot(y,'.-b');
hold on;
plot(melhor_mm,'.-r','LineWidth',2);
ylabel('Preço','fontsize',14);
xlabel('Dias','fontsize',14);
str = sprintf('Média móvel(%d)',melhor_lag);
lh = legend('Preço',str,'location','southeast')
set(lh,'fontSize',14)
hold off;
axis([5082 5119 1.6e-4 2.4e-4]);
print('-depsc','fig_mm_ibov');



%Otimiza mm para a segunda metade da série
for lag = 2:Max_lag
    
    [short,mm]= movavg(serie2,2,lag,1);
    mm = mm(lag:end);
    y = serie2(lag:end);
        
    sinais = [0;diff(y-mm>0)];
    
    portfolio_inicial = 0;
    dinheiro_inicial = 1000;
    
    portfolio =  portfolio_inicial;
    dinheiro = dinheiro_inicial;
    for i = 1:length(sinais)
        if sinais(i) == 1 && dinheiro~=0%Compra
            portfolio = dinheiro / y(i);%Investe todo o dinheiro
            dinheiro = 0;
        end
        if sinais(i) == -1 && portfolio~=0%Vende
            dinheiro = portfolio * y(i);%"Liquida";
            portfolio = 0;
        end
    end
    dinheiro = dinheiro + portfolio * y(end);%"Liquida";
    
    lucro(lag) = 100 * (dinheiro - dinheiro_inicial) / dinheiro_inicial;
    
end

lucro = lucro(2:end);
lags = 2:Max_lag;

figure;
plot(lags(1:15),lucro(1:15),'-r','LineWidth',2);
grid on;
ylabel('Lucro','fontsize',14);
xlabel('\tau','fontsize',14);
hold on;
line([lags(1) lags(15)],[lucro_buy_and_hold lucro_buy_and_hold],'LineStyle','--','Color','b','LineWidth',3);
hold off;
lh = legend('Média Móvel(\tau)','Lucro Buy and Hold','location','southeast')
set(lh,'fontSize',14)
print('-depsc','fig_mm_lucro2');
