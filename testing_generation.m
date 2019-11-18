%% Feature extraction generation
dirPath = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\Training images\Clean Set\'; 
outputPathTrainingSet = 'C:\Users\ronaldjuarez\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\trainingSet.csv';
fileNames = { [dirPath  'BE001-boundary.tif'],
    [dirPath 'BE002-boundary.tif'],
    [dirPath 'BE006-boundary.tif'],
    [dirPath 'BE007-boundary.tif'],
    [dirPath 'BE010-boundary.tif'],
    [dirPath 'LC001-boundary.tif'],
    [dirPath 'LC002-boundary.tif'],
    [dirPath 'LC003-boundary.tif'],
    [dirPath 'LC008-boundary.tif'],
    [dirPath 'LC009-boundary.tif']};


fileNamesFloodFill = { [dirPath  'BE001-floodfill.tif'],
    [dirPath 'BE002-floodfill.tif'],
    [dirPath 'BE006-floodfill.tif'],
    [dirPath 'BE007-floodfill.tif'],
    [dirPath 'BE010-floodfill.tif'],
    [dirPath 'LC001-floodfill.tif'],
    [dirPath 'LC002-floodfill.tif'],
    [dirPath 'LC003-floodfill.tif'],
    [dirPath 'LC008-floodfill.tif'],
    [dirPath 'LC009-floodfill.tif']};

fileNamesInterior = { [dirPath  'BE001-interior.tif'],
    [dirPath 'BE002-interior.tif'],
    [dirPath 'BE006-interior.tif'],
    [dirPath 'BE007-interior.tif'],
    [dirPath 'BE010-interior.tif'],
    [dirPath 'LC001-interior.tif'],
    [dirPath 'LC002-interior.tif'],
    [dirPath 'LC003-interior.tif'],
    [dirPath 'LC008-interior.tif'],
    [dirPath 'LC009-interior.tif']};
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