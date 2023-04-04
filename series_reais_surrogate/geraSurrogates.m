function z = geraSurrogates(y,method,n,window,shift)

% z=surrogates(y,method,n,window,shift)  generate surrogate data
%
% generates n surrogates data sets from (the vector) y according to the
% method method. Surrogates are stored as columns of z.
%
% method can be one of the following;
%  'alg0'   -  algorithim 0 (shuffled) surrogates (ala Thieler)
%  'alg1'   -  algorithim 1 (phase shuffled) surrogates (Thieler)
%  'alg2'   -  algorithim 2 (AAFT) surrogates (Thieler)
%  'alg3'   -  "algorithim 2.5" (iterative AAFT/shuffled) surrogates
%                                             (ala Schreiber and Schmitz)
%  'cycl'   -  cycle shuffled surrogates (Thieler), split at peaks
% 'cycl-max' - cycle shuffled surrogates, split at peaks
% 'cycl-min' - cycle shuffled surrogates, split at troughs
% 'cycl-mid' - cycle shuffled surrogates, split at mean(y)
%  'nonl'   -  nonlinear radial basis surrogates.
%
% Only works for linear surrogates - ie all but the last approach.
% window is the window size for the peak/trough detection routine for the
% cycle shuffling routine.
%
%Michael Small
%3/3/2005
%ensmall@polyu.edu.hk


% Copyright (c) 1997 by Michael Small.
%
% Please see the copyright notice included in this distribution
% for full details.
%
%
% File   surrogates.m
%   $Id$
%
% Created by Michael Small (<watchman@>) on Tue May 20 1997
%
% $Log$

if nargin<5,
    shift=0;
end;
if nargin<4,
    window=[];
end;
if nargin<3
    n=1;
end;
if nargin<2
    method='alg0';
end;
if nargin<1
    disp('twit');
end;

y=y(:);
z=[];

if length(method)<4
    
    % method too short
    disp(['Don''t recognise method ''',method,''', giving up.']);
    
elseif strcmp(method,'alg0'),
    
    % algorithim 0
    for i=1:n
        z=[z shuffle(y)];
    end;
    
elseif strcmp(method,'alg1'),
    
    % algorithm 1
    for i=1:n
        z=[z surrogate(y,1)];
    end;
    
elseif strcmp(method,'alg2'),
    
    % algorithm 2
    for i=1:n
        z=[z surrogate(y,2)];
    end;
    
elseif strcmp(method,'alg3'),
    
    % algorithm 3
    for i=1:n
        z=[z alg2v2(y,1000)];
    end;
    
elseif strcmp(method(1:4),'cycl'),
    
    % cyclic surrogates
    % split where?
    if strcmp(method,'cycl-max') | strcmp(method,'cycl'),
        where='peak';
    elseif strcmp(method,'cycl-min');
        where='trough';
    elseif strcmp(method,'cycl-mid');
        where='centre';
    end;
    % save some time and do this now
    if strcmp(method,'cycl-mid'),
        p=[];pt=[];t=[];tt=[];
    else
        ly=length(y);
        if 0 & isempty(window),
            window=firstzero(y);
        end;
        
        [p,pt,t,tt]=peaktrough([y; y(1:min(ly,500))],window);
        %    [p,pt,t,tt]=extremum([y; y(1:min(ly,500))],[],[],[],1);
        % need to add a bit to make it the same length
        ind=find(pt<ly & tt<ly);
        p=p(ind);pt=pt(ind);t=t(ind);tt=tt(ind);
    end;
    % and do it
    for i=1:n
        z=[z shufflecycle(y,p,pt,t,tt,where,shift)];
    end;
    
elseif strcmp(method,'nonl'),
    
    % nonlinear radial basis surrogates
    disp('Not implemented - use surrogates96 or pl_run');
    
else
    
    %anything else
    disp(['Don''t recognise method ''',method,''', giving up.']);
    
end;

end

function y=shuffle(z)
% function y=shuffle(z)
%
% The ts z is shuffled randomly to result in the surrogate (but time
% uncorrelated ts) y.
%
%
%
%Michael Small
%3/3/2005
%ensmall@polyu.edu.hk
y=randn(size(z));
[y,i]=sort(y);
y=z(i);
end

function xp = surrogate(x,alg,rot)

% xp = surrogate(x,alg,rot)
% Surrogate data generator
% handles multichannel data (channels are columns)
% alg = algorithm 1 or 2 (default alg=1)
% rot = method of randomizing phases (default rot=1)
%     +ve = preserve correlation of channels 
%     -ve = destroy correlation of channels 
%       1 = add random phase
%       2 = replace phase
% if alg = -1 or -2, then apply enpoint correction
%
%
% NB: if using one channel then input vector MUST BE a column vector. MAS.
%
%Michael Small
%3/3/2005
%ensmall@polyu.edu.hk

% History
% Surrogate algorithm 2 ala James Theiler
% Written by Tanya Schmah
% Modified by Alistair Mees for Matlab 4
% Modified by Kevin Judd into a function
% Rewritten by Kevin Judd Aug95
% Modified by Michael Small

if nargin<3
  rot= 1;
end
if nargin<2
  alg= 1;
end

if (~any(abs(alg)==[1 2]))
    disp('Only know algorithms 1 and 2');
end


%figure
%subplot(211)
%plot(x)
%drawnow

[n,d] = size(x);
y= zeros(n,d);
%r tera mesma dist. de amplitudes(rank) que x
if abs(alg)==2
  % normal rank
  j= (1:n)';
  r= randn(size(x));
  [sr,ri]= sort(r);
  [sx,xi]= sort(x);
  [sxi,xii]= sort(xi);
  for k=1:d
    y(:,k)= sr(xii(:,k));
  end
else
  y= x;
end
m= mean(y);
y= y-m(ones(n,1),:);

% endpoint correction
if alg<0
  y0= y(1,:);
  y1= y(n,:);
  u= (0:n-1)'/(n-1);
  c= u*y1 + (1-u)*y0;
else
  c= 0;
end;

% fft
fy = fft(y-c);

% randomize phases (Must be same change each channel)
if rot>0
  phz= rand(n,1);
  phz= phz(:,ones(1,d));
else
  phz= rand(n,d);
end
if abs(rot)==1
  rot= exp(1) .^ (2*pi*sqrt(-1)*phz);
  fyp= fy .* rot;
else
  rot= exp(1) .^ (2*pi*sqrt(-1)*phz);
  fyp= abs(fy) .* rot;
end

%keyboard

% ifft
yp= real(ifft(fyp)) + c + m(ones(n,1),:);

if abs(alg)==2
  [syp,ypi] = sort(yp);
  [sypi,ypii] = sort(ypi);
  for k=1:d
    xp(:,k) = sx(ypii(:,k));
  end;
else
  xp= yp;
end;

%subplot(212)
%plot(xp)

return

%pause
%subplot(211)
%xf=filtfilt(ones(1,10)/10,1,x);  plot(xf);
%subplot(212)
%xpf=filtfilt(ones(1,10)/10,1,xp);plot(xpf);
end


