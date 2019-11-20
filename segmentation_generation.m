%% Computer generated segmentation

baseFileCSVInfo = 'C:/Users/lenovo/Documents/Github/bmen689_group2/testset_paths.csv';
baseFilePath = 'C:/Users/lenovo/Documents/Github/bmen689_group2/Testing images/TIFF/'; 
outputMasksPath = 'C:\Users\lenovo\Documents\Github\bmen689_group2\Testing images\Computer generated masks\';

t = readtable(baseFileCSVInfo);
X = t{:, 1};
Y = t{:, 2};

numSamples = size(X,1);

training = [];

for i = 1:numSamples
    if (i >= 40 && i <= 71)
        baseFile = [baseFilePath sprintf('%03d.tiff', i)];
        I = imread(baseFile);
        
        x = X(i) - 26;
        y = Y(i) - 26;
        
        C1 = imcrop(I, [x, y, 51 51]);
        C2 = imadjust(C1);
        level = graythresh(C2);
        BW = imbinarize(C2,level);
        E = edge(BW, 'canny',[0.2,0.9]);
        se90 = strel('line',2,90);
        se0 = strel('line',2,0);
        E = imdilate(E,[se90 se0]);
        se = strel('disk', 2);
        fillE = imfill(E, 'holes');
        openE = imopen(fillE,se);
        interior = immultiply(C2, openE);
        
        binarymask0 = imbinarize(interior);
        binarymask1 = medfilt2(binarymask0);
        
        imshow(C1);
        
        f = figure;
        F = getframe(f);
        img = F.cdata;
        binaryMaskPath = [outputMasksPath sprintf('%03d_boundary.tiff', i)];
        interiorMaskPath = [outputMasksPath sprintf('%03d_interior.tiff', i)];
        floodfillMaskPath = [outputMasksPath sprintf('%03d_floodfill.tiff', i)];
        
        imwrite(binarymask1,binaryMaskPath);
        imwrite(interior,interiorMaskPath);
        imwrite(E, floodfillMaskPath);
              
    end
end

