%Carrega os dados de petr4 contidos nos CSV gerados a partir 
% dos arquivos disponibilizados pela BOVESPA
clc;
clear all;

%ano | m�s | dia | abertura | m�xima | m�nima | m�dia | fechamento | volume
hist = [];
%hist = [hist; csvread('COTAHIST.1994pet 4.csv')];
hist = [hist; csvread('COTAHIST.1995pet 4.csv')];
hist = [hist; csvread('COTAHIST.1996pet 4.csv')];
hist = [hist; csvread('COTAHIST.1997pet 4.csv')];
hist = [hist; csvread('COTAHIST.1998pet 4.csv')];
hist = [hist; csvread('COTAHIST.1998petr4.csv')];
hist = [hist; csvread('COTAHIST.1999petr4.csv')];
hist = [hist; csvread('COTAHIST.2000petr4.csv')];
hist = [hist; csvread('COTAHIST.2001petr4.csv')];
hist = [hist; csvread('COTAHIST.2002petr4.csv')];
hist = [hist; csvread('COTAHIST.2003petr4.csv')];
hist = [hist; csvread('COTAHIST.2004petr4.csv')];
hist = [hist; csvread('COTAHIST.2005petr4.csv')];
hist = [hist; csvread('COTAHIST.2006petr4.csv')];
hist = [hist; csvread('COTAHIST.2007petr4.csv')];
hist = [hist; csvread('COTAHIST.2008petr4.csv')];

%ordena o vetor
hist = sortrows(hist,[1 2 3]);

% %corrige dividendos, rendimentos e juros sobre capital proprio
% 
% %Dividendo "neg�cios com" at� 20/03/1996
% d=20;m=03;a=1996;dividendo=5.1471;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 20/03/1997
% d=20;m=03;a=1997;dividendo=2;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 20/03/1997
% d=20;m=03;a=1997;dividendo=2;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 20/03/1997
% d=20;m=03;a=1997;dividendo=2.1263;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 24/03/1998
% d=24;m=03;a=1998;dividendo=2.07024895;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 24/03/1998
% d=24;m=03;a=1998;dividendo=3.20780922;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 24/03/1998
% d=24;m=03;a=1998;dividendo=0.20487159;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 24/03/1999
% d=24;m=03;a=1999;dividendo=1.8893;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 24/03/1999
% d=24;m=03;a=1999;dividendo=4.5515;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 23/03/2000
% d=23;m=03;a=2000;dividendo=3.58;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 23/03/2000
% d=23;m=03;a=2000;dividendo=0.14;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 23/03/2000
% d=23;m=03;a=2000;dividendo=4.27;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 23/03/2000
% d=23;m=03;a=2000;dividendo=0.17;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 23/03/2001
% d=23;m=03;a=2001;dividendo=1.67;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 23/03/2001
% d=23;m=03;a=2001;dividendo=0.57;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 23/03/2001
% d=23;m=03;a=2001;dividendo=0.07;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 29/06/2001
% d=29;m=06;a=2001;dividendo=1.02;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 03/08/2001
% d=03;m=08;a=2001;dividendo=0.03;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 22/03/2002
% d=22;m=03;a=2002;dividendo=0.89;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 22/03/2002
% d=22;m=03;a=2002;dividendo=1.30;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 22/03/2002
% d=22;m=03;a=2002;dividendo=0.09;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 12/11/2002
% d=12;m=11;a=2002;dividendo=1.00;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 27/03/2003
% d=27;m=03;a=2003;dividendo=1.00;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 27/03/2003
% d=27;m=03;a=2003;dividendo=0.06;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Divindendo "neg�cios com" at� 27/03/2003
% d=27;m=03;a=2003;dividendo=0.53;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 27/03/2003
% d=27;m=03;a=2003;dividendo=0.03;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 25/11/2003
% d=25;m=11;a=2003;dividendo=2.99;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 25/11/2003
% d=25;m=11;a=2003;dividendo=0.01;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 29/03/2004
% d=29;m=03;a=2004;dividendo=1.15;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 29/03/2004
% d=29;m=03;a=2004;dividendo=0.04;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 29/03/2004
% d=29;m=03;a=2004;dividendo=1.00;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 29/03/2004
% d=29;m=03;a=2004;dividendo=0.04;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 30/09/2004
% d=30;m=09;a=2004;dividendo=2.99;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 30/09/2004
% d=30;m=09;a=2004;dividendo=0.01;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% 
% %Dividendo "neg�cios com" at� 31/03/2005
% d=31;m=03;a=2005;dividendo=0.60;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 31/03/2005
% d=31;m=03;a=2005;dividendo=1.00;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 31/03/2005
% d=31;m=03;a=2005;dividendo=0.0681;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 30/06/2005
% d=30;m=06;a=2005;dividendo=2.00;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 30/06/2005
% d=30;m=06;a=2005;dividendo=0.0000000001;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 29/12/2005
% d=29;m=12;a=2005;dividendo=0.50;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 29/12/2005
% d=29;m=12;a=2005;dividendo=0.0000000001;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 03/04/2006
% d=03;m=04;a=2006;dividendo=0.25;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 03/04/2006
% d=03;m=04;a=2006;dividendo=0.35;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 03/04/2006
% d=03;m=04;a=2006;dividendo=0.0247;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 31/10/2006
% d=31;m=10;a=2006;dividendo=1.00;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 28/12/2006
% d=28;m=12;a=2006;dividendo=0.45;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 28/12/2006
% d=28;m=12;a=2006;dividendo=0.0000000001;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Dividendo "neg�cios com" at� 02/04/2007
% d=02;m=04;a=2007;dividendo=0.35;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Rendimento "neg�cios com" at� 02/04/2007
% d=02;m=04;a=2007;dividendo=0.0106;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 17/08/2007
% d=17;m=08;a=2007;dividendo=0.50;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;
% %Juros sobre capital pr�prio "neg�cios com" at� 05/10/2007
% d=05;m=10;a=2007;dividendo=0.50;
% i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
% hist(1:i,4:8) = hist(1:i,4:8) - dividendo;%corrige valores anteriores;


%corrige os desdobramentos
%fonte:
%http://www.bovespa.com.br/Empresas/InformacoesEmpresas/ExecutaAcaoConsulta
%EventosCorp.asp?codCVM=9512
%Acoes cotadas como "por mil",at� 21/06/2000, depois=>"por um"
d=21;m=06;a=2000;proporcao=1/1000;
i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
hist(1:i,4:8) = hist(1:i,4:8) * (proporcao);
%Grupamento "neg�cios com" at� 21/06/2000 em 100/1
d=21;m=06;a=2000;proporcao=100/1;
i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
hist(1:i,4:8) = hist(1:i,4:8) * (proporcao);
%Desdobramento "neg�cios com" at� 31/08/2005 em 300%
d=31;m=08;a=2005;proporcao=300;
i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
hist(1:i,4:8) = hist(1:i,4:8) / (1+(proporcao/100));
%Desdobramento "neg�cios com" at� 25/04/2008
d=25;m=04;a=2008;proporcao=100;
i=find(hist(:,3)==d & hist(:,2)==m & hist(:,1)==a);%identifica data
hist(1:i,4:8) = hist(1:i,4:8) / (1+(proporcao/100));


%ano | m�s | dia | abertura | m�xima | m�nima | m�dia | fechamento | volume
ano = hist(:,1);
mes = hist(:,2);
dia = hist(:,3);
abertura = hist(:,4);
maxima = hist(:,5);
minima = hist(:,6);
media = hist(:,7);
fechamento = hist(:,8);
volume = hist(:,9);

candle(maxima,minima,fechamento,abertura);


save 'petr4hist_sem_proventos.mat' ano mes dia abertura fechamento maxima minima media volume;