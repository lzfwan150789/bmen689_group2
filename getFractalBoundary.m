function [fractalBoundary] = getFractalBoundary(boundary)
   [n, r,fractalBoundary] = boxcount(boundary,'slope');
end