COMMANDS = regexp(fileread('PP01/S1_MVC_delt_links.txt'), '#', 'split');
if isempty(COMMANDS{end}); COMMANDS(end) = []; end  %end of file correction
DATA = char(COMMANDS(3));
A = jsondecode(DATA)