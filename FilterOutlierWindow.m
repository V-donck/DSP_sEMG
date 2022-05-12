function [M_mV] = FilterOutlierWindow(M_mV,numDerivation, windowsize)
    [m,n]= size(M_mV);
    
    %take mean and standard deviation
    means = mean(M_mV);
    stds = std(M_mV);

    for j=1:n % kolommen
        for i= 1:m % rijen
            if(M_mV(i,j) < (means(j) - numDerivation*stds(j)) || M_mV(i,j) > (means(j) + numDerivation*stds(j)))
                if (i-fix(windowsize/2) < 1)
                    M_mV(i,j) = mean(M_mV(1:windowsize,j));
                elseif (i+fix(windowsize/2) > m)
                    M_mV(i,j) = mean(M_mV(m-windowsize:m,j));
                else                    
                    M_mV(i,j) = mean(M_mV(i-fix(windowsize/2) : i+fix(windowsize/2),j));
                end
            end
        end
    end
end