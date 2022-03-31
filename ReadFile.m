
%read header
COMMANDS = regexp(fileread('PP01/S1_MVC_delt_links.txt'), '#', 'split');
if isempty(COMMANDS{end}); COMMANDS(end) = []; end  %end of file correction
DATA = char(COMMANDS(3));
A = jsondecode(DATA);
Resolution = A.x00_07_80_3B_46_63.resolution;

%read raw data
M = readmatrix('PP01/S1_MVC_delt_links.txt','Range',4);
M(:,8)=[]