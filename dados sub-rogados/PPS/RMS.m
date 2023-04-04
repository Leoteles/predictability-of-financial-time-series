function e=RMS(y);

% function e=RMS(y);
%
% e is the l2-norm of row vector y, for a n-by-m matrix e is the n-by-1 column 
% vector which is the l2-norm of the n rows of y.;

[a,b]=size(y);

if b==1 
  e=abs(y);
else
  if a==1
    y=y';
  end;
  e=sqrt(mean(y'.^2))';
end;