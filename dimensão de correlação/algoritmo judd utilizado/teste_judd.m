close all;
clear all;
clc;

carrega_series

%serie = sin(1:100);
serie = logistica;%(1:1000); %Demora um minuto para calcular essa s�rie toda para um �nico m
clearvars ** -except serie

vetor_m = 2;

[m,dc,eps0,ci] = calculaDimCorJudd(serie,vetor_m);

epsilon0 = dc{1}(1,:);
dimcor = dc{1}(2,:);

figure;
semilogx(epsilon0,dimcor);
grid on;


