[m,n]= size(M_mV);
numDerivation = 1;

for i=1:n
    means(i) = mean(M_mV(:,i));
    stds(i) = std(M_mV(:,i));
end
for i=1:m
    outlieronrow = false;
    for j= 1:n
        if(M_mV(i,j) < (means(j) - numDerivation*stds(j)) || M_mV(i,j) > (mean(j) + numDerivation*stds(j)))
            outlieronrow = true;
        end
    end

    if ~outlieronrow
        filtered(i,:) = M_mV(i,:);
    end
end
disp(filtered)