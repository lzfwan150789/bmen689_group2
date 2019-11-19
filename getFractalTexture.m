function [avg, stddev, median, corrcoeff, skew, k, mean_df, std_df] = getFractalTexture(interior)
    avg = mean2(interior);
    stddev = std2(interior); %2nd moment
    median = medfilt2(interior);
    corrcoeff = corr2(interior, median);
    skew = skewness(interior, 1, 'all'); %3rd moment
    k = kurtosis(interior, 1, 'all'); %4th moment
    
    [n, r] = boxcount(interior, 'slope');
    df = -diff(log(n))./diff(log(r));
    mean_df = mean(df(1:6));
    std_df = std(df(1:6));
end