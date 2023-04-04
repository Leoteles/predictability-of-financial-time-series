close all;
clear all;
clc;

carrega_series;

%Par�metros da rotina de analise de dados sub-rogados
Nsur = 1%50;%N�mero de surrogates

serie = arch1;

serie = sin(1:0.1:20);
serie = serie + randn(1,length(serie))*0.1;
m = 2;
tau = 1;
n = length(serie);


subplot(2,2,1);
plot(serie);


rad = 0.0008

for i = 1:Nsur
    [yp,yi]=pps(serie,m,tau,n,rad);
    z(:,i) = yp';
end

subplot(2,2,2);
plot(yp);


rho=findrhoquick(serie,m,1)%,ptarget,Aopt)

for i = 1:Nsur
    [yp,yi]=pps(serie,m,rho,n,rad);
    z(:,i) = yp';
end 

subplot(2,2,3);
plot(yp);

rho=findrho(serie,m,1)%,ptarget,Aopt)

for i = 1:Nsur
    [yp,yi]=pps(serie,m,rho,n,rad);
    z(:,i) = yp';
end 

subplot(2,2,4);
plot(yp); 

rho=findrho2(serie,m,1)%,ptarget,Aopt)


for i = 1:Nsur
    [yp,yi]=pps(serie,m,rho,n,rad);
    z(:,i) = yp';
end 

figure;
plot(yp); 