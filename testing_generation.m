%% Feature extraction generation

testingCSVInfo = 'testset_paths.csv';
testingPath = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\Testing images\Masks\'; 
outputPathTrainingSet = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\trainingSet_full.csv';

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
    
    boundary = imbinarize(boundary);
    boundary = bwmorph(boundary,'skel',Inf);
    binaryMask = imbinarize(binaryMask);
    
    feature_vector = featureExtraction(binaryMask, interior, boundary);
    training = [training ; [feature_vector labels(i)]]; 
end

csvwrite(outputPathTrainingSet,training)
