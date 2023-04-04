%Realiza o teste de portmanteau Ljung-Box(1978), uma versão melhorada do
%teste de Box-Pierce(1970) em relação a amostras finitas.(tirado do Tsay)

%Petr4

close all;
clear all;
clc;
format bank;

%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;

%Obtem retornos dos precos de abertura, fechamento, maxima e minima
rop = price2ret(abertura);
rcl = price2ret(fechamento);
rhi = price2ret(maxima);
rlo = price2ret(minima);

nLags = [5 10 15 20];

%Calcula a estatistica q até o atraso 25
q_cl = ljungbox_q25(rcl);
q_op = ljungbox_q25(rop);
q_hi = ljungbox_q25(rhi);
q_lo = ljungbox_q25(rlo);

%Encontra o valor de x para o percentil 95 do qui quadrado com n_lags graus
%de liberdade, que é o valor da significancia para um intervalo de
%confiança de 2 sigma. A variável aleatória x, no caso, é a estatística q(m)
x_lim = chi2inv(0.95,nLags);%Este é o valor critico para 'q' nesse valor de atraso
%Teste de portmanteau propriamente dito: Se x_lim maior que q no atraso em
%questão, a hipotese nula (de que não há correlação significativa) é rejeitada

%Monta a tabela de resultados para o teste LBQ para os dados de retorno da
%abertura, fechamento, maxima e mínima
resultado = [nLags' x_lim' q_cl(nLags) q_op(nLags) q_hi(nLags) q_lo(nLags)];
disp('       Atrasos      Q limite         Fech.      Abertura        Maxima        Minima');
disp(resultado);


%Calcula a estatistica q até o atraso 25 para o quadrado dos retornos
q_cl2 = ljungbox_q25(rcl.^2);
q_op2 = ljungbox_q25(rop.^2);
q_hi2 = ljungbox_q25(rhi.^2);
q_lo2 = ljungbox_q25(rlo.^2);

%Encontra o valor de x para o percentil 95 do qui quadrado com n_lags graus
%de liberdade, que é o valor da significancia para um intervalo de
%confiança de 2 sigma. A variável aleatória x, no caso, é a estatística q(m)
x_lim = chi2inv(0.95,nLags);%Este é o valor critico para 'q' nesse valor de atraso
%Teste de portmanteau propriamente dito: Se x_lim maior que q no atraso em
%questão, a hipotese nula (de que não há correlação significativa) é rejeitada

%Monta a tabela de resultados para o teste LBQ para os dados de retorno da
%abertura, fechamento, maxima e mínima
resultado = [nLags' x_lim' q_cl2(nLags) q_op2(nLags) q_hi2(nLags) q_lo2(nLags)];
disp('       Atrasos      Q limite         Fech.      Abertura        Maxima        Minima');
disp(resultado);
