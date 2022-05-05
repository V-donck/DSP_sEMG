clear; clc;
%% Load Raw Data
%read file
[header, data] = ReadFile('PP01/S1_score_slow.txt');
Date = header.date;
time = header.time;
samplingRate = header.samplingRate;
resolution = header.resolution;

%transform raw data to mV
M_mV =  transformTo_mV(data,resolution);

%% FFT Analysis
%fft
F = fft(data,[],1);

%hier plotten voor testen outlier removal
plot(M_mV(:,1));
title("standard");
%% Outlier removal
% outlier klopt nog niet helemaal
numDerivation = 1;
no_outliers = FilterOutlier(M_mV,numDerivation);
%hier plotten
figure
plot(no_outliers(:,1));
title("no outliers");

%% processing Track A
%rectify data
no_outliers = abs(no_outliers);
% hier plots abs
figure
plot(no_outliers(:,1));
title("abs");

% bandbassfilter
[m,n]= size(no_outliers);
for i=1:n
    %hier plotten bandpassfilters
    figure
    filtered(:,i) = bandpass(no_outliers(:,i), [100 300], samplingRate);
    plot(filtered(:,i));
    title(header.column(i+2))
    
end

%cutoffrequenty
lowCutoff = 100;
highCutoff = 300;
filtered = BandpassFilter(header, no_outliers,lowCutoff,highCutoff,samplingRate);

% Savitzky-Golay filtering
order = 20;
framelen = 219;
sgf = Savitzky_GolayFilter(no_outliers,order,framelen);

%% processing Track B
% Moving RMS
windowLength = 100;
overlap = 10;

% movrmsExp = dsp.MovingRMS('WindowLength', windowLength,'OverlapLength', overlap);
% 
% Fs = header.samplingRate;
% scope  = timescope('SampleRate',[Fs,Fs,Fs/(20-15),Fs],...
%     'TimeSpanOverrunAction','Scroll',...
%     'TimeSpanSource','Property',...
%     'TimeSpan',100,...
%     'ShowGrid',true,...
%     'YLimits',[-1.0 5.5]);
% y = data(:,1);
% x = 0:length(y);
% plot(x, movrmsExp(y));
%% MVC Normalisation
NormalisedData = MVC(no_outliers,"S1");