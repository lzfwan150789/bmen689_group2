%% initialize
clc, clear all, close all

bw_test = imread('C:/Users/lenovo/Documents/Github/bmen689_group2/Training images/Renamed Clean Set/Interior/8.tif');
bw_test = bw_test(:, :, 1);

%% find the area and perimeter of particles
% [area_test perim_test] = ap_finder(bw_test,0);
% 
% %% show the image being analysed:
% figure
% imshow(bw_test)
% 
% %% make a log-log plot of the area vs perimeter of clusters
% figure
% loglog(area_test,perim_test,'.')
% xlabel('Area [px^2]')
% ylabel('Perimeter [px]')

%% find connected component parameters

[S_test,~,Rs_test,xi_test] = conn_finder(bw_test,0);

%% plotting parameter data
disp(['Average particle size in the image is S = ' num2str(S_test) ' px^2'])
disp(['Correlation length is xi = ' num2str(xi_test) ' px'])

figure
plot(1:length(Rs_test),sort(Rs_test),'.')
xlabel('Particle count')
ylabel('Gyration radius, R_s')

%% find fractal dimension

[D_test] = D_finder(bw_test,0);

%% plot D
figure
plot(1:length(D_test),sort(D_test),'.')
xlabel('Particle count')
ylabel('Hausdorff, D')