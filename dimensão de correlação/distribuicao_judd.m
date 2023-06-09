close all;
clear all;
clc;

carrega_series

serie = logistica;
clearvars ** -except serie

m = 5;%Dimens�o de imers�o

%De acordo com os nomes de variaveis da funcao judd.m
y = serie;
dt=2;% dt is the topological dimension of the set (default, 2)
nt=0;% nt is the number of temporal neighbours to excluse (default 0)
nbins=200;% nbins number of bins of interpoint distances (default 200)
tau=1;% tau embedding lag (default 1)

% compute correlation dimension (dc) using Judd's algorithm

%parameters
maxn=1000; %maximum number of points to use
pretty=0;  %pictures?
noccup=20; % minimum number of occupied bins to fit to.
maxci=0.9; % upperbound on correlation integral
errorbound=0.01; %maximum fitting error to blindly accept

%data
y=y(:);
n=length(y);

%rescale to mean=0 & std=1
y=y-mean(y);
y=y./std(y);

%init
d=[];k=[];s=[];b=[];cim=[];

%get bins : distributed logarithmically
binl=log(min(diff(unique(y))));   %smallest diff
binh=log(max(m)*(max(y)-min(y)));%seems to work
binstep=(binh-binl)./(nbins-1);
bins=binl:binstep:binh;
bins=exp(bins);


%disp
disp(['Judd''s Algorithm (n=',int2str(n),'; tau=',int2str(tau),'; nbins=',int2str(nbins),'; nt=',int2str(nt),'; dt=',int2str(dt),')']);

%get distributions of interpoint distances
%distribution of interpoint distances
%compute distrib. from maxn ref. pairs of points
np=interpoint(y,m,tau,bins(1:(end-1)),maxn.^2,nt);
%number of interpoint distances
ntot=maxn.^2;
disp(['Using ',int2str(maxn),'^2 reference points (ntot=',int2str(ntot),')']);

%At� este ponto, a rotina obteve a dist�ncia interpontos np;
%um cumsum nessas dist�ncias fornece a integral de correla��o


disp(['Fitting for m=',int2str(m)]);

%compute correlation integral
ci=cumsum(np'./ntot);
ind=find(ci<maxci);%Indice dos ci's utilizados (menores que 0.9)

dc=[];eps0=[];errs=[];


%ci � sempre crescente at� 1. Depois fica
%constante. Deve-se pegar o m�ximo valor antes de isso acontecer, j� que o
%interesse � em epsilon pequeno. O while abaixo roda desde que pelo menos
%20 bins atendam essa condi��o. A cada itera��o o epsilon0 � diminu�do, o
%que corresponde a reduzir os bins mais a direita, um a um.
while(sum(diff(ci(ind))>0)>noccup), %keep going so long as noccup
    %bins are occupied
    %Garante que pelo menos nooccup(20) bins ser�o ocupados
    %Define parametros da otimiza��o para o modelo, fit to find D and a
    opt=optimset('TolX',1e-6,'TolFun',1e-6,'display','notify',...
        'MaxFunEvals',10000,...
        'MaxIter',10000);	%   'LevenbergMarquardt','on',
    xi=[m 1]; %initial guess
    %judd_da retorna o erro rms ao se ajustar epsilon a ci usando 'd' e 'a'
    xi=fminsearch('judd_da',xi,opt,bins(ind),ci(ind)); % do it once (to est. d)
    %xi tem os parametros d e a
    %Otimiza��o de dois passos como sugerida por Judd na pag 224 de an
    %improved estitmator of dimension
    xi=[xi(1) xi(2) zeros(1,dt-1)];
    [xi,gfit,exitflag]=fminsearch('judd_da',xi,opt,bins(ind),ci(ind)); % do it again
    %xi(1) � a dim de corr.
    %xi(2:end) = par�metros estimados
    %gfit � o valor da fun��o no ponto m�nimo. Mas a fun��o mede o erro RMS de
    %regress�o. Portanto, gfit � o erro RMS do ajuste de curva.
    
    %compute normalised error
    gfit=gfit./sum(ci(ind).^2);
    
    %should we give up?
    if ~exitflag,
        %fitting didn't converge .. so quit
        disp('WARNING: Fitting failed to converge.');
        break;
    end;
    
    %was it good enough? Guarda o resultado
    if gfit<errorbound & xi(1)>0,
        dc=[dc xi(1)];
        eps0=[eps0 bins(ind(end))];
        errs=[errs gfit];
    end;
    
    ind(end)=[];
end;

%normalisation factor for the bins
bbox=(max(y)-min(y))*sqrt(m);%diag of bounding box in R^m

%remember the gki and ss
cim=[cim;ci];
dcm=[eps0./bbox;dc;errs];


%Mostra a dimens�o em fun��o do epsilon0
%[m,dcm,eps0,cim]
epsilon0 = dcm(1,:);
d2 = dcm(2,:);
erro = dcm(3,:);
figure;
semilogx(epsilon0,d2);
xlabel('\epsilon_0');
ylabel('Dimens�o de correla��o');
grid on;
print -depsc 'fig_dimensao_judd';

%Mostra o erro em fun��o do epsilon0
figure;
semilogx(epsilon0,erro);
grid on;
xlabel('\epsilon_0');
ylabel('Erro RMS da estimativa de distribui��o de C(\epsilon)');
print -depsc 'fig_erro_judd';

% % %Mostra erro e dimens�o no mesmo gr�fico em loglog
% % figure;
% % loglog(epsilon0,d2);
% % grid on;
% % hold on;
% % loglog(epsilon0,erro);
% % hold off;




%mostra um exemplo de estima��o de distribui��o
ind=find(ci<maxci);%Indice dos ci's utilizados (menores que 0.9)

ind = 1:181;

%Define parametros da otimiza��o para o modelo, fit to find D and a
opt=optimset('TolX',1e-6,'TolFun',1e-6,'display','notify',...
    'MaxFunEvals',10000,...
    'MaxIter',10000);	%   'LevenbergMarquardt','on',
xi=[m 1]; %initial guess
%judd_da retorna o erro rms ao se ajustar epsilon a ci usando 'd' e 'a'
xi=fminsearch('judd_da',xi,opt,bins(ind),ci(ind)); % do it once (to est. d)
%xi tem os parametros d e a
%Otimiza��o de dois passos como sugerida por Judd na pag 224 de an
%improved estitmator of dimension
xi=[xi(1) xi(2) zeros(1,dt-1)];
[xi,gfit,exitflag]=fminsearch('judd_da',xi,opt,bins(ind),ci(ind)); % do it again
%xi(1) � a dim de corr.
%xi(2:end) = par�metros estimados
%gfit � o valor da fun��o no ponto m�nimo. Mas a fun��o mede o erro RMS de
%regress�o. Portanto, gfit � o erro RMS do ajuste de curva.

figure;
semilogx(bins(ind),ci(ind),'.b');
hold on;
tfit=judd_fit(xi(1),xi(2:end),bins(ind));
semilogx(bins(ind),tfit,'--r');
hold off;
grid minor;
xlabel('\epsilon');
s1 = sprintf('C(\\epsilon)   m = %g', m);
ylabel(s1);
legend('C(\epsilon)','Distribui��o estimada','Location','NorthWest');
s2 = sprintf('Dimens�o estimada: %g', xi(1));
annotation('textbox',  [.15 .6 .3 .1],'string',s2,'BackgroundColor',[1 1 1]);
print -depsc 'fig_dist_judd';
