I_groundtruth = imread('groundtruth image');
I_groundtruth = I_groundtruth(:,:,1);
I_groundtruth = double(I_groundtruth);
[rows,cols] = size(I_groundtruth); 
x_groundtruth = ones(rows,1)*[1:cols];
y_groundtruth = [1:rows]'*ones(1,cols);   
area_groundtruth = sum(sum(I_groundtruth)); 
meanx_groundtruth = sum(sum(I_groundtruth.*x_groundtruth))/area_groundtruth; 
meany_groundtruth = sum(sum(I_groundtruth.*y_groundtruth))/area_groundtruth;

I = imread('preprocessing image');
I = double(I);
[rows,cols] = size(I); 
x = ones(rows,1)*[1:cols];
y = [1:rows]'*ones(1,cols);   
area = sum(sum(I)); 
meanx = sum(sum(I.*x))/area; 
meany = sum(sum(I.*y))/area;

delX = round(meanx_groundtruth-meanx); 
delY = round(meany_groundtruth-meany);
res = zeros(52,52);
tras = [1 0 delY; 0 1 delX; 0 0 1]; 

for i = 1 : 52
    for j = 1 : 52
        temp = [i; j; 1];
        temp = tras * temp;
        x = temp(1, 1);
        y = temp(2, 1);
        
        if (x <= 52) && (y <= 52) && (x >= 1) && (y >= 1)
            res(x, y) = I(i, j);
        end
    end
end

I_groundtruth = imbinarize(I_groundtruth);
res = imbinarize(res);
Dice_score = dice(res,I_groundtruth);
figure
imshowpair(res, I_groundtruth)
title(['Dice Index = ' num2str(Dice_score)])