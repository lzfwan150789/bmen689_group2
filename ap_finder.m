%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
% Finds the area and perimeter of particles in a   %
% black and white binary image, bw_test. Particles %
% on the perimeter are excluded for edge = 0, for  %
% edge = 1 included.                               %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [area perim] = ap_finder(bw_test,edge)

    if edge == 1
        bw_test = bw_test;
    elseif edge == 0
        bw_test = imclearborder(bw_test);       
    end
    
    % area determined by bwconncomp
    ccBW = bwconncomp(bw_test);
    area_d = regionprops(ccBW,'Area');
    area=cell2mat(struct2cell(area_d));
    
    % perimeter is determined by dilating particles by 1 pixel
    SE = strel('disk',1,0);
    perim = zeros(ccBW.NumObjects,1);
    for n = 1:1:ccBW.NumObjects
        new_BW = zeros(ccBW.ImageSize);
        new_BW(ccBW.PixelIdxList{n}) = 1;
                
        new_BW_d = imdilate(new_BW,SE);
        
        perim(n) = length(find(new_BW_d)==1) - length(find(new_BW)==1);
    end
end