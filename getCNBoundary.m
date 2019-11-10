function [descriptors] = getCNBoundary(boundary)
    %Thresholding
thresholding = 0.025:0.075:0.95;

[coord(:,1) coord(:,2)] = find(img>0);

%network modeling
cn = cnMake(coord);

%CN evoluting with the thresholding selection
grade = thresholdingCN(cn,thresholding);

%grade normalizadion
grade = grade ./ length(grade);

%calculate mean and maximum
descriptors = mean(grade');
descriptors = [descriptors max(grade')];

end



%--------------------------------------------
function [CN] = cnMake(coord)

[nx ny] = size(coord);

y = pdist(coord,'euclidean');
CN = squareform(y);

CN = CN ./ max(CN(:));


%--------------------------------------------
function grade = thresholdingCN(cn,thre)

cnU = zeros(size(cn));
grade = [];

for x=1:length(thre)
    c = cn < thre(x);
    cnU(c) = 1;
    grade(x,:) = sum(cnU) - 1;
end