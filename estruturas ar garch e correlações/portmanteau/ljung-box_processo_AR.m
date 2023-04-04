%Realiza o teste de portmanteau Ljung-Box(1978), uma versão melhorada do
%teste de Box-Pierce(1970) em relação a amostras finitas.(tirado do Tsay)
close all;
clear all;
clc;

%Serie correlacionada, processo AR1

randn('state',0);
tamanho = 1000;
nLags = 10;%Numero de atrasos que a ests. Q usará
N = 1000;%Numero de simulações

alfa = 0.2;
for i = 1:N
    
    %Cria vetor que segue um processo AR1 com parametro igual a alfa
    clear vetor; 
    inovacao = randn(tamanho,1);

    vetor(1) = inovacao(1);
    for k = 2:tamanho
        vetor(k) = alfa * vetor(k-1) + inovacao(k);
    end
    vetor  = vetor';%Deve ser um vetor linha
        
    %Calcula a estatistica q até o atraso 25
    [h,pValue,stat,cValue] = lbqtest(vetor,nLags,0.05);
    q_alfa_02(i) = stat;
    
    
    if (~mod(i,100))
        i
    end
end

alfa = 0.4;
for i = 1:N
    
    %Cria vetor que segue um processo AR1 com parametro igual a alfa
    clear vetor; 
    inovacao = randn(tamanho,1);

    vetor(1) = inovacao(1);
    for k = 2:tamanho
        vetor(k) = alfa * vetor(k-1) + inovacao(k);
    end
    vetor  = vetor';%Deve ser um vetor linha
        
    %Calcula a estatistica q até o atraso 25
    [h,pValue,stat,cValue] = lbqtest(vetor,nLags,0.05);
    q_alfa_04(i) = stat;
    
    
    if (~mod(i,100))
        i
    end
end

[freq,x02] = hist(q_alfa_02,50);
p02 = freq./sum(freq);

[freq,x04] = hist(q_alfa_04,50);
p04 = freq./sum(freq);

%Distribuição qui-quadrado com nLags graus de liberdade
x_chi2 = 0:50;
chi2 = chi2pdf(x_chi2,nLags);

%Encontra o valor de x para o percentil 95 do qui quadrado com n_lags graus
%de liberdade, que é o valor da significancia para um intervalo de
%confiança de 2 sigma. A variável aleatória x, no caso, é a estatística q(m)
x_lim = chi2inv(0.95,nLags);%Este é o valor critico para 'q' nesse valor de atraso
%Teste de portmanteau propriamente dito: Se x_lim maior que q no atraso em
%questão, a hipotese nula (de que não há correlação significativa) é rejeitada


%Plota as distribuições e frequências normalizadas
figure;
plot(x_chi2,chi2,'--r');
hold on;
area(x02,p02,'FaceColor',[153/255 255/255 102/255]);
line([x_lim x_lim],[0 0.05],'LineWidth',2);%Linha que indica o percentil 95
hold off;
grid on;
xlabel('q(10)');
ylabel('frequência normalizada');
legend('qui-quadrado(10)','frequência normalizada','percentil 95');
axis([0 400 0 0.1]);
print('-depsc2','q10_AR1_02');

%Plota as distribuições e frequências normalizadas
figure;
plot(x_chi2,chi2,'--r');
hold on;
area(x04,p04,'FaceColor',[153/255 255/255 102/255]);
line([x_lim x_lim],[0 0.05],'LineWidth',2);%Linha que indica o percentil 95
hold off;
grid on;
xlabel('q(10)');
ylabel('frequência normalizada');
legend('qui-quadrado(10)','frequência normalizada','percentil 95');
axis([0 400 0 0.1]);
print('-depsc2','q10_AR1_04');
