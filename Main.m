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
no_outliers = FilterOutlier(M_mV,numDerivation);

% bandbassfilter
fs = header.samplingRate;
lowCutoff = 100;
highCutoff = 300;
filtered = BandpassFilter(header, no_outliers,lowCutoff,highCutoff,fs);

% Savitzky-Golay filtering
order = 20;
framelen = 219;
sgf = Savitzky_GolayFilter(no_outliers,order,framelen);
% plot(no_outliers(:,1),':')
% hold on
% plot(sgf(:,1),'.-')
% legend('signal','sgolay')

% Moving RMS
windowLength = 100;
overlap = 10;

movrmsExp = dsp.MovingRMS('WindowLength', windowLength,'OverlapLength', overlap);

Fs = header.samplingRate;
scope  = timescope('SampleRate',[Fs,Fs,Fs/(20-15),Fs],...
    'TimeSpanOverrunAction','Scroll',...
    'TimeSpanSource','Property',...
    'TimeSpan',100,...
    'ShowGrid',true,...
    'YLimits',[-1.0 5.5]);
y = data(:,1);
x = 0:length(y);
plot(x, movrmsExp(y));

