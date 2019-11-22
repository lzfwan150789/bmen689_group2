close all
I = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Testing images/TIFF/005.tiff');
I = I(:, :, 1);
x = 197-26;
y = 290-26;
C1 = imcrop(I,[x y 51 51]);
C2 = imadjust(C1); %enhance contrast - imadjust is built in func
level = graythresh(C2); %diff gray levels - used for imbinarize func
BW = imbinarize(C2,level); %generates black n white image - imbinarize is built in
%
% BW(1,:) = 0; BW(:,1) = 0; BW (52,:) = 0; BW(:,52) = 0;
% % %
% E = edge(BW, 'Sobel'); %detects nodule edges from black n white image
% % 
% % W = gradientweight(E);

D = bwdist(~BW);
D2 = -D;

L = watershed(D2);
L(~BW) = 0;



rgb = label2rgb(L,'gray',[.5 .5 .5]);
rgb = rgb(:, :, 1);
imshow(C1);
imshow(rgb);
title('Watershed Transform')


[B,L] = bwboundaries(rgb,'noholes');

stats = regionprops(L,'Area','Centroid');

threshold = 0.94;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  
  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;
  
  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;
  
  % display the results
  metric_string = sprintf('%2.2f',metric);

  % mark objects above the threshold with a black circle
  if metric > threshold
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
  end
  
  text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
       'FontSize',14,'FontWeight','bold')
  
end

title(['Metrics closer to 1 indicate that ',...
       'the object is approximately round'])


% level2 = graythresh(rgb); %diff gray levels - used for imbinarize func
% rgb2 = imbinarize(rgb,level);
% rgb3 = (~rgb2);
% montage({C1,BW rgb2 rgb3},'Size',[1 4]);
% 
% [B,L, n, A] = bwboundaries(rgb2,'noholes');
% 
% stats = regionprops(L,'Area','Centroid');
% 
% threshold = 0.1;
% 
% % loop over the boundaries
% for k = 1:length(B)
% 
%   % obtain (X,Y) boundary coordinates corresponding to label 'k'
%   boundary = B{k};
% 
%   % compute a simple estimate of the object's perimeter
%   delta_sq = diff(boundary).^2;    
%   perimeter = sum(sqrt(sum(delta_sq,2)));
%   
%   % obtain the area calculation corresponding to label 'k'
%   area = stats(k).Area;
%   
%   % compute the roundness metric
%   metric = 4*pi*area/perimeter^2;
%   
%   % display the results
%   metric_string = sprintf('%2.2f',metric);
% 
%   % mark objects above the threshold with a black circle
%   if metric > threshold
%     centroid = stats(k).Centroid;
%     plot(centroid(1),centroid(2),'ko');
%   end
%   
%   text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
%        'FontSize',14,'FontWeight','bold')
%   
% end
% 
% title(['Metrics closer to 1 indicate that ',...
%        'the object is approximately round'])
% 
% 
% % wavelength = 2.^(0:5) * 3;
% % orientation = 0:45:135;
% % g = gabor(wavelength,orientation);
% % 
% % BW = single(BW);
% % 
% % gabormag = imgaborfilt(BW,g);
% % 
% % for i = 1:length(g)
% %     sigma = 0.5*g(i).Wavelength;
% %     gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),3*sigma); 
% % end
% % 
% % nrows = size(BW,1);
% % ncols = size(BW,2);
% % [X,Y] = meshgrid(1:ncols,1:nrows);
% % 
% % featureSet = cat(3,BW,gabormag,X,Y);
% % 
% % L2 = imsegkmeans(featureSet,10,'NormalizeInput',true);
% % C = labeloverlay(BW,L2);
% % imshow(C)
% % title('Labeled Image with Additional Pixel Information')
% 
% 
% % [L,Centers] = imsegkmeans(C2,5);
% % B = labeloverlay(C2,L);
% % imshow(B)
% % title('Labeled Image')
% % % %
% % imshow(E);
% % 
% % getContour = FindContour(BW);
% % 
% % figure; imshow(E);
% hold on; plot(getContour{1}(:, 1), getContour{1}(:, 2), 'r', 'LineWidth', 2);   % Left Lung