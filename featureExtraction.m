function [featureVector] = featureExtraction(binaryMask, interior, boundary)
     elongation = Elongation(boundary);
     area = Area(binaryMask);
     glcm = GLCM(interior);
     circularity = str2double(Circularity(boundary));
     fractalTexture = getFractalTexture(interior);
     fractalBoundary = getFractalBoundary(boundary);
     cnBoundary = getCNBoundary(boundary);
     featureVector = [circularity elongation, area, glcm, fractalBoundary,fractalTexture, cnBoundary];
end