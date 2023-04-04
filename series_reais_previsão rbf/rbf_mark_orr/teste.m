close all;
clear all;
clc;

carrega_series;
serie = rpetc;
clearvars -except serie;
Nval = 0.15; %'Porcentagem' dos dados destinada a valida��o do modelo



for Ndelays = 1:20;
    %Ndelays
    [xtr,ydtr,xval,ydval] = preparaDados(serie,Ndelays,Nval);
    %Adapta a sa�da da fun��o acima para as fun��es fbr de Mark Orr
    xtr = xtr';
    xval = xval';
    ydtr = ydtr;
    ydval = ydval;
    
    
    [c,r,w,info] = rbf_fs_2(xtr,ydtr);
    size(c)
    
    Ht = rbf_dm(xval,c,r,info.dmc);
    yval = Ht * w;
    
    erros = calculaErros(yval,ydval);
    
    e(Ndelays) = erros;
    
end

for i = 1:length(e)
    rmse(i) = e(i).rmse;
    pb(i) = e(i).pb;
end

figure;
plot(rmse);
figure;
plot(pb);

% figure;
% plot(ydval,'k--');
% hold on;
% plot(yval,'r-');
% hold off;



