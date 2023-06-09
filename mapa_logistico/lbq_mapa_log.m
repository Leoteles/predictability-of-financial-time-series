close all;
clear all;
clc;

%%%%%sem corr em x e com corr em x^2
% % % N = 3500;
% % % %**************Parâmetros do mapa**************%
% % % lambda = 3.9999;%Parâmetro de bifurcação do mapa
% % % x(1) = 0.15;%Valor inicial;


N = 3500;%Mesmo ordem de grandeza da serie financeira
%**************Parâmetros do mapa**************%
lambda = 3.9999:0.000001:4;%Parâmetro de bifurcação do mapa
x0 = 0.1;%Valor inicial;

lmax = length(lambda);
for i = 1:lmax
    
    

    x(1) = x0;%Valor inicial;
    %Simula mapa logistico
    for n = 2:N
        x(n) = lambda(i) * x(n-1) * (1-x(n-1));
    end

    %Teste Ljung-Box para x
    [H,P,Qstat,CV] = lbqtest(x, [10]', 0.05);
    q_x(i) = Qstat;

    %Teste Ljung-Box para x^2
    [H,P,Qstat,CV] = lbqtest(x.^2-mean(x.^2), [10]', 0.05);
    q_x2(i) = Qstat;

end

subplot(1,2,1);
plot(lambda,q_x);
hold on;
plot(lambda,CV*ones(size(lambda)),'-r');
title('Teste de Ljung-Box para x');
xlabel('Parâmetro de bifurcação');
ylabel('q(10)');
axis([lambda(1)  lambda(end)  0  300]);

hold off;

subplot(1,2,2);
plot(lambda,q_x2);
hold on;
plot(lambda,CV*ones(size(lambda)),'-r');
title('Teste de Ljung-Box para x^2');
xlabel('Parâmetro de bifurcação');
ylabel('q(10)');
axis([lambda(1)  lambda(end)  0  300]);
hold off;
