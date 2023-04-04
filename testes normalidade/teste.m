close all;
clc;



figure;
bar(xout,n,'FaceColor',[.89 .94 .9],'EdgeColor','k');
hold on;
plot(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Hist. norm. dos Retornos','Distribuição Estimada','location','northwest');
axis([-0.1 0.1 -1 50]);
hold off;

figure;
semilogy(xout,n);
hold on;
semilogy(eixo_x,pdf_sur,'--r','LineWidth',1);
legend('Histograma normalizado dos Retornos','Distribuição Normal Estimada','location','south');
axis([-0.1 0.1 -1 50]);
hold off;