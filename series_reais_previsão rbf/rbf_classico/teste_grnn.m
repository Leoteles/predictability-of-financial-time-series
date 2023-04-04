close all;
clear all;
clc;


% carrega_series;
% serie = ar1;
% serie = logistica;
% serie = rpetc;
load('rpetc_resGARCH11.mat');


serie = serie(:);


Ndelays = 8;%Número de atrasos (AR) a serem considerados para a criação do vetor de entrada TDNN


Nval = 0.15;
Ntest = 0.15;

[xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);

xtr = xtr';
ydtr = ydtr';
xval = xval';
ydval = ydval';
xtest = xtest';
ydtest = ydtest';

minspread = 1e-9;
maxspread = 1;

% % % K = 100;%Número de spreads para validação
% % % spread = linspace(minspread,maxspread,K);
% % % 
% % % for i = 1:K
% % %     net = newgrnn(xtr,ydtr,spread(i));
% % %     yval = sim(net,xval);
% % %     erro_val(i) = mean(abs(yval - ydval));
% % % end
% % % %melhor spread é o de menor erro de validacao
% % % melhor_spread = spread(erro_val == min(erro_val));
% % % figure;
% % % plot(spread,erro_val);


%Encontra o spread que minimiza o erro de validação
%global xtr ydtr xval ydval;
%melhor_spread = fminbnd(@(spread) calcula_erro_spread(spread,xtr, ydtr, xval, ydval),minspread,maxspread,optimset('Display','iter'))
melhor_spread = fminbnd(@(spread) calcula_erro_spread(spread,xtr, ydtr, xval, ydval),minspread,maxspread)

%Rede resultante
% net = newgrnn(xtr,ydtr,melhor_spread);
%Junta-se os dados de validação e de treinamento
xtrval = [xtr xval];
ydtrval = [ydtr ydval];
net = newgrnn(xtrval,ydtrval,melhor_spread);


%Calcula saídas da rede e erros
% ytr = sim(net,xtr);
% e_tr = calculaErros(ytr,ydtr)
% yval = sim(net,xval);
% e_val = calculaErros(yval,ydval)

% ytest = sim(net,xtest);
% e_test = calculaErros(ytest,ydtest)

clear ytest;
for i = 1:length(ydtest)
    ytest(i) = sim(net,xtest(:,i));

    %xtrval = [xtrval xtest(:,i)];
    %ydtrval = [ydtrval ydtest(i)];
    %net = newgrnn(xtrval,ydtrval,melhor_spread);
end
e_test = calculaErros(ytest,ydtest)

% figure;
% plot(ydtr,'-b')
% xlabel('amostras');ylabel('ytr');
% hold on;
% plot(ytr,'.-r')
% hold off;legend('ydtr','ytr');
% 
% figure;
% plot(ydval,'-b');
% xlabel('amostras');ylabel('yval');
% hold on;
% plot(yval,'.-r')
% hold off;legend('ydval','yval');
% 
% figure;
% plot(ydtest,'-b');
% xlabel('amostras');ylabel('ytest');
% hold on;
% plot(ytest,'.-r');
% hold off;legend('ydtest','ytest');


% 
% %Treinamento do modelo linear AR
% modeloAR = estimaModeloAR(ydtrval',Ndelays);
% 
% %Erro de validação
% for i = 1:length(ydval)
%     ytest_lin(i,:) = previsaoAR(modeloAR,xtest(:,i)');
% end
% ytest_lin = ytest_lin';
% etest_lin = calculaErros(ytest_lin,ydtest_lin)



