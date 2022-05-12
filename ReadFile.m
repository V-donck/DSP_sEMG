function [header,M] = ReadFile(path)
%read header
COMMANDS = regexp(fileread(path), '#', 'split');
if isempty(COMMANDS{end}); COMMANDS(end) = []; end  %end of file correction
DATA = char(COMMANDS(3));
A = jsondecode(DATA);
header = A.x00_07_80_3B_46_63;

%read raw data
M = readmatrix(path,'Range',4);
M(:,8)=[];
M(:,1:2)=[];
end