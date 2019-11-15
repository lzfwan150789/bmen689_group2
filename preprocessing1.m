close all
I = imread('C:/Users/lenovo/Downloads/Lung Training/LC008.tiff');
C1 = imcrop(I,[69 302 51 51]);
C2 = imadjust(C1); %enhance contrast - imadjust is built in func
level = graythresh(C2); %diff gray levels - used for imbinarize func
BW = imbinarize(C2,level); %generates black n white image - imbinarize is built in
%
BW(1,:) = 0; BW(:,1) = 0; BW (52,:) = 0; BW(:,52) = 0;
%
E = edge(BW, 'canny',[0.2,0.9]); %detects nodule edges from black n white image
%
se90 = strel('line',2,90);
se0 = strel('line',2,0);
E = imdilate(E,[se90 se0]);
%
se = strel('disk', 2);
fillE = imfill(E, 'holes'); %makes interior white

openE = imopen(fillE,se); %output 1: morph open %removes noise from the flood-filled image

interior = immultiply(C2, openE); %output 2: interior
% E = edge(openE,'log'); %output 3: edge
%canny, log, zerocross edge detection works
%that don't work: roberts, prewitt, sobel, approxcanny
% imshowpair(C1,E, 'montage');
% % C2 = imcrop(I,[380 280 51 51]);
% imshow(C2); %not specific enough
%
interior(1,:) = 0; interior(:,1) = 0; interior(52,:) = 0; interior(:,52) = 0;
binarymask0 = imbinarize(interior);
binarymask = medfilt2(binarymask0);
%
montage({C1,binarymask,interior},'Size',[1 3]);