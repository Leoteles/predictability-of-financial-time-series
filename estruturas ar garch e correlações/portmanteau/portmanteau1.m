%Realiza o teste de portmanteau Ljung-Box(1978), uma versão melhorada do
%teste de Box-Pierce(1970) em relação a amostras finitas.(tirado do Tsay)

%Caso 1: serie não correlacionada

close all;
clear all;
clc;

randn('state',0);
tamanho = 1000;
nLags = 10;%Numero de atrasos que a simulação usará
N = 10000;%Numero de simulações

for i = 1:N
    
    %Cria vetor branco gaussiano
    vetor = randn(tamanho,1);
    
    %Calcula a estatistica q até o atraso 25
    q(i,:) = ljungbox_q25(vetor)';
    
    
    if (~mod(i,100))
        i
    end
end

q_nLags = q(:,nLags);%Retem na simulação somente q no atraso nLags
[freq,x] = hist(q_nLags,50);
p = freq./sum(freq);

x_chi2 = 0:50;
chi2 = chi2pdf(x_chi2,nLags);

%Plota as distribuições e frequências normalizadas
figure;
plot(x_chi2,chi2,'--r');
hold on;
area(x,p);
hold off;
grid on;
xlabel('q');
ylabel('probabilidade');
%print('-djpeg','q_randn');

%Calcula as distribuições acumuladas
p_cum = cumsum(p);
chi2_cum = cumsum(chi2);

%Plota as distribuiçôes e frequências normalizadas acumuladas
figure;
plot(x_chi2,chi2_cum,'--r');
hold on;plot(x,p_cum);
hold off;
grid on;
xlabel('q');
ylabel('probabilidade');
%print('-djpeg','q_randn_cum');


%Encontra o valor de x para o percentil 95 do qui quadrado com n_lags graus
%de liberdade, que é o valor da significancia para um intervalo de
%confiança de 2 sigma. A variável aleatória x, no caso, é a estatística q(m)
x_lim = chi2inv(0.95,nLags);%Este é o valor critico para 'q' nesse valor de atraso
%Teste de portmanteau propriamente dito: Se x_lim maior que q no atraso em
%questão, a hipotese nula (de que não há correlação significativa) é rejeitada



