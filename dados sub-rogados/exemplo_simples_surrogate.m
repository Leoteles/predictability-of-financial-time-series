clear all;
close all;
clc;

t = 1:0.1:10;

y = sin(t);


surr1 = y(randperm(length(y)));
surr2 = y(randperm(length(y)));
surr3 = y(randperm(length(y)));


%Dados originais
figure;
plot(t,y,'-r','LineWidth',3);
grid on;

%Dados sub-rogados
figure;
plot(t,surr1,'-r','LineWidth',3);
grid on;

figure;
plot(t,surr2,'-r','LineWidth',3);
grid on;

figure;
plot(t,surr3,'-r','LineWidth',3);
grid on;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Início calculo AMI%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calcula a estatística AMI para os Surrogates
lags = 1:10;
[AMI,lag]=calculaAMI(surr1,surr1,lags);
AMI_surr1 = AMI';%vetores coluna para cada surrogate
[AMI,lag]=calculaAMI(surr2,surr2,lags);
AMI_surr2 = AMI';%vetores coluna para cada surrogate
[AMI,lag]=calculaAMI(surr3,surr3,lags);
AMI_surr3 = AMI';%vetores coluna para cada surrogate
[AMI,lag]=calculaAMI(y,y,lags);
AMI_serie = AMI';%vetor coluna

%Mostra a estatistica AMI da serie
figure;
hold on;
h = plot(lags,AMI_serie,'--r','LineWidth',4);
legend(h,'AMI Série');
xlabel('\tau','fontsize',14);
ylabel('AMI(\tau)','fontsize',14);
grid on;
hold off;

%Mostra a estatistica AMI dos surrogates 1
figure;
hs = plot(lags,AMI_surr1,'-b');
legend(hs,'AMI Sub-rogados 1');
xlabel('\tau','fontsize',14);
ylabel('AMI(\tau)','fontsize',14);
grid on;
hold off;

%Mostra a estatistica AMI dos surrogates 1
figure;
hs = plot(lags,AMI_surr2,'-b');
legend(hs,'AMI Sub-rogados 2');
xlabel('\tau','fontsize',14);
ylabel('AMI(\tau)','fontsize',14);
grid on;
hold off;

%Mostra a estatistica AMI dos surrogates 3
figure;
hs = plot(lags,AMI_surr3,'-b');
legend(hs,'AMI Sub-rogados 3');
xlabel('\tau','fontsize',14);
ylabel('AMI(\tau)','fontsize',14);
grid on;
hold off;



%Compara a estatistica AMI da serie e surrogates
figure;
hold on;
hs = plot(lags,AMI_surr1,'-b');
hs = plot(lags,AMI_surr2,'-b');
hs = plot(lags,AMI_surr3,'-b');
h = plot(lags,AMI_serie,'--r','LineWidth',4);
legend([h hs],'AMI Série','AMI Sub-rogados');
xlabel('\tau','fontsize',14);
ylabel('AMI(\tau)','fontsize',14);
grid on;
hold off;