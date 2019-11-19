%% Feature extraction generation

testingCSVInfo = 'testset_paths.csv';
testingPath = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\Testing images\Masks\'; 
outputPathTrainingSet = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\trainingSet.csv';

t = readtable(testingCSVInfo);
labels = t(:, 4);

numSamples = size(labels,1);

for i = 1:numSamples
    filename_boundary = [testingPath sprintf('%03d_boundary.tif', i)];
    filename_interior = [testingPath sprintf('%03d_interior.tif', i)];
    filename_binarymask = [testingPath sprintf('%03d_floodfill.tif', i)];
    
    boundary = imread(filename_boundary);
    interior = imread(filename_interior);
    binaryMask = imread(filename_binarymask);
    
    boundary = im2uint8(boundary);
    interior = im2uint8(interior);
    binaryMask = im2uint8(binaryMask);
    
    imwrite(boundary, filename_boundary);
    imwrite(interior, filename_interior);
    imwrite(binaryMask, filename_binarymask);
end

training = [];
for i = 1:10
    boundary = imread(fileNames{i});
    boundary = boundary(:,:,1);
    boundary = imbinarize(boundary);
    floodfill = imread(fileNamesFloodFill{i});
    floodfill = floodfill(:,:,1);
    floodfill = imbinarize(floodfill);
    interior = imread(fileNamesInterior{i});
    interior = interior(:,:,1);
    feature_vector = featureExtraction(floodfill, interior, boundary);  
    if i <= 5 
        label = 0;
    else
        label = 1;
    end
    training = [training ; [feature_vector label]]; 
end
csvwrite(outputPathTrainingSet,training)


%img = imread('C:\Users\ronaldjuarez\Downloads\circle.png');