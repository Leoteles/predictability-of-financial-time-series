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










