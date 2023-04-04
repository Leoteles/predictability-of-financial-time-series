function [ddc,sig,dim,pe,perr]=ppscalc(y,dcde,sde,lg,rh,n);
% function [ddc,sig,dim,pe,perr]=ppscalc(y,dcde,sde,lg,rh,n);
%
%calculate using PPS algorithm n surrogates of y
%sde and rh are the PPS alg. embedding dimension and noise radius
%estimate correlation dimension (embeding dimension dcde and lag lg)
%return sig: the maximum deviation between data and surrogates 
%return dc: correlation dimension estimate for data
%return dim: dimension estimates for surrogates
%return pe: onestep nonlinear prediction error for data (optional)
%return perr: onestep nonlinear prediction error for surrogates (optional)


nout=nargout;

if nargin<5,
  n=30;
end;

f1=gcf;
set(f1,'Position',[703 229 560 420]);
f2=figure;
set(f2,'Position',[21 711 938 228]);
subplot(211);
plot(y);
subplot(212);

%dc=dimbash(y,dcde,lg);
[m,dc]=judd(y,dcde,lg);
dc=dc{1};
ddc=dc;
figure(f1);
if max(size(dc))>1,
semilogx(dc(1,:),dc(2,:),'k');
end;
hold on;
if nout>4,
    pe=prederr(y,dcde,lg);
end;

for i=1:n,
  [yp,xp]=pls(y,sde,lg,length(y),rh);
  figure(f2);
  plot(yp);
  title(['d_e=',int2str(dcde),', \tau=',int2str(lg),' \rho=',num2str(rh),', n=',int2str(length(y))]);
  figure(f1);
  surr{i}=yp;
 % dc=dimbash(yp,dcde,lg);
  [m,dc]=judd(yp,dcde,lg);
  dc=dc{1};
dim{i}=dc;figure(f1);
if max(size(dc))>1,
  semilogx(dc(1,:),dc(2,:),'g');
end;
title(['Done surrogate ',int2str(i),' of ',int2str(n),'.']);
  hold on;
  if nout>4
      perr(i)=prederr(yp,dcde,lg); 
  end;
  
end;
figure(2);
close

sig=dimdiff(dim,ddc);
if ~isempty(sig),
   sig=sig(sig(:,2)>15,:);
   if ~isempty(sig),
      sig=max((sig(:,3)));
   else,
      sig=nan;
   end;
else,
   sig=nan;
end;

