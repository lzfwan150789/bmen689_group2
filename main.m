pathName = 'E:\Ronald\Databases\LungNodules_SPIE\SPIE-AAPM Lung CT Challenge';

fileNames = generateFileNames(pathName);
fileNameLocations = readscv('locations.csv')
numberFiles = length(fileNames);

trainingSet = [];

for i = 1:numberFiles
    I = imread(fileNames(i));
    [binaryMask, interior, boundary] = preprocessing(I);
    [featureVector] = featureExtraction(binaryMask, interior, boundary);
    trainingSet = trainingSet + featureVector;
end
    
model = generateModel(featureVector);
