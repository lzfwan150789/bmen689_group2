clear all
I = imread('C:/Users/lenovo/Downloads/Lung Training/Interior/1.tif');
image = I(:, :, 1);
v = GLCM(image);
