function [v,lag]=calculaAMI(x,y,lag)
%Usage: [v,lag]=ami(x,y,lag)
%
% Calculates the mutual average information of x and y with a possible lag.
% 
%
% v is the average mutual information. (relative units see below)
% x & y is the time series. (column vectors)
% lag is a vector of time lags.
%
% (A peak in V for lag>0 means y is leading x.)
% 
% v is given as how many bits x and y has in common relative to how 
% many bits is needed for the internally binned representation of x or y.
% This is done to make the result close to independent bin size.
%
% For optimal binning: transform x and y into percentiles prior to running
% ami. See e.g. boxpdf at matlab central.
%
% http://www.imt.liu.se/~magnus/cca/tutorial/node16.html
%
% Aslak Grinsted feb2006 
% http://www.glaciology.net
% (Inspired by mai.m by Alexandros Leontitsis)

if nargin==0
    error('You should provide a time series.');
end

if nargin<2
    y=x;
end


x=x(:);
y=y(:);
n=length(x);
if n~=length(y)
    error('x and y should be same length.');
end

if nargin<3
    lag=0;
    if nargin<2
        lag=0:min(n/2-1,20); %compatible with mai.m
    end
else
    lag=round(lag);
end


% The mutual average information
%Coloca os vetores x e y no intervalo entre 0 e 1 (somando o valor mínimo
% e dividindo pelo valor máximo)
x=x-min(x);   
x=x*(1-eps)/max(x);
y=y-min(y);
y=y*(1-eps)/max(y);

v=zeros(size(lag));
lastbins=nan;
%para cada atraso, ...
for ii=1:length(lag)

    abslag=abs(lag(ii));
    
    %Número de bins
    % Define the number of bins
    bins=floor(1+log2(n-abslag)+0.5);%as mai.m
    
    %Primeiro, faz com que os valores dos vetores seja de 0 ao número de
    %bins. Depois, arredonda abaixo e soma um. O resultado é uma
    %transformação dos vetores em números inteiros de 1 a bins.
    if bins~=lastbins
        binx=floor(x*bins)+1;
        biny=floor(y*bins)+1;
    end
    lastbins=bins;

    Pxy=zeros(bins);
    %Percorre o vetor até n-lag(i)
	for jj=1:n-abslag
        kk=jj+abslag;
        %Se o lag é negativo, inverte jj e kk de posição
        if lag(ii)<0 
            temp=jj;jj=kk;kk=temp;%swap
        end
        %Incrementa a frequencia Pxy em 1 dos respectivos kk e jj. kk e jj
        %já contem o número correspondente ao seu bin. Ex.: Se a série tem
        %y(t) = 12 e y(t-1)=8 e lag = 1, então kk=12 e jj=8  e
        %Pxy(12,8)==Pxy(12,8) + 1; Todos os elementos dos vetores já foram
        %transformados em números inteiros no intervalo [1 max(vetor)]
        Pxy(binx(kk),biny(jj))=Pxy(binx(kk),biny(jj))+1;
    end
    %Divide pelo total de elementos
    Pxy=Pxy/(n-abslag);
    %Soma um quase nada
    Pxy=Pxy+eps; %avoid division and log of zero
    %Obtem as distribuições marginais
    Px=sum(Pxy,2);
    Py=sum(Pxy,1);
    
    %Calcula a AMI
    q=Pxy./(Px*Py);
    q=Pxy.*log2(q);
    
    v(ii)=sum(q(:))/log2(bins); %log2bins is what you get if x=y.
%   Equivalent formulation (slightly slower) 
%     Hx=-sum(Px.*log2(Px));
%     Hy=-sum(Py.*log2(Py));
%     Hxy=-sum(Pxy(:).*log2(Pxy(:)));
%     v(ii)=Hx+Hy-Hxy;
end
