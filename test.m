clear all
I = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Interior/8.tif');
image = I(:, :, 1);
level = graythresh(image);
BW = imbinarize(image,level);
imshow(BW);