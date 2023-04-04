%Mostra várias correlaçoes entre retornos


clear all;
close all;
clc;

%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;

%Obtem retornos dos precos de abertura, fechamento, maxima e minima
rop = price2ret(abertura);
rcl = price2ret(fechamento);
rhi = price2ret(maxima);
rlo = price2ret(minima);


% %Ljung-Box-Pierce Q-Test, H=1 confirma correlações significativas
% [H,pValue,Stat,CriticalValue] = lbqtest(rcl-mean(rcl),[10 15 20]',0.05);
% [H,pValue,Stat,CriticalValue]
% [H,pValue,Stat,CriticalValue] = lbqtest(rop-mean(rop),[10 15 20]',0.05);
% [H,pValue,Stat,CriticalValue]
% [H,pValue,Stat,CriticalValue] = lbqtest(rhi-mean(rhi),[10 15 20]',0.05);
% [H,pValue,Stat,CriticalValue]
% [H,pValue,Stat,CriticalValue] = lbqtest(rlo-mean(rlo),[10 15 20]',0.05);
% [H,pValue,Stat,CriticalValue]
% 

figure;
subplot(2,2,1);
autocorr(rop,[],2)
title('Auto-correlacao dos retornos - Abertura');

%figure;
subplot(2,2,2);
autocorr(rcl,[],2)
title('Auto-correlacao dos retornos - Fechamento');

%figure;
subplot(2,2,3);
autocorr(rhi,[],2)
title('Auto-correlacao dos retornos - Maxima');

%figure;
subplot(2,2,4);
autocorr(rlo,[],2)
title('Auto-correlacao dos retornos - Minima');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
crosscorr(rop,rcl,[],2)
title('Correlacao dos retornos - Abertura x Fechamento');

figure;
crosscorr(rop,rhi,[],2)
title('Correlacao dos retornos - Abertura x Maxima');

figure;
crosscorr(rop,rlo,[],2)
title('Correlacao dos retornos - Abertura x Minima');

figure;
crosscorr(rcl,rhi,[],2)
title('Correlacao dos retornos - Fechamento x Maxima');

figure;
crosscorr(rcl,rlo,[],2)
title('Correlacao dos retornos - Fechamento x Minima');

figure;
crosscorr(rhi,rlo,[],2)
title('Correlacao dos retornos - Maxima x Minima');


rcl_op = log(fechamento./abertura);%Retorno do fechamento em relacao a abertura
rcl_op = rcl_op(2:end);%Coloca o rcl_op na mesma amostra de tempo de rcl

figure;
autocorr(rcl_op,[],2)
title('Autocorrelacao dos retornos do fechamento em relacao a abertura');


figure;
crosscorr(rcl_op,rcl,[],2)
title('Correlacao dos retornos do fechamento em relacao a abertura X retorno dos fechamentos');



figure;
crosscorr(rcl-mean(rcl),rcl.^2-mean(rcl.^2),[],2)
title('Correlacao dos retornos - Fechamento x Fechamento^2');

figure;
crosscorr((rcl.^2)-mean(rcl.^2),(rcl.^2)-mean(rcl.^2),[],2)
title('Correlacao dos retornos - Fechamento^2 x Fechamento^2');


