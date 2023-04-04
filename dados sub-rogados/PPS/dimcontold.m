function [z,eps,dceps]=dimcontold(dim,nbin,sigma);

%function [z,eps,dc]=dimcont(dim,nvertbins,width)
%
%generate a probability distribution contour plot from a series of 
% correlation dimension estimates (stored as an array).
% nvertbins is the number of vertical bins to employ in the histogram
% (default 40), and width is the standard deviation of the Gaussian 
% spreading (default mean standard deviation of the data).

if nargin<3,
    sigma=[];
end;
if nargin<2,
    nbin=40;
end;

%number of bimbashes bashed
n=length(dim);

%sort out epsilon and dim limits
epsl=inf;dcl=inf;
epsh=-inf;dch=-inf;
epss=[];
for i=1:n,
    dc=dim{i};
    if ~isempty(dc),
        epsl=min(epsl,dc(1,1));
        epsh=max(epsh,dc(end,1));
        epss=[epss mean(diff(dc(:,1)))];
        dcl=min(dcl,min(dc(:,2)));
        dch=max(dch,max(dc(:,2)));
    end;
end;
epss=mean(epss);

%so, the epsilons are...
eps=epsl:epss:epsh;
%and the dc(eps) ranges ...
dceps=dcl:((dch-dcl)/(nbin-1)):dch;
dceps=dceps';

%interpolate, extrapolate, and matrices the dimbashes
dcs=[];
for i=1:n,
    dc=dim{i};
    if ~isempty(dc),
        dcs=[dcs; interp1(dc(:,1),dc(:,2),eps,'linear')];
    end;
end;

[n,neps]=size(dcs);

%compute sigm (if necessary)
if isempty(sigma),
    for i=1:neps,
        if any(~isnan(dcs(:,i))),
            sigma(i)=std(dcs(~isnan(dcs(:,i)),i));
        else,
            sigma(i)=0;
        end;
    end;
    sigma=mean(sigma)/5;
end;

%now, produce the pdf,
z=zeros(nbin,neps);
tally=zeros(1,neps);
for i=1:n,
    %compute the blurring of this dimbash
    zi=exp(( -(ones(nbin,1)*dcs(i,:)-dceps*ones(1,neps)).^2 )./sigma );
    %find any nans
    ind=find(all(~isnan(zi)));
    %increment and count
    z(:,ind)=z(:,ind)+zi(:,ind);
    tally(ind)=tally(ind)+1;
end;

%finally average it
%is not oberserving dc(eps) for some eps the same thing as observing no 
%dc(eps) for that eps!?
if 1,
    ind=find(tally>0);
    if length(ind)>0,
        z(:,ind)=z(:,ind)./(ones(nbin,1)*tally(ind));
    end;
else
    z=z./n;
end;

if nargout<1,
    contour(eps,dceps,z);
end;
