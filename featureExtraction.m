function [featureVector] = featureExtraction(binaryMask, interior, boundary)
    elongation = getElongation(binaryMask);
    area = getArea(binaryMask);
    glcm = getGLCM(interior);
    fractalTexture = getFractalTexture(interior);
    fractalBoundary = getFractalBoundary(boundary);
    cnBoundary = getCNBoundary(boundary);
    featureVector = [elongation, area, glcm, fractalTexture, fractalBoundary, cnBoundary];
end