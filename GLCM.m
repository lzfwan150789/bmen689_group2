function [stats] = GLCM(I)
GLCM = graycomatrix(I);
stats = graycoprops(GLCM);
stats = [stats.Contrast stats.Correlation stats.Energy stats.Homogeneity];
end