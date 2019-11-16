close all;


% initial parameters
pathBase = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\Training images\';
nameFile = 'LC001';
x_center = 120;
y_center = 325;
pathFile = [pathBase nameFile '.tiff'];
pathFileBackground = [pathBase nameFile '_background.tiff'];
shift = 36;
x = x_center - shift;
y = y_center - shift;

I = imread(pathFile);
C1 = imcrop(I,[x y 51 51]);
C2 = imadjust(C1); %enhance contrast - imadjust is built in func
level = graythresh(C2); %diff gray levels - used for imbinarize func
BW = imbinarize(C2,level); %generates black n white image - imbinarize is built in
E = edge(BW, 'canny', [0.2 0.9]); %detects nodule edges from black n white image
se = strel('disk', 2);
fillE = imfill(E, 'holes'); %makes interior white

interior = immultiply(C2, openE); 


%background
I_background = imread(pathFileBackground);
C1_background = imcrop(I_background,[x y 51 51]);
C2_background = imadjust(C1_background); %enhance contrast - imadjust is built in func
level = graythresh(C2_background); %diff gray levels - used for imbinarize func
BW_background = imbinarize(C2_background,level); %generates black n white image - imbinarize is built in

%substraction
C2_substraction = C2 - C2_background;
level = graythresh(C2_substraction); %diff gray levels - used for imbinarize func
BW_substraction = imbinarize(C2_substraction,level); %generates black n white image - imbinarize is built in
se = strel('disk', 2);
curr = BW_substraction;

for i = 1 : 5
    openE = imopen(curr,se); %output 1: morph open %removes noise from the flood-filled image
    closeE = imclose(openE,se);
    curr = closeE;
end

nrows = 4;
ncols = 5;
figure;
subplot(nrows ,ncols,1);
imshow(C1);
subplot(nrows ,ncols,2);
imshow(BW);
subplot(nrows ,ncols,3);            
imshow(E);
subplot(nrows ,ncols,4);
imshow(fillE);
subplot(nrows, ncols,5);
imshow(interior);
subplot(nrows, ncols,6);
imshow(C2_background);
subplot(nrows, ncols,7);
imshow(BW_background);
subplot(nrows, ncols,11);
imshow(C2_substraction);
subplot(nrows, ncols,12);
imshow(BW_substraction);
subplot(nrows, ncols,13);
imshow(openE);
subplot(nrows, ncols,14);
imshow(closeE);
suptitle('Original and enhanced images using imadjust hole fill open')
%montage({C1,E,fillE,interior},'Size',[1 4])
