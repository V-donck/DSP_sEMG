clear; clc;
%read header
COMMANDS = regexp(fileread('PP01/S1_MVC_delt_links.txt'), '#', 'split');
if isempty(COMMANDS{end}); COMMANDS(end) = []; end  %end of file correction
DATA = char(COMMANDS(3));
A = jsondecode(DATA);
resolution = A.x00_07_80_3B_46_63.resolution;

%read raw data
M = readmatrix('PP01/S1_MVC_delt_links.txt','Range',4);
% M(:,8)=[] % remove /n
M(:,1:2)  = []; %remove seq en DI

%transform raw data to mV
M_mV =  transformTo_mV(M,resolution);


%fft
F = fft(M,[],1);

% outlier removal
numDerivation = 1;
filtered = FilterOutlier(M_mV,numDerivation);

% bandbassfilter
fs = A.x00_07_80_3B_46_63.samplingRate;
[m,n]= size(filtered);
for i=1:n
    figure
    bandpass(filtered(:,n), [100 300], fs)
    title(A.x00_07_80_3B_46_63.column(i+2))
end

% % Savitzky-Golay filtering
% order = 20;
% framelen = 219;
% sgf = sgolayfilt(filtered(:,1),order,framelen);
% plot(filtered(:,1),':')
% hold on
% plot(sgf,'.-')
% legend('signal','sgolay')

