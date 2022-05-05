function [M_mV] = FilterOutlier(M_mV,numDerivation)
    [m,n]= size(M_mV);
    
    for i=1:n
        means(i) = mean(M_mV(:,i))
        stds(i) = std(M_mV(:,i))
    end
    for j=1:n % kolommen
        for i= 1:m % rijen
            if(M_mV(i,j) < (means(j) - numDerivation*stds(j)) || M_mV(i,j) > (means(j) + numDerivation*stds(j)))
                % M_mV(i,j) = mean([M_mV(i-1,j), M_mV(i+1,j)]);
                M_mV(i,j) = 0;
            end
        end
    end
end

