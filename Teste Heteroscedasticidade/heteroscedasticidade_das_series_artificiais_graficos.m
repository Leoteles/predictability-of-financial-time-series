clear all;
close all;
clc;
randn('state',0);

%Livro introductory econometrics - a modern approach; Woolridge

carrega_series;


serie = wgn;
teste='white';
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste);
[H ,pValor,v,vCritico,grausLiberdade]

%%%%%%Plota%%%%%%
x = 0:0.1:50;
y = chi2pdf(x,grausLiberdade);
figure;
plot(x,y,'--r');
hold on;
vCritico = chi2inv(0.95,grausLiberdade);%Percentil 95
line([vCritico vCritico],[0 0.05]);%Linha que indica o percentil 95
line([v v],[0 0.05],'LineWidth',3);
xlabel('LM(20)');
ylabel('PDF Qui-quadrado');
legend('Qui-quadrado(20)','Valor crítico','LM(20) Ruído branco gaussiano');
grid on;
hold off;
print('-depsc2','LM20_wgn');
%%Fim%Plota%%%%%%

serie = arch1;
teste='white';
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste);
[H ,pValor,v,vCritico,grausLiberdade]

%%%%%%Plota%%%%%%
x = 0:0.1:50;
y = chi2pdf(x,grausLiberdade);
figure;
plot(x,y,'--r');
hold on;
vCritico = chi2inv(0.95,grausLiberdade);%Percentil 95
line([vCritico vCritico],[0 0.05]);%Linha que indica o percentil 95
line([v v],[0 0.05],'LineWidth',3);
xlabel('LM(20)');
ylabel('PDF Qui-quadrado');
legend('Qui-quadrado(20)','Valor crítico','LM(20) ARCH(1)');
grid on;
hold off;
print('-depsc2','LM20_arch1');
%%Fim%Plota%%%%%%


serie = garch11;
teste='white';
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste);
[H ,pValor,v,vCritico,grausLiberdade]

%%%%%%Plota%%%%%%
x = 0:0.1:50;
y = chi2pdf(x,grausLiberdade);
figure;
plot(x,y,'--r');
hold on;
vCritico = chi2inv(0.95,grausLiberdade);%Percentil 95
line([vCritico vCritico],[0 0.05]);%Linha que indica o percentil 95
line([v v],[0 0.05],'LineWidth',3);
xlabel('LM(20)');
ylabel('PDF Qui-quadrado');
legend('Qui-quadrado(20)','Valor crítico','LM(20) GARCH(1,1)');
grid on;
hold off;
print('-depsc2','LM20_garch11');
%%Fim%Plota%%%%%%
