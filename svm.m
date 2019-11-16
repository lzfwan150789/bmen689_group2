clear all
BaseName1 = 'C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Boundaries/';
BaseName2 = '.tif';

BaseName3 = 'C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Floodfill/';
BaseName4 = '.tif';

BaseName5 = 'C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Interior/';
BaseName6 = '.tif';


for i = 1: 10
    FileName1 = [BaseName1,num2str(i),BaseName2];
    boundary = imbinarize(imread(FileName1));
    boundary = boundary(:, :, 1);
    
    FileName2 = [BaseName3,num2str(i),BaseName4];
    floodfill = imbinarize(imread(FileName2));
    floodfill = floodfill(:, :, 1);
    
    FileName3 = [BaseName5,num2str(i),BaseName6];
    interior = imread(FileName3);
    interior = interior(:, :, 1);
    
    x1 = str2double(Circularity(boundary));
    x2 = Area(floodfill);
    x3 = Elongation(boundary);
    
    s = GLCM(interior);
    y1 = s(1).Energy;
    y2 = s(1).Contrast;
    y3 = s(1).Correlation;
    y4 = s(1).Homogeneity;

    
    fractalBoundary = getFractalBoundary(boundary);
    cnBoundary = getCNBoundary(boundary);

       
    featureVector = [x1 x3 x2 y2 y3 y1 y4 fractalBoundary cnBoundary];
    if i < 6
        featureVector(41) = 1;
    else

        featureVector(41) = 0;
    end
    featureMatrix(i, :) = featureVector;
end

Y = featureMatrix(:, 41);
SVMModel = fitcsvm(featureMatrix, Y);

X = featureMatrix;

% kernel
% C 
CVSVMModel = fitcsvm(X,Y,'Holdout',0.8,'ClassNames',{'0','1'},'Standardize',true); %0.1 is bad, 0.5 is okay, 0.8 is good
CompactSVMModel = CVSVMModel.Trained{1}; % Extract trained, compact classifier
testInds = test(CVSVMModel.Partition);   % Extract the test indices
XTest = X(testInds,:);
YTest = Y(testInds,:);
[label,score] = predict(CompactSVMModel,XTest);
table(YTest(1:8),label(1:8),score(1:8,2),'VariableNames',{'TrueLabel','PredictedLabel','Score'});
