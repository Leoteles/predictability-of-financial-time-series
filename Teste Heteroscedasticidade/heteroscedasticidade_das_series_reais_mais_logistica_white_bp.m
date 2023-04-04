clear all;
close all;
clc;

%Livro introductory econometrics - a modern approach; Woolridge

carrega_series;
matriz = [];

serie = price2ret(logistica);
teste='bp';
[H ,pValor,v1,vCritico1,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
teste='white';
[H ,pValor,v2,vCritico2,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v1,vCritico1,v2,vCritico2];

serie = price2ret(djia);
teste='bp';
[H ,pValor,v1,vCritico1,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
teste='white';
[H ,pValor,v2,vCritico2,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v1,vCritico1,v2,vCritico2];

serie = price2ret(sp500);
teste='bp';
[H ,pValor,v1,vCritico1,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
teste='white';
[H ,pValor,v2,vCritico2,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v1,vCritico1,v2,vCritico2];

serie = price2ret(ibov);
teste='bp';
[H ,pValor,v1,vCritico1,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
teste='white';
[H ,pValor,v2,vCritico2,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v1,vCritico1,v2,vCritico2];

serie = price2ret(peto);
teste='bp';
[H ,pValor,v1,vCritico1,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
teste='white';
[H ,pValor,v2,vCritico2,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v1,vCritico1,v2,vCritico2];

serie = price2ret(peth);
teste='bp';
[H ,pValor,v1,vCritico1,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
teste='white';
[H ,pValor,v2,vCritico2,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v1,vCritico1,v2,vCritico2];

serie = price2ret(petl);
teste='bp';
[H ,pValor,v1,vCritico1,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
teste='white';
[H ,pValor,v2,vCritico2,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v1,vCritico1,v2,vCritico2];

serie = price2ret(petc);
teste='bp';
[H ,pValor,v1,vCritico1,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
teste='white';
[H ,pValor,v2,vCritico2,grausLiberdade] = testaHeteroscedasticidade(serie,teste)
matriz = [matriz; v1,vCritico1,v2,vCritico2];





matrix2table(matriz)