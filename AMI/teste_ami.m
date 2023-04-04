close all;
clear all;
clc;

Nsur = 100;%Número de surrogates
N = 3500;%Tamanho da série

%Gera estrutura AR(1) com parametro a = 0.3
y(1) = randn();
for t=2:N
    y(t) = 0.3 * y(t-1) + randn;
end
y = y';


N = length(y);

%Calcula a estatística AMI para os Surrogates
lags = 1:10;
%Calcula a estatistica AMI para a serie
[v,lag]=calculaAMI(y,y,lags);
v_serie = v';%vetor coluna

%Compara a estatistica v da serie e surrogates
figure;
plot(lags,v_serie,'--r','LineWidth',4);
xlabel('Atrasos');
ylabel('V(atrasos)');
hold off;
print -depsc 'fig_AR1_ami';

