function [Circularity] = Circularity(I)

%Read the image
I = edge(I,'canny');

%Fill the closed shape, the fill color is white
bw  = imfill(I,'holes');

%Border search
[B,L] = bwboundaries(bw,'noholes');

%calculate area
stats = regionprops(L,'Area','Centroid');
%Loop processing each boundary, length (B) is the number of closed graphics
for k = 1:length(B)

  %Get boundary coordinates
  boundary = B{k};

  %Calculate the perimeter
  delta_sq = diff(boundary).^2;
  perimeter = sum(sqrt(sum(delta_sq,2)));

  %Get the area of the object marked K
  area = stats(k).Area;

  %Roundness calculation formula
  metric = 4*pi*area/perimeter^2;

  %Show the result
  Circularity = sprintf('%2.2f',metric);

end