function surrcalc(n,datas,nolinear);

% function surrcalc(n,datas,nolinear);
%
% do surrogate calculations (all of them) as a function of the length of data n
% for financial data
%
% optional datas=1:3 (but then the f*cking windows piece of sh*t runs out of memory)

if nargin<3,
    nolinear=0;
end;
if nargin<2,
    datas=1:3,
end;
if nargin<1,
   n=1000;
end;
nolinear=~(nolinear==0);

ns=50;  %number of surrogates
dcde=6; %dc and NLP de
sde=8; %PPS de

filename={'gold','djia','yen'};

for df=datas
    clear ddc surr dim;
    close all;
    y=load([filename{df},'-all.dat']);
    if length(y)>n,
        y=y((end-n):end);
    end;
    y=diff(log(y));
    close all;
if ~nolinear,    for alg=0:2
        [dc,sig,dim,pe,perr]=dosurrogatecalc(y,alg,dcde,1);
        save(['n',int2str(n),'-',filename{df},'-alg',int2str(alg)]);
end;    end;
   rho=findrho2(y,sde,1); %preference is sde=8;
    [dc,sig,dim,pe,perr]=ppscalc(y,dcde,sde,1,rho,ns);
    save(['n',int2str(n),'-',filename{df},'-pps']);

end;
close all;