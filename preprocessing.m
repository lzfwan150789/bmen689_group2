function [binaryMask, interior, boundary] = preprocessing(pathName)
    if (contains(pathName, 'LC'))
        img = imread(pathName);
        I = img(:,:,1);  % the tiff file is 512512x4 
        C1 = imcrop(I,[114 319 52 52]);
        C2 = imadjust(C1); %enhance contrast - imadjust is built in func
        level = graythresh(C2); %diff gray levels - used for imbinarize func
        BW = imbinarize(C2,level); %generates black n white image - imbinarize is built in
        BW(1,:) = 0; BW(:,1) = 0; BW(52,:) = 0; BW(:,52) = 0;
        boundary = edge(BW, 'canny',[0.2,0.9]); %detects nodule edges from black n white image
        se90 = strel('line',2,90);
        se0 = strel('line',2,0);
        boundary = imdilate(boundary,[se90 se0]);
        se = strel('disk', 2);
        fillE = imfill(boundary, 'holes'); %makes interior white
        openE = imopen(fillE,se); %output 1: morph open %removes noise from the flood-filled image
        interior = immultiply(C2, openE); %output 2: interior
        interior(1,:) = 0; interior(:,1) = 0; interior(52,:) = 0; interior(:,52) = 0;
        binarymask0 = imbinarize(interior);
        binaryMask = medfilt2(binarymask0);
        else
    end
end