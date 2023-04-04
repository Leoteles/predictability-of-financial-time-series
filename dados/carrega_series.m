load('serieAR1.mat');
ar1 = serieAR1;
clear serieAR1;

load('serieRuidoBranco.mat');
wgn = serieRuidoBranco;
clear serieRuidoBranco;

load('serieARCH1.mat');
arch1 = serieARCH1;
clear serieARCH1;

load('serieGARCH11.mat');
garch11 = serieGARCH11;
clear serieGARCH11;

load('serieLogistica.mat');
logistica = serieLogistica;
clear serieLogistica;

% load('djia_1896_2005.mat');
% djia = djia_1896_2005_ymd_c(:,4);
% clear djia_1896_2005_ymd_c;
%!!!utilizar série mais recente, até 2011
load('djia_1896_2011.mat');
djia = djia_1896_2011_ymd_c(:,4);
clear djia_1896_2011_ymd_c;

% load('sp500_1950_2009.mat');
% sp500 = sp500_1950_2009_ymd_c(:,4);
% clear sp500_1950_2009_ymd_c;
%!!!utilizar série mais recente, até 2011
load('sp500_1950_2011.mat');
sp500 = sp500_1950_2011_ymd_c(:,4);
clear sp500_1950_2011_ymd_c;

% load('ibov_1968_2007.mat');
% ibov = ibov_1968_2007_ymd_c(:,4);
% clear ibov_1968_2007_ymd_c;
%!!!utilizar série mais recente, até 2010
load('ibov_1968_2010.mat');
ibov = ibov_1968_2010_ymd_c(:,4);
clear ibov_1968_2010_ymd_c;

% load('petr4_1995_2008');
% peto = petr4_1995_2008_ymd_ohlc(:,4);
% peth = petr4_1995_2008_ymd_ohlc(:,5);
% petl = petr4_1995_2008_ymd_ohlc(:,6);
% petc = petr4_1995_2008_ymd_ohlc(:,7);
% clear petr4_1995_2008_ymd_ohlc;
%!!!utilizar série mais recente, até 2010
load('petr4_1995_2011');
%!!!Não se utiliza os primeiros 70 valores da série pois há preços
%negativos, o que atrapalha o cálculo do retorno via price2ret. A série,
%entãO vai de 17 de abril de 1995 até 28 de janeiro de 2011 e tem 3904
%elementos
petr4_1995_2011_ymd_ohlc = petr4_1995_2011_ymd_ohlc(70:end,:);

peto = petr4_1995_2011_ymd_ohlc(:,4);
peth = petr4_1995_2011_ymd_ohlc(:,5);
petl = petr4_1995_2011_ymd_ohlc(:,6);
petc = petr4_1995_2011_ymd_ohlc(:,7);
clear petr4_1995_2011_ymd_ohlc;

%Calcula os retornos sem tendencia das séries reais
rdjia = price2ret(djia);
rdjia_media = mean(rdjia);
rdjia = rdjia - rdjia_media;

rsp500 = price2ret(sp500);
rsp500_media = mean(rsp500);
rsp500 = rsp500 - rsp500_media;

ribov = price2ret(ibov);
ribov_media = mean(ribov);
ribov = ribov - ribov_media;

rpeto = price2ret(peto);
rpeto_media = mean(rpeto);
rpeto = rpeto - rpeto_media;

rpeth = price2ret(peth);
rpeth_media = mean(rpeth);
rpeth = rpeth - rpeth_media;

rpetl = price2ret(petl);
rpetl_media = mean(rpetl);
rpetl = rpetl - rpetl_media;

rpetc = price2ret(petc);
rpetc_media = mean(rpetc);
rpetc = rpetc - rpetc_media;
