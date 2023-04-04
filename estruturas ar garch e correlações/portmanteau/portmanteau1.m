%Realiza o teste de portmanteau Ljung-Box(1978), uma vers�o melhorada do
%teste de Box-Pierce(1970) em rela��o a amostras finitas.(tirado do Tsay)

%Caso 1: serie n�o correlacionada

close all;
clear all;
clc;

randn('state',0);
tamanho = 1000;
nLags = 10;%Numero de atrasos que a simula��o usar�
N = 10000;%Numero de simula��es

for i = 1:N
    
    %Cria vetor branco gaussiano
    vetor = randn(tamanho,1);
    
    %Calcula a estatistica q at� o atraso 25
    q(i,:) = ljungbox_q25(vetor)';
    
    
    if (~mod(i,100))
        i
    end
end

q_nLags = q(:,nLags);%Retem na simula��o somente q no atraso nLags
[freq,x] = hist(q_nLags,50);
p = freq./sum(freq);

x_chi2 = 0:50;
chi2 = chi2pdf(x_chi2,nLags);

%Plota as distribui��es e frequ�ncias normalizadas
figure;
plot(x_chi2,chi2,'--r');
hold on;
area(x,p);
hold off;
grid on;
xlabel('q');
ylabel('probabilidade');
%print('-djpeg','q_randn');

%Calcula as distribui��es acumuladas
p_cum = cumsum(p);
chi2_cum = cumsum(chi2);

%Plota as distribui��es e frequ�ncias normalizadas acumuladas
figure;
plot(x_chi2,chi2_cum,'--r');
hold on;plot(x,p_cum);
hold off;
grid on;
xlabel('q');
ylabel('probabilidade');
%print('-djpeg','q_randn_cum');


%Encontra o valor de x para o percentil 95 do qui quadrado com n_lags graus
%de liberdade, que � o valor da significancia para um intervalo de
%confian�a de 2 sigma. A vari�vel aleat�ria x, no caso, � a estat�stica q(m)
x_lim = chi2inv(0.95,nLags);%Este � o valor critico para 'q' nesse valor de atraso
%Teste de portmanteau propriamente dito: Se x_lim maior que q no atraso em
%quest�o, a hipotese nula (de que n�o h� correla��o significativa) � rejeitada



