%Realiza o teste de portmanteau Ljung-Box(1978), uma vers�o melhorada do
%teste de Box-Pierce(1970) em rela��o a amostras finitas.(tirado do Tsay)
close all;
clear all;
clc;

%Caso 2: serie correlacionada, processo AR1

randn('state',0);
tamanho = 1000;
nLags = 10;%Numero de atrasos que a simula��o usar�
N = 1000;%Numero de simula��es

for i = 1:N
    
    %Cria vetor que segue um processo AR1 com parametro igual a 0.8
    clear vetor; 
    inovacao = randn(tamanho,1);

    vetor(1) = inovacao(1);
    for k = 2:tamanho
        vetor(k) = 0.8 * vetor(k-1) + inovacao(k);
    end
    vetor  = vetor';%Deve ser um vetor linha
        
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
%print('-djpeg','q_AR1_08');

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
%print('-djpeg','q_AR1_cum_08');


%Encontra o valor de x para o percentil 95 do qui quadrado com n_lags graus
%de liberdade, que � o valor da significancia para um intervalo de
%confian�a de 2 sigma. A vari�vel aleat�ria x, no caso, � a estat�stica q(m)
x_lim = chi2inv(0.95,nLags);%Este � o valor critico para 'q' nesse valor de atraso
%Teste de portmanteau propriamente dito: Se x_lim maior que q no atraso em
%quest�o, a hipotese nula (de que n�o h� correla��o significativa) � rejeitada


