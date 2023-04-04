function [bins,np]=corrintMOD(y,de,tau,nbins,nt,pretty)

% function [eps,cn]=corrint(y,de,tau,nbins,nt);
%
% compute correlation integral, nothing more.
%
%
%Michael Small
%3/3/2005

nout=nargout;

tau=1;
de=2;


nt=1;
nde=length(de);

%parameters
maxn=2000; %maximum number of points to use
hcmin=0.25; %absolute minimum bandwidth
hcmax=3;   %absolute maximum bandwidth

%data
y=y(:);
n=length(y);

%rescale to mean=0 & std=1
% % % y=y-mean(y);
% % % y=y./std(y);

%init
m=[];
d=[];
k=[];
s=[];
b=[];
gkim=[];
ssm=[];

nbins=200;
% % % %get bins : distributed logarithmically
% % % binl=log(min(diff(unique(y))))-1;   %smallest diff 
% % % %if isempty(binl),binl=eps;end;  %just in-case
% % % binh=log(max(de)*(max(y)-min(y)))+1;%seems to work
% % % %if isnan(binh),binh=log(max(de)*max(y))+1;end; %just in-case 
% % % binstep=(binh-binl)./(nbins-1);
% % % bins=binl:binstep:binh;
% % % bins=exp(bins);

bins = 0.1 * (max(y)-min(y)) * linspace(0.05,1,20)';


%disp
disp(['Correlation Integral (n=',int2str(n),'; tau=',int2str(tau),'; nbins=',int2str(nbins),'; nt=',int2str(nt),')']);
disp(['hcmin=',num2str(hcmin),' & hcmax=',num2str(hcmax)]);
disp('Computing histogram');

%estimate distribution of interpoint distances 
disp('Using all points');
%distribution of interpoint distances
%compute distrib. using all points
np=interpoint(y,de,tau,bins(1:(end-1)),0,nt);

