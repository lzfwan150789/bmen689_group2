clear all
I = imbinarize(imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Boundaries/9.tif'));
image = I(:, :, 1);
v = Circularity(image);
