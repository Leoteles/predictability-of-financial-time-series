function fatal(condition,message)

% fatal(condition,message) or fatal(message)
% if condtion is true, then do error with message

if nargin<1
  message= 'An unspecified error';
  condition= 1;
end
if nargin==1
  message= condition;
  condition= 1;
end
if condition
  error(message)
end