function y=shuffle(z);

% function y=shuffle(z);
%
% The ts z is shuffled randomly to result in the surrogate (but time 
% uncorrelated ts) y.
%
% 

y=randn(size(z));
[y,i]=sort(y);
y=z(i);





