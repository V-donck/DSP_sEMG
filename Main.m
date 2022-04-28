clear; clc;
%read header
[header, data] = readFile('PP01/S1_score_slow.txt');
resolution = header.resolution;

%transform raw data to mV
M_mV =  transformTo_mV(data,resolution);

%% 
%fft
F = fft(data,[],1);

% outlier removal
numDerivation = 1;
filtered = FilterOutlier(M_mV,numDerivation);

% bandbassfilter
fs = header.samplingRate;
[m,n]= size(filtered);
for i=1:n
    figure
    bandpass(filtered(:,n), [100 300], fs)
    title(header.column(i+2))
end

% % Savitzky-Golay filtering
% order = 20;
% framelen = 219;
% sgf = sgolayfilt(filtered(:,1),order,framelen);
% plot(filtered(:,1),':')
% hold on
% plot(sgf,'.-')
% legend('signal','sgolay')

