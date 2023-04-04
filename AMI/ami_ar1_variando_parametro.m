close all;
clear all;
clc;

randn('state',0);

N = 3500;%Número de dados da série
teta = (0.2:0.1:0.7)';%Parâmetro autoregressivo
%Calcula a estatística AMI para os 10 primeiros atrasos da série
lags = 1:10;


%A linha indica a série e a coluna indica o elemento da série
y(1:length(teta),1) = randn(length(teta),1);%Valor inicial de todas as séries;

%Calcula a série AR(1) para os parametros teta
for n = 2:N
    y(:,n) = teta .* y(:,n-1) + randn(length(teta),1);
end

% for i = 1:9
%     figure;
%     autocorr(y(i,:));
% end


for i = 1:length(teta)

    %Calcula AMI para a série
    [v,lag]=calculaAMI(y(i,:),y(i,:),lags);
    ami(i,:) = v;%vetor coluna
end

%Plota apen para os varios teta
cores = ['b','g','r','c','m','y'];
%cores = ['k','k','k','k','k','k'];
espessura = linspace(1,6,length(teta));
figure;
hold on;
for i = 1:length(teta)
    plot(lag,ami(i,:),cores(i),'LineWidth',espessura(i));
end
grid minor;
% axis([0 0.15 -0.1 0.8]);
xlabel('\tau (atrasos)');
ylabel('AMI');
legend('\theta = 0,2','\theta = 0,3','\theta = 0,4','\theta = 0,5','\theta = 0,8','\theta = 0,7','Location','NorthEast');
print -depsc 'fig_ami_ar1_variando_parametro';
