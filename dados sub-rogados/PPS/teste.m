close all;
clear all;
clc;

carrega_series;

%Par�metros da rotina de analise de dados sub-rogados
Nsur = 50;%N�mero de surrogates
algoritmo = 'alg1';%Algoritmo utilizado
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'todas';%Mostra todas as estatisticas

%rand('state',0);
%randn('state',0);


nolinear = 1;
n = 3500;


nolinear=~(nolinear==0);

ns=50;  %number of surrogates
dcde=6; %dc and NLP de
sde=8; %PPS de


y=wgn;

%rho=findrho2(y,sde,1); %preference is sde=8;
rho=findrhoquick(y,sde,1) %preference is sde=8;

% rho=findrho(y,sde,1) %preference is sde=8;

%[dc,sig,dim,pe,perr]=ppscalc(y,dcde,sde,1,rho,ns);
close all;

de = 1;
tau = 1;
[yp1,yi]=pps(y,de,tau,n);%,rad,y1)
[yp2,yi]=pps(y,de,tau,n);%,rad,y1)

isequal(yp2,yp1)
