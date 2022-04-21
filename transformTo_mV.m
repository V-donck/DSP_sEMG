function [data_mV] = transformTo_mV(rawData,resolution)
    %this function changes the raw Data to data in mV
    VCC = 3; %3V is the operation voltage
    G_EMG = 1000 ;% the sensor gain
    for i=1:4
        EMG_V(:,i) = ((rawData(:,i)./(2.^resolution(i))-1/2).*VCC)./G_EMG;
    end
    data_mV = EMG_V *1000;
end

