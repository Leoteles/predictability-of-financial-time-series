close all;
clear all;
clc;

randn('state',0);
rand('state',0);


%Numero de amostras por classe
N = 200;
%Centro das classes
Ca = [0; 0];
Cb = [5; 5];
Cc = [10; 10];
a = randn(2,N);
a = [a(1,:)+Ca(1); a(2,:)+Ca(2)];
b = randn(2,N);
b = [b(1,:)+Cb(1); b(2,:)+Cb(2)];
c = randn(2,N);
c = [c(1,:)+Cc(1); c(2,:)+Cc(2)];


% dados = [a b];
% yyd = [-1*ones(1,N) ones(1,N)];
% ordem = randperm(size(dados,2));%Ordem aleatoria dos dados
% dados = dados(:,ordem);
% yd = yd(ordem);
% 
% plot(a(1,:),a(2,:),'.r');
% hold on;
% plot(b(1,:),b(2,:),'.b');
% hold off;

dados = [a b c];
yd = [-1*ones(1,N) ones(1,N) -1*ones(1,N)];
ordem = randperm(size(dados,2));%Ordem aleatoria dos dados
dados = dados(:,ordem);
yd = yd(ordem);

figure(1);
h(1) = plot(a(1,:),a(2,:),'.r');
hold on;
h(2) = plot(b(1,:),b(2,:),'sb');
h(3) = plot(c(1,:),c(2,:),'.r');
hold off;
grid on;
h_legend = legend([h(1) h(2)],'Padrão 1','Padrão 2','Location','SouthEast');
set(h_legend,'FontSize',14);
xlabel('Dimensão 1','fontsize',14);
ylabel('Dimensão 2','fontsize',14);
print('-depsc','fig_entrada_gaussiana1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Numero de neuronios
K = 2;

%Calcula os centros dos padroes
[centros,classeDados] = mykmeans(dados,K);

%Calcula os raios
[raios] = findRadius(centros,2);

%Calcula, para os dados disponiveis a saida da camada escondida
y1 = rbf1out(dados,centros,raios);

nEpocas = 100;
eta = 1;%Taxa de aprendizado do perceptron
[wRBF,erroEpocaRBF] = myPerceptron(y1,yd,nEpocas,eta);
%Reta que mostra a separação entre as classes na camada de saída
x_retaRBF = 0.6:0.1:1.1;
retaRBF = -(wRBF(2)/wRBF(3))*x_retaRBF - (wRBF(1)/wRBF(3));

figure(2);
plot(a(1,:),a(2,:),'.r');
hold on;
plot(b(1,:),b(2,:),'sb');
plot(c(1,:),c(2,:),'.r');
t = linspace(0, 2*pi, 100);
cores = {'--c','-g'};
lw = [1 3];
for i=1:K
    h(i) = plot(raios(i)*cos(t)+centros(1,i),raios(i)*sin(t)+centros(2,i),cores{i},'LineWidth',lw(i)) 
end
h(3) = plot(centros(1,1),centros(2,1),'kp','MarkerSize',14,'MarkerFaceColor','w','MarkerEdgeColor','c');
h(4) = plot(centros(1,2),centros(2,2),'kp','MarkerSize',14,'MarkerFaceColor','g','MarkerEdgeColor','g');
h_legend = legend([h(3) h(1) h(4) h(2)],'Centro 1','Raio 1','Centro 2','Raio 2','Location','SouthEast');
set(h_legend,'FontSize',14);
hold off;
xlabel('Dimensão 1','fontsize',14);
ylabel('Dimensão 2','fontsize',14);
print('-depsc','fig_entrada_gaussiana2');



figure(3);
aRBF = rbf1out(a,centros,raios);
bRBF = rbf1out(b,centros,raios);
cRBF = rbf1out(c,centros,raios);
h(1) = plot(aRBF(1,:),aRBF(2,:),'.r');
hold on;
h(2) = plot(bRBF(1,:),bRBF(2,:),'sb');
h(3) = plot(cRBF(1,:),cRBF(2,:),'.r');
h(4) = plot(x_retaRBF,retaRBF,'-g','LineWidth',2);
hold off;
grid on;
h_legend = legend([h(1) h(2) h(4)],'Padrão 1','Padrão 2','Separação de padrões gerada pela rede','Location','North');
set(h_legend,'FontSize',14);
xlabel('Saída -  Neurônio 1','fontsize',14);
ylabel('Saída -  Neurônio 2','fontsize',14);
print('-depsc','fig_saida_gaussiana');

