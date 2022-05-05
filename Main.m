clear; clc;
%read header
[header, data] = ReadFile('PP01/S1_score_slow.txt');
resolution = header.resolution;

%transform raw data to mV
M_mV =  transformTo_mV(data,resolution);

%% 
%fft
F = fft(data,[],1);

plot(abs(M_mV(:,1)));
figure
% outlier klopt nog niet helemaal
% outlier removal
numDerivation = 1;
no_outliers = FilterOutlier(M_mV,numDerivation);

%% processing Track A
%rectify data
no_outliers = abs(no_outliers);
% bandbassfilter
fs = header.samplingRate;
[m,n]= size(no_outliers);
% for i=1:n
%     figure
%     bandpass(no_outliers(:,n), [100 300], fs)
%     title(header.column(i+2))
% end

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


plot(filtered(:,1));
data1 = MVC(no_outliers,"S1");
figure
plot(data1(:,1));

%% Moving
% Moving RMS
windowLength = 20;
overlap = 15;

movrmsExp = dsp.MovingRMS('WindowLength', windowLength,'OverlapLength', overlap);

y = data(:,1);
x = 0:length(y);
plot(movrmsExp(y)');
