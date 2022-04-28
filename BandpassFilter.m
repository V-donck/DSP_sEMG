function [filtered] = BandpassFilter(header, no_outliers,lowCutoff, highCutoff, fs)
%BANDPASSFILTER Summary of this function goes here
%   Detailed explanation goes here
    [~,n]= size(no_outliers);
    for i=1:n
        filtered(:,i) = bandpass(no_outliers(:,n), [lowCutoff highCutoff], fs);
    end
end

