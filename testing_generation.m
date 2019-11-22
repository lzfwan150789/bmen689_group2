%% Feature extraction generation

testingCSVInfo = 'testset_paths.csv';
testingPath = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\Testing images\Masks\'; 
outputPathTrainingSet = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\trainingSet_full_v2_very_clean.csv';

t = readtable(testingCSVInfo);
labels = t{:, 4};

numSamples = size(labels,1);

training = [];

very_noisy = [1 7 15 16 20 25 34 40 58 74 76];
noisy = [1 7 10 14 15 16 20 21 25 26 29 31 34 35 38 40 49 58 62 68 69 74 76];

for i = 1:numSamples
    if ( ~ismember(i, noisy))
        filename_boundary = [testingPath sprintf('%03d_boundary.tif', i)];
        filename_interior = [testingPath sprintf('%03d_interior.tif', i)];
        filename_binarymask = [testingPath sprintf('%03d_floodfill.tif', i)];
        
        boundary = imread(filename_boundary);
        interior = imread(filename_interior);
        binaryMask = imread(filename_binarymask);
       
        %boundary = bwmorph(boundary,'skel',Inf);
        
        feature_vector = featureExtraction(binaryMask, interior, boundary);
        training = [training ; [feature_vector labels(i)]]; 
    end
end

csvwrite(outputPathTrainingSet,training)
