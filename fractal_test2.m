I = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Interior/8.tif');
BW = imbinarize(imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Floodfill/8.tif'));
I = I(:, :, 1);
BW = BW(:, :, 1);
% s = regionprops(BW,I,{'Centroid','WeightedCentroid'});
% imshow(I)
% title('Weighted (red) and Unweighted (blue) Centroids'); 
% hold on
% numObj = numel(s);
% for k = 1 : numObj
%     plot(s(k).WeightedCentroid(1), s(k).WeightedCentroid(2), 'r*')
%     plot(s(k).Centroid(1), s(k).Centroid(2), 'bo')
% end
% hold off
s = regionprops(BW,I,{'Centroid','PixelValues','BoundingBox'});
imshow(I)
title('Standard Deviation of Regions')
hold on
for k = 1 : numObj
    s(k).StandardDeviation = std(double(s(k).PixelValues));
    text(s(k).Centroid(1),s(k).Centroid(2), ...
        sprintf('%2.1f', s(k).StandardDeviation), ...
        'EdgeColor','b','Color','r');
end
hold off