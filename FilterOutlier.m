function [M_mV] = FilterOutlier(M_mV,numDerivation)
    [m,n]= size(M_mV);
    
    %take mean and standard deviation
    means = mean(M_mV);
    stds = std(M_mV);
    for j=1:n % kolommen
        for i= 1:m % rijen
            if(M_mV(i,j) < (means(j) - numDerivation*stds(j)) || M_mV(i,j) > (means(j) + numDerivation*stds(j)))
                if(i==1)
                    M_mV(i,j) = M_mV(i+1,j);
                elseif (i ==m)
                    M_mV(i,j) = M_mV(i-1,j);
                else
                    M_mV(i,j) = mean([M_mV(i-1,j), M_mV(i+1,j)]);
                end
                %M_mV(i,j) = 0;
            end
        end
    end
end

