function [filtered] = Savitzky_GolayFilter(no_outliers,order, framelen)
%SAVITZKY_GOLAYFILTER Summary of this function goes here
%   Detailed explanation goes here
    [~,n]= size(no_outliers);
    for i=1:n
        filtered(:,i) = sgolayfilt(no_outliers(:,1),order,framelen);
    end
end

