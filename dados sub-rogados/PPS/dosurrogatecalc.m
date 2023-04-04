function [dc,sig,dim,pe,perr]=dosurrogatecalc(y,alg,de,tau);

%function [dc,sig,dim,pe,perr]=dosurrogatecalc(data,alg,de,tau);
%
%calculate using algorithm alg 50 surrogates of data
%estimate correlation dimension (embeding dimension de and lag tau)
%return sig: the maximum deviation between data and surrogates 
%return dc: correlation dimension estimate for data
%return dim: dimension estimates for surrogates
%return pe: onestep nonlinear prediction error for data (optional)
%return perr: onestep nonlinear prediction error for surrogates (optional)

nout=nargout;

y=y(:);
z=surrogates(y,['alg',int2str(alg)],50);

for i=1:50,
[m,dc]=judd(z(:,i),de,tau);
dc=dc{1};
%  dc=dimbash(z(:,i),de,tau);
  dim{i}=dc;
end;
%dc=dimbash(y,de,tau);
[m,dc]=judd(y,de,tau);
dc=dc{1};
sig=dimdiff(dim,dc);
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

if nout>4,
    for i=1:50,
        perr(i)=prederr(z(:,i),de,tau);
    end;
    pe=prederr(y,de,tau);
end;
