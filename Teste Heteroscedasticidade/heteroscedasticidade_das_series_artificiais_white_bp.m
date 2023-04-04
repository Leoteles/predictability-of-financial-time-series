clear all;
close all;
clc;
randn('state',0);

%Livro introductory econometrics - a modern approach; Woolridge

carrega_series;
matriz = [];

rand('state',0);
wun = rand(3500,1);%Ruído branco uniforme
wun = wun - mean(wun);
wun = wun ./ std(wun);

teste='bp';

serie = wgn;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];


serie = wun;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];

serie = arch1;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];

serie = garch11;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];

serie = logistica;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];


teste='white';

serie = wgn;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];

serie = wun;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];

serie = arch1;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];

serie = garch11;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];

serie = logistica;
[H ,pValor,v,vCritico,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v,vCritico];


matrix2table(matriz)