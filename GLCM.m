function [stats] = GLCM(I)
GLCM = graycomatrix(I);
stats = graycoprops(GLCM);
end