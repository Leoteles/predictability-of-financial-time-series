function modelcalc(n,datas);

% function modelcalc(n);
%
% do rbm model calculations (all of them) as a function of the length of data n
% for financial data
%

m=10;
de=8;
trace('off',1);

if nargin<2,
    datas=1:3;
end;

if nargin<1,
   n=1000;
end;

filename={'gold','djia','yen'};

v=genve(de);

for df=datas
    clear ddc surr dim;
    close all;
    y=load([filename{df},'-all.dat']);
    yp=load([filename{df},'-new.dat']);
    yp=yp(1:m);
    y=[y;yp];
    if length(y)>(n+m),
        y=y((end-n-m):end);
    else,
        n=length(y)-m-1;
    end;
    y=diff(log(y));
    yt=y(1:n);
    yp=y((n-de+1):(n+m));
    close all;
    rb_clear_globals;
%    timeseries(yt,yp,v,{'gaussian','tophat','morlet','wavelet'},'dl1(mss,a,deltas,dim_x)',4,3,150,5,0);
    timeseries(yt,yp,v,{'sigmoid'},'dl1(mss,a,deltas,dim_x)',4,3,150,5,1,'cln');
    [zt,zp,ep]=predict(yp);
%    save(['n',int2str(n),'-',filename{df},'-fit']);
%    savemodel(['n',int2str(n),'-',filename{df},'-model']);
    save(['n',int2str(n),'-',filename{df},'-nnfit']);
    savemodel(['n',int2str(n),'-',filename{df},'-nnmodel']);
end;
close all;
