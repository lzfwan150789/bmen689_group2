% % clear all
% % I = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Testing images/Masks/061_floodfill.tif');
% % image = I(:, :, 1);
% % BW = imbinarize(image);
% % imshow(BW);
% clear all
% i = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Testing images/Masks/068_floodfill.tif');
% 
% i=i(:, :, 1);
% i = imbinarize(i);
% 
% f = figure;
% F = getframe(f);
% img = F.cdata;
% imwrite(i,'C:/Users/lenovo/Documents/Github/bmen689_group2/Testing images/Masks/068_floodfill.tif');
% close all
% % 
% % clear all
% % I = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Testing images/Masks/056_interior.tif');
% % % B = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Boundaries/6.tif');
% % % F = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Floodfill/6.tif');
% % image1 = I(:, :, 1);
% % % image2 = B(:, :, 1);
% % % image3 = F(:, :, 1);
% % % [stddev, median, corrcoeff, skew] = getFractalTexture(image);
% % 
% % % boxcount(image1)
% % 
% % % [n, r] = boxcount(image1)
% % % loglog(r, n,'bo-', r, (r/r(end)).^(-2), 'r--')
% % % xlabel('r')
% % % ylabel('n(r)')
% % % % legend('actual box-count','space-filling box-count');
% % 
% % % disp(['Fractal dimension, Df = ' num2str(mean(df(1:4))) ' +/- ' num2str(std(df(1:4)))]);
% % 
% % [fractal_texture_features] = getFractalTexture(image1);
% 
% 
% interior = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Testing images/Masks/066_interior.tif');
% features = getFractalTexture(interior);
% disp(features);
% 
