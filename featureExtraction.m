function [featureVector] = featureExtraction(binaryMask, interior, boundary)
     elongation = Elongation(boundary);
     area = Area(binaryMask);
     glcm = GLCM(interior);
     circularity = Circularity(boundary);
<<<<<<< HEAD
     %fractalTexture = getFractalTexture(interior);
     fractalBoundary = getFractalBoundary(boundary);
     cnBoundary = getCNBoundary(boundary);
     featureVector = [circularity elongation, area, glcm, fractalBoundary, cnBoundary];
=======
     fractalTexture = getFractalTexture(interior);
     fractalBoundary = getFractalBoundary(boundary);
     cnBoundary = getCNBoundary(boundary);
     featureVector = [circularity elongation, area, glcm,fractalTexture, fractalBoundary, cnBoundary];
>>>>>>> master
end