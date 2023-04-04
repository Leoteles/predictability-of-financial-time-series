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
