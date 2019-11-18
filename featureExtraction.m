function [featureVector] = featureExtraction(binaryMask, interior, boundary)
%     elongation = getElongation(binaryMask);
%     area = getArea(binaryMask);
%     glcm = getGLCM(interior);
%     fractalTexture = getFractalTexture(interior);
    fractalBoundary = getFractalBoundary(boundary);
    cnBoundary = getCNBoundary(boundary);
    featureVector = [fractalBoundary, cnBoundary];
end