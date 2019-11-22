%% Background slice for subtraction

baseFileCSVInfo = 'C:/Users/lenovo/Documents/Github/bmen689_group2/testset_paths.csv';
CTScanPath = 'C:\Users\lenovo\Downloads\SPIE-AAPM Lung CT Challenge\'; 
BackgroundSlicePath = 'C:\Users\lenovo\Documents\Github\bmen689_group2\Testing images\Computer generated masks\';

t = readtable(baseFileCSVInfo);
X = t{:, 1};
Y = t{:, 2};
CentralSlicePath = t{:, 5};


numSamples = size(X,1);

training = [];

for i = 1:numSamples
    if (i == 40)
        baseFile = char(strcat(CTScanPath, CentralSlicePath(i)));
        L = strlength(baseFile);
        
        CTBaseFoler = 
        
        centralImageNumber = baseFile(L-9: L-4);
        centralImageNumber = char(centralImageNumber);
        CIN = str2double(centralImageNumber);
        
        backgroundImageNumber = CIN - 10;
        
        backgroundSliceHomePath = strcat(CTScanPath, 
              
    end
end

