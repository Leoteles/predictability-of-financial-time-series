close all;
clear all;
clc;

carrega_series;
serie = wgn;
clearvars -except serie;

vetor_m = 1:7;

%Obtem a integral de correlação
tau=1;nbins=200;nt=0;pretty=0;
[bins,np]=corrint(serie,vetor_m,tau,nbins,nt,pretty);
bins = bins';

figure;
hold on;
cores = ['b','g','r','c','m','y','k'];
lbins = log(bins);
lnp = log(np);
for i = 1:length(vetor_m)
    %Não mostra elementos iguais a -inf, para melhor vizualizar o gráfico
    lnp2 = lnp(:,i);
    lbins2 = lbins;
    %Retira os elementos -inf do fim do vetor
    fim = find(isfinite(lnp2),1,'last');
    lnp2 = lnp2(1:fim);
    lbins2 = lbins2(1:fim);
    %Retira os elementos -inf do inicio do vetor
    inicio = find(isinf(lnp2),1,'last');
    lnp2 = lnp2(inicio+1:end);
    lbins2 = lbins2(inicio+1:end);
    %Finalmente, plota os resultados
    plot(lbins2,lnp2,cores(i),'linewidth',i);
end
axis([-5 2.5 0 15]);
legend('m=1','m=2','m=3','m=4','m=5','m=6','m=7','location','southeast');
hold off;
grid on;
xlabel('log(\epsilon)');
ylabel('log(C(\epsilon))');
print -depsc 'fig_corrint_wgn_variando_m';


% % % % figure;
% % % % hold on;
% % % % cores = ['b','g','r','c','m','y','k'];
% % % % for i = 1:length(vetor_m)
% % % %     plot(log(bins),log(np(:,1).^(vetor_m(i))),cores(i),'linewidth',i);
% % % % end
% % % % % axis([-5 2.5 0 15]);
% % % % legend('m=1','m=2','m=3','m=4','m=5','m=6','m=7','location','southeast');
% % % % hold off;
% % % % grid on;
% % % % xlabel('log(\epsilon)');
% % % % ylabel('log(C(\epsilon))');
% % % % % print -depsc 'fig_corrint_wgn_variando_m2';
% % % % 

figure;
plot(np(:,1),'r');
hold on;
plot(np(:,2),'b');
plot(np(:,1).^2,'g');
hold off;

for j = 1:length(vetor_m);
    %integra npXbins
    integral(j) = bins(1)*np(1,j);%Integra de zero a bins(1)
    for i = 2:length(bins)
        dx = bins(i) - bins(i-1);
        y = np(i,j);
        integral(j) = integral(j) + y*dx;
    end
    np2(:,j) = np(:,j) ./ integral(j);
end


figure;
plot(np2(:,1),'r');
hold on;
plot(np2(:,2),'b');
plot(np2(:,1).^2,'g');
hold off;

normalizacao = (np' * bins)
for i = 1:length(vetor_m)
    np3(:,i) = np(:,i)./normalizacao(i);
end

figure;
loglog(np3(:,1),'r');
hold on;
loglog(np3(:,2),'b');
loglog(np3(:,1).^2,'g');
hold off;
