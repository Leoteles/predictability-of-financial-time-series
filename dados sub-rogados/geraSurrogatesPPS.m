%z = geraSurrogatesPPS(y,n,m)
%  y = s�rie
%  Nsur = n�mero de s�ries sub-rogadas criadas
%  m = dimens�o de imers�o utilizada para se criar os sub-rogados
%  z = sub-rogados
function z = geraSurrogatesPPS(y,Nsur,m)

N = length(y);%Tamanho da s�rie sub-rogada

disp('Gerando par�metro rho para sub-rogados...');
%rho = findrhoquick(y,m,1);%,ptarget,Aopt)
%rho = findrho2(y,m,1);%,ptarget,Aopt)
%rho = findrho(y,m,1);%equivale a 0.5
%rho = findrho(y,m,1,0.8);
%rho = findrho(y,m,1,0.6);
%rho = findrho(y,m,1,0.5);

rho = findrho(y,m,1,0.6);
rho

disp('Gerando sub-rogados...');
tau = 1;
for i = 1:Nsur
    [yp,yi]=pps(y,m,tau,N,rho);
    z(:,i) = yp';
end

end

function rhomax=findrho(y,de,tau,target,Aopt);

%function rho=findrho(y,de,tau,ptarget,Aopt);
%
%find the optimal value of rho for the pls surrogate generation algorithm. 
%Uses the premise that the optimal value is that which produces surrogates 
%that have the greatest number of short sequences identical to the data.
%Now the number of short identical sequences, is related to the transition
%probability (i.e. the probability that we don't just follow the current
%state), if the transition probability p is 0.5 the the probability of a
%sequence of length 2 (the shortest allowable) p(1-p) is maximal. Lower the
%probability for longer sequences.
%
%if de is a vector then it is a vector of lags (min 0).
%
%computation is pseudo-analytic (certainly not stochastic)
%
%Aopt is optional
%
%Michael Small
%3/3/2005
%ensmall@polyu.edu.hk

%parameters


if nargin<5,
    Aopt=[];
end;
if nargin<4
    target=0.5;
end;
if nargin<3,
  tau=[];
end;
if nargin<2,
  de=[];
end;
if isempty(de),
  de=3;
end;
if isempty(tau),
  tau=1;
end;

y=y(:);
ny=length(y);
if length(de)>1,
    x=embed(y,de);
else,
    x=embed(y,de,tau);
end;
[de,n]=size(x);
if isempty(Aopt),
    Aopt=ones(1,de);
end;

%memory limitation 
%maxsize=3000;
maxsize=5000;
if n>maxsize,
    x=x(:,end+(1-maxsize:0));
    n=maxsize;
    disp('WARNING: too much data to handle in findrho3 ... truncating');
end;

%compute the switch probabilities for each point
%first, the L2-norm^2
dd=zeros(n,n);
for i=1:de, %loop on de and compute the distance.^2
    dd=dd+Aopt(i)*(ones(n,1)*x(i,:)-x(i,:)'*ones(1,n)).^2;
end;
dd=sqrt(dd);

%Vai diminuindo o intervalo de rho entre rholower e rhoupper at� encontrar
%o rho adequado (quando (rhou-rhol)<tolerancia)
tol=0.0000001;
rhou=std(y);%Inicialmente, rhou � grande (igual ao devio padrao)
rhol=rhou/2;%Inicialmente, rhol � a metade de rhou
pl=1;pm=1;
        pp=exp(-0.5.*dd/rhou);
        pu=sum(pp);
        pu=(pu-diag(pp)')./pu;
        pu=mean(pu);   
        pp=exp(-0.5.*dd/rhol);
        pl=sum(pp);
        pl=(pl-diag(pp)')./pl;
        pl=mean(pl);

while (rhou-rhol)>tol,
    if pl>target %both bounds too big
        pu=pl;
        rhou=rhol;
        rhol=rhol/2;
        %recompute pl
        pp=exp(-0.5.*dd/rhol);
        pl=sum(pp);
        pl=(pl-diag(pp)')./pl;
        pl=mean(pl);
        rhom=mean([rhol,rhou]);
    elseif pu<target, %or too small
        pl=pu;
        rhol=rhou;
        rhou=rhou*2;        
        %recompute pu
        pp=exp(-0.5.*dd/rhou);
        pu=sum(pp);
        pu=(pu-diag(pp)')./pu;
        pu=mean(pu);
        rhom=mean([rhol,rhou]);
    else, %dead on, so tighten them
        rhom=mean([rhol,rhou]);
        %compute pm
        pp=exp(-0.5.*dd/rhom);
        pm=sum(pp);
        pm=(pm-diag(pp)')./pm;
        pm=mean(pm);
        if pm<target,
            rhol=rhom;
            pl=pm;
        else,
            rhou=rhom;
            pu=pm;
        end;
    end;
    %disp([num2str(rhol),'<',num2str(rhom),'<',num2str(rhou)]);
end;
%disp(['Final prob=',num2str(pm)]);
rhomax=rhom;
end

function rhomax=findrhoquick(y,de,tau,target,Aopt);

%function rho=findrhoquick(y,de,tau,ptarget,Aopt);
%
%find the optimal value of rho for the pls surrogate generation algorithm.
%Uses the premise that the optimal value is that which produces surrogates
%that have the greatest number of short sequences identical to the data.
%Now the number of short identical sequences, is related to the transition
%probability (i.e. the probability that we don't just follow the current
%state), if the transition probability p is 0.5 the the probability of a
%sequence of length 2 (the shortest allowable) p(1-p) is maximal. Lower the
%probability for longer sequences.
%
%if de is a vector then it is a vector of lags (min 0).
%
%computation is pseudo-analytic (certainly not stochastic)
%
%Aopt is optional
%
%same as findrho, but quicker ... and a bit more approximate.
%
%Michael Small
%3/3/2005
%ensmall@polyu.edu.hk

%parameters


if nargin<5,
    Aopt=[];
end;
if nargin<4
    target=0.5;
end;
if nargin<3,
    tau=[];
end;
if nargin<2,
    de=[];
end;
if isempty(de),
    de=3;
end;
if isempty(tau),
    tau=1;
end;

y=y(:);
ny=length(y);
if length(de)>1,
    x=embed(y,de);
else,
    x=embed(y,de,tau);
end;
[de,n]=size(x);
if isempty(Aopt),
    Aopt=ones(1,de);
end;

%memory limitation
maxsize=1000;
step=floor(n/maxsize); %downsample
if n>maxsize,
    x=x(:,end+(1-step*maxsize:step:0));
    n=maxsize;
    %disp('WARNING: too much data to handle in findrhoquick ... truncating');
end;

%compute the switch probabilities for each point
%first, the L2-norm^2
dd=zeros(n,n);
for i=1:de, %loop on de and compute the distance.^2
    dd=dd+Aopt(i)*(ones(n,1)*x(i,:)-x(i,:)'*ones(1,n)).^2;
end;

tol=0.001;
rhou=std(y);
rhol=rhou/2;
pl=1;pm=1;
pp=exp(-0.5.*dd/rhou);
pu=sum(pp);
pu=(pu-diag(pp)')./pu;
pu=mean(pu);
pp=exp(-0.5.*dd/rhol);
pl=sum(pp);
pl=(pl-diag(pp)')./pl;
pl=mean(pl);

wait=waitbar(0,'finding rho...');
init=rhou-rhol;
while (rhou-rhol)>tol,
    if pl>target %both bounds too big
        pu=pl;
        rhou=rhol;
        rhol=rhol/2;
        %recompute pl
        pp=exp(-0.5.*dd/rhol);
        pl=sum(pp);
        pl=(pl-diag(pp)')./pl;
        pl=mean(pl);
        rhom=mean([rhol,rhou]);
    elseif pu<target, %or too small
        pl=pu;
        rhol=rhou;
        rhou=rhou*2;
        %recompute pu
        pp=exp(-0.5.*dd/rhou);
        pu=sum(pp);
        pu=(pu-diag(pp)')./pu;
        pu=mean(pu);
        rhom=mean([rhol,rhou]);
    else, %dead on, so tighten them
        rhom=mean([rhol,rhou]);
        %compute pm
        pp=exp(-0.5.*dd/rhom);
        pm=sum(pp);
        pm=(pm-diag(pp)')./pm;
        pm=mean(pm);
        if pm<target,
            rhol=rhom;
            pl=pm;
        else,
            rhou=rhom;
            pu=pm;
        end;
    end;
%    disp([num2str(rhol),'<',num2str(rhom),'<',num2str(rhou)]);
    waitbar(1-(rhou-rhol)/init,wait);
end;
close(wait);
disp(['Prob=',num2str(pm),' in findrhoquick.']);
rhomax=rhom;
end

function [x,y] = embed(z,v,w)

% [x,y] or x= embed(z,lags) or embed(z,dim,lag)
% embed z using given lags or dim and lag
% embed(z,dim,lag) == embed(z,[0:lag:lag*(dim-1)])
% negative entries of lags are into future
%
% If return is [x,y], then x is the positive lags and y the negative lags
% Order of rows in x and y the same as sort(lags)
%
% defaults:
%  dim = 3
%  lag = 1
%  lags = [0 1 2]; or [-1 lags] when two outputs and no negative lags
%
%Michael Small
%3/3/2005
%ensmall@polyu.edu.hk


if nargin==3
  v= 0:w:w*(v-1);
end;
if nargin==1
  v= [0 1 2];
end
if nargout==2 & min(v)>=0
  v= [-1 v];
end
lags= sort(v);

dim = length(lags);

[c,n] = size(z);
if c ~= 1
  z = z';
  [c,n] = size(z);
end
if c ~= 1
  error('Embed needs a vector as first arg.');
end

if n < lags(dim)
  error('Vector is too small to be embedded with the given lags');
end


w = lags(dim) - lags(1); 		% window
m = n - w; 				% Rows of x
t = (1:m)  + lags(dim); 		% embed times

x = zeros(dim,m);

for i=1:dim
  x(i,:) = z( t  -  lags(i) );
end

if nargout==2
  id= find(v<0);
  y= x(id,:);
  id= find(v>=0);
  x= x(id,:);
end;
end

function rhomax=findrho2(y,de,tau,pretty);

%function rho=findrho2(y,de,tau);
%
%find the optimal value of rho for the pls surrogate generation algorithm. 
%Uses the premise that the optimal value is that which produces surrogates 
%that have the greatest number of short sequences identical to the data.
%
%
% MS 25/5/01

%parameters
overdown=3;
precision=0.02; % i.e. 1%
stepsize=2;

if nargin<4,
    pretty=1;
end;
if nargin<3,
  tau=[];
end;
if nargin<2,
  de=[];
end;
if isempty(de),
  de=3;
end;
if isempty(tau),
  tau=1;
end;

y=y(:);
ny=length(y);

if pretty,
    figure;hold on;
end;

%phase 1 : start at a large value of rho, and work down to find the peak.
rhoi=std(y);
%[yp,yi]=pls(y,de,tau,ny,rhoi);
[yp,yi]=pps(y,de,tau,ny,rhoi);
di=findrho_di(yi,2);
dmax=0;
rhomax=0;
if pretty,
    plot(log(rhoi),di,'k*');drawnow;
end;
gonedown=0;
disp('phase 1: [rhoi di rho1 d1 gonedown]');
while gonedown<overdown,
  rho1=rhoi/stepsize;
  %[yp,yi]=pls(y,de,tau,ny,rho1);
  [yp,yi]=pps(y,de,tau,ny,rho1);
  d1=findrho_di(yi,2);
  if pretty,
      plot(log(rho1),d1,'k*');drawnow;
  end;
  if d1<dmax,
    gonedown=gonedown+1;
  else,
    gonedown=0;
    if d1>dmax,
      dmax=d1;
      rhomax=rho1;
      rhoH=rhoi;
      dH=di;
    end;
  end;
  if gonedown==1,
    dL=d1;
    rhoL=rho1;
  end;
  disp(sprintf('(%6.2g , %u) (%6.2g , %u)   # %u',rhoi,di,rho1,d1,gonedown));
  rhoi=rho1;
  di=d1;
  dii=di;
end;

%focus on peak.
if dH>dL,
  dL=dmax;
  rhoL=rhomax;
else
  dH=dmax;
  rhoH=rhomax;
end;

%phase 2: hone in on peak
disp('phase 2 : [rhoL rhoi rhoH dL di dH]');
while (rhoH-rhoL)/rhoL>precision,
  rhoi=(rhoH+rhoL)/2;
  %[yp,yi]=pls(y,de,tau,ny,rhoi);
  [yp,yi]=pps(y,de,tau,ny,rhoi);
  di=findrho_di(yi,2);
  if pretty,
      plot(log(rhoi),di,'k*');drawnow;
  end;
  disp(sprintf('%e %e %e (%u %u %u)',rhoL,rhoi,rhoH,dL,di,dH));
  if di>dmax,
    dmax=di;
    rhomax=rhoi;
  end;
  if dL<dH,
    dL=di;
    rhoL=rhoi;
  else
    dH=di;
    rhoH=rhoi;
  end;
end;

disp('Done.');
disp(['rho = ',num2str(rhomax)]);

if pretty,
    close;
end;
end

function di=findrho_di(yi,n)

if nargin<2,
   n=2;
end;

di=diff(find(diff(yi)~=1));
di=sum(di>n);
return;

if length(di)<1,
   di=length(yi)/2;
else
   di=mean(di);
end;
end