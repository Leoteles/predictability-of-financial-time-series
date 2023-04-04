function dimplot(file,de,tau,lt,lt2);
  
%function dimplot(file,d,lag,lt1,lt2)
%function dimplot(dc)
%
%plot the correlation dimension curve (ala Kevin) for
%dc=dimbash(...) or for dimplot(file,d,lag)
%
% lt1 and lt2 are plto strings specifiying the4 type of line to draw
%
%default: file='test'
%

na=nargin;
if na<1,
  file=[];
end;
if na<2,
  de=[];
end;
if na<3,
  tau=[];
end;

if isempty(file),
  file='test';
end;

if na<5,
lt='y';
lt2='g:';
end;
%if data is given
if ~isstr(file),
  axes(gca);
  oldhold=ishold; 
  hold on;
  plot(file(:,1),file(:,2),lt);
  plot(file(:,1),file(:,3),lt2);
  plot(file(:,1),file(:,4),lt2);
  xlabel('log(\epsilon_0)');ylabel('d_c(\epsilon_0)');
  if ~oldhold,
    hold off;
  end;
else,

%if no de is given
if isempty(de),
  %find all des;
end;

%if no tau is given
if isempty(tau),
  %find all taus;
end;

%do it for 'em all
axes(gca);
oldhold=ishold;
hold on;
for d=de,
  for t=tau,
    if t>1,
      dc=xload([file,'.',int2str(d),'.',int2str(t),'.xfit'],'off');
    else,
      dc=xload([file,'.',int2str(d),'.xfit'],'off');
    end;
    dimplot(dc,[],[],lt,lt2);
  end;
end;
  if ~oldhold,
    hold off;
  end;
end;
