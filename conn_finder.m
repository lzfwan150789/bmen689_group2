%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
% Finds the S, cm, Rs, and xi of the particles in  %
% the black and white binary, bw_test. See doc-    %
% umentation for full description. Particles on    %
% the perimeter are excluded for edge = 0, for     %
% edge = 1 included.                               %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [S,cm,Rs,xi] = conn_finder(bw_test,edge)
%     
%     if edge == 1
%         bw_test = bw_test;
%     elseif edge == 0
%         bw_test = imclearborder(bw_test);
%     end
%     
    ccBW = bwconncomp(bw_test);
    area_d = regionprops(ccBW,'Area');
    area=cell2mat(struct2cell(area_d));

    s = 1:1:max(area);
    s_count = hist(area,max(area));
    
    %% ns, S
    
    ns = zeros(1,max(area));
    for i=1:1:max(area)
       ns(i) = s_count(i)/(ccBW.ImageSize(1)*ccBW.ImageSize(2)); 
    end
        
    S = s.^2*ns'/(s*ns');
    
    %% Rs and cm
    
    cm = zeros(ccBW.NumObjects,2);
    Rs = zeros(ccBW.NumObjects,1);
    for n = 1:1:ccBW.NumObjects
        new_BW = zeros(ccBW.ImageSize);
        new_BW(ccBW.PixelIdxList{n}) = 1;
    
        [Y,X] = ind2sub([ccBW.ImageSize ccBW.ImageSize],ccBW.PixelIdxList{n});
    
        cm_x = 1/area(n) * sum(X);
        cm_y = 1/area(n) * sum(Y);
    
        cm(n,:) = round([cm_x cm_y]);
    
        XY = [X,Y];
        cm_n = [ones(area(n),1)*cm_x, ones(area(n),1)*cm_y];
        Rs(n) = sqrt(1/area(n)*norm(XY-cm_n)^2);
        ns_xi(n) = length(find(area==area(n)))/(ccBW.ImageSize(1)*ccBW.ImageSize(2));
    end
    
    %% xi

    xi = sqrt(sum(area.^2.*ns_xi.*Rs'.^2)/sum(area.^2.*ns_xi));

end