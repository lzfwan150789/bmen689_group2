%% Feature extraction generation
testingCSVInfo = 'testset_paths.csv';
testingPath = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\Testing images\Masks\'; 

t = readtable(testingCSVInfo);
labels = t{:, 4};

numSamples = size(labels,1);

training = [];

for i = 1:numSamples
    filename_boundary = [testingPath sprintf('%03d_boundary.tif', i)];
    filename_interior = [testingPath sprintf('%03d_interior.tif', i)];
    filename_binarymask = [testingPath sprintf('%03d_floodfill.tif', i)];
    
    boundary = imread(filename_boundary);
    interior = imread(filename_interior);
    binaryMask = imread(filename_binarymask);
    
    boundary = boundary(:,:,1);
    interior = interior(:,:,1);
    binaryMask = binaryMask(:,:,1);
    
    
    if ~islogical(boundary)
    boundary = imbinarize(boundary);
    end
    interior = im2uint8(interior);
    if ~islogical(binaryMask)
    binaryMask = imbinarize(binaryMask);
    end
    
    imwrite(boundary, filename_boundary);
    imwrite(interior, filename_interior);
    imwrite(binaryMask, filename_binarymask);
    
end

%% validate dimensions
for i = 1:numSamples
    filename_boundary = [testingPath sprintf('%03d_boundary.tif', i)];
    filename_interior = [testingPath sprintf('%03d_interior.tif', i)];
    filename_binarymask = [testingPath sprintf('%03d_floodfill.tif', i)];
    
    boundary = imread(filename_boundary);
    interior = imread(filename_interior);
    binaryMask = imread(filename_binarymask);
    fprintf("%d: %d %d %d\n", i, size(boundary,1), size(boundary,2), islogical(boundary)); 
    fprintf("%d: %d %d %d\n", i, size(binaryMask,1), size(binaryMask,2), islogical(binaryMask)); 
end
    
    