close all
I = imread('C:/Users/lenovo/Downloads/Lung Training/LC002.tiff');
C1 = imcrop(I,[116 336 51 51]);
C2 = imadjust(C1); %enhance contrast - imadjust is built in func
level = graythresh(C2); %diff gray levels - used for imbinarize func
BW = imbinarize(C2,level); %generates black n white image - imbinarize is built in
E = edge(BW, 'canny', [0.2 0.9]); %detects nodule edges from black n white image

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

montage({C1,E,fillE,interior},'Size',[1 4])
title("Original Image and Enhanced Images using imadjust, hole fill, open")
