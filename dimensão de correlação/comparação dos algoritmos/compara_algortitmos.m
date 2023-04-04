close all;
clear all;
clc;


carrega_series

%serie = sin(1:100);
%Demora um minuto para calcular a logistica toda (3500) para um único m
serie = logistica;%(1:1000);
clearvars ** -except serie

vetor_m = 2:7;
% 
% tic
% [m1,logC1,logr1] = calculaDimensaoGP(serie,vetor_m);
% logC1 = logC1';
% toc
% 
% tic
% [logC2,logr2]=Alexandros_calculaDimensao(serie,vetor_m);
% toc
% 
% tic
% [r3,C3]=corrint(serie,vetor_m);
% toc
% logr3 = log10(r3);
% logC3 = log10(C3);
% 
% % tic
% [r4,C4]=corrintMOD(serie,vetor_m);
% toc
% logr4 = log10(r4);
% logC4 = log10(C4/1000000);


% 
% 
% tic
% [m,dcm,eps0,cim]=judd(serie,vetor_m);
% toc
% 
% cores = ['b','g','r','c','m','y'];
% figure;
% % plot(logr1,logC1,'-b');
% hold on;
% % plot(logr2,logC2,'-r');
% for i = 1:length(vetor_m)
%     plot(logr3,logC3(:,i),cores(i));
% end
% for i = 1:length(vetor_m)
%     plot(log10(dcm{i}(1,:)),log10(dcm{i}(2,:)),cores(i));
% end
% hold off;
% grid minor;
figure;
[bins,np]=corrint(serie,vetor_m);%,tau,nbins,nt,pretty);
figure;
[m,d,k,s,gki]=gka(serie,vetor_m);%,tau,nbins,nt,pretty)
figure;
[m,dc,eps0,ci] = judd(serie,vetor_m);%,tau,nbins,nt,dt);
