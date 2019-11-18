pathName = 'C:\Users\lenovo\Documents\Github\bmen689_group2\';

BIG = 51;

fileNames = generateFileNames(pathName);
fileNameLocations = readscv('locations.csv');
numberFiles = length(fileNames);

trainingSet = [];

for i = 1:numberFiles
    I = imread(fileNames(i));
    coordinates = fileNameLocations(i);
    window = [coordinates, BIG, BIG];
    [binaryMask, interior, boundary] = preprocessing(I, window);
    [featureVector] = featureExtraction(binaryMask, interior, boundary);
    trainingSet = trainingSet + featureVector;
end

% model selection 
model = generateModel(featureVector);
