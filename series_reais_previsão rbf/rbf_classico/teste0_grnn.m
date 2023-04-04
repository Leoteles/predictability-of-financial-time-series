close all;
clear all;
clc;


xtr = -10:1:10;
ydtr = xtr.^2;
xval = 4:0.1:7;
ydval = xval.^2;
xtest = -10:0.1:10;
ydtest = xtest.^2;

K = 10;

spread = linspace(0.01,1,K);

for i = 1:K
    net = newgrnn(xtr,ydtr,spread(i));
    yval = sim(net,xval);
    erro_val(i) = mean(abs(yval - ydval));
end

%melhor spread é o de menor erro de validacao
melhor_spread = spread(erro_val == min(erro_val));

%Rede resultante
net = newgrnn(xtr,ydtr,melhor_spread);

%Calcula resultados para os dados de teste
ytest = sim(net,xtest);


figure;
plot(spread,erro_val);

figure;
plot(xtr,ydtr,'.','markersize',30)
title('Function to approximate.')
xlabel('xtr')
ylabel('ydtr')
hold on
outputline = plot(xval,yval,'.','markersize',30,'color',[1 0 0]);
plot(xtest,ytest,'linewidth',4,'color',[1 0 0])
plot(xtest,ydtest,'.-k','linewidth',1)
hold off;
