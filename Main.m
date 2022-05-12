clear; clc;
ploton = true;
%% to do:
%filter mean fout -> groter window pakken
%normalisation checken
% settings file exporteren
%app


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
if(ploton)
plot(M_mV(:,1));
title("standard");
end
%% Outlier removal
% outlier klopt nog niet helemaal
numDerivation = 1;
no_outliers = FilterOutlier(M_mV,numDerivation);
%hier plotten
if(ploton)
figure
plot(no_outliers(:,1));
title("no outliers");
end
%% processing Track A
%rectify data
no_outliers = abs(no_outliers);
% hier plots abs
if(ploton)
figure
plot(no_outliers(:,1));
title("abs");
figure
end

% bandbassfilter
[m,n]= size(no_outliers);
if ploton
for i=1:n
    %hier plotten bandpassfilters
    
    bandpass(no_outliers(:,i), [100 300], samplingRate);
    
    figure
   % plot(filtered(:,i));
    %title(header.column(i+2))
    
end
end

%cutoffrequency
lowCutoff = 100;
highCutoff = 300;
filtered = BandpassFilter(header, no_outliers,lowCutoff,highCutoff,samplingRate);
%hier plot cuttoffrequency
if (ploton)
figure
    plot(filtered(:,1));
    title("cuttof");
end
% Savitzky-Golay filtering
order = 20;
framelen = 219;
sgf = Savitzky_GolayFilter(no_outliers,order,framelen);

%% processing Track B
% Moving RMS
windowLength = 20;
overlap = windowLength -1; % default windowLength -1

movrmsExp = dsp.MovingRMS('WindowLength', windowLength,'OverlapLength',overlap);


y = abs(data(:,1));
plot(y)
hold on
rms = movrmsExp(y)';
plot(rms(windowLength:end)); % overlap verschijnselen rekening houden door vanaf windowsLenght te vertrekken anders neemt hij in het begin 0'en mee.
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
%plot normalised Data
if ploton
figure
plot(NormalisedData(:,1));
title("normalised");
end

%% Data export
fileId = fopen('settings.txt','w')
fprintf(fileId,"Settings used: \n StandardDeviation to remove outliers: %d",numDerivation);
fprintf(fileId,"Process track A:");
fprintf(fileId,"    Bandpassfilter: cuttoffrequencies: %d %d", lowfrequency,highfrequency);
fprintf(fileId,"    Savitzky-Golay filtering: ordel and framelen: %d %d", order,framelen);


writematrix(no_outliers,'Processed Data before normalization.csv','Delimiter',';')
writematrix(NormalisedData,'Processed Data after normalization.csv','Delimiter',';')



