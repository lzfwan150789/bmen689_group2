function [Area]= Area(I)
I0=imbinarize(I);
Area=sum(sum(I0));