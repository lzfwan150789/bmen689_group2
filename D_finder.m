%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
% Finds Hausdorff dimension, D, of each particle   %
% in a black and white binary image, bw_test. See  %
% the documentation for more information.          %
% Particles on the perimeter are excluded for edge %
% = 0, for edge = 1 included.                      %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [D] = D_finder(bw_test,edge)

    if edge == 1
        bw_test = bw_test;
    elseif edge == 0
        bw_test = imclearborder(bw_test);
    end

    ccBW = bwconncomp(bw_test);
    area_d = regionprops(ccBW,'Area');

    area=cell2mat(struct2cell(area_d));

    SE = strel('disk',1,0);
    for n = 1:1:ccBW.NumObjects
        new_BW = zeros(ccBW.ImageSize);
        new_BW(ccBW.PixelIdxList{n}) = 1;
        [Y,X] = ind2sub([ccBW.ImageSize ccBW.ImageSize],ccBW.PixelIdxList{n});
        new_BW2 = imcrop(new_BW,[min(X)-1 min(Y)-1 max(X)-min(X)+2 max(Y)-min(Y)+2]);
    
        for i = 1:1:10;
            sBW = imresize(new_BW2,i,'Method','nearest');
            sBW = im2bw(sBW);
            scale_area(i) = length(sBW==1);
        end
    
        eps = mean(scale_area./(1:1:10));
        D(n) = log(area(n))/log(eps);
    
    end
end