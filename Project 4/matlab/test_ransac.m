% For Part 4.5
close all;
clear;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');


[locs1, locs2] = matchPics(cv_cover, cv_desk);
[bestH2to1, inliers] = computeH_ransac(locs2, locs1);
% bestH2to1 = transpose(bestH2to1);
new_locs1 = locs1(inliers==1,:); 
new_locs2 = locs2(inliers==1,:);
size_locs = size(new_locs1,1);
array_points = ones(3,size_locs);
array_points(1,:) = new_locs1(:,1);
array_points(2,:) = new_locs1(:,2);
points_on_cv_desk = (bestH2to1* array_points);
points_on_cv_desk(1,:) = points_on_cv_desk(1,:)./points_on_cv_desk(3,:);
points_on_cv_desk(2,:) = points_on_cv_desk(2,:)./points_on_cv_desk(3,:);
plot_points_2 = zeros(size_locs,2);
plot_points_2(:,1) = points_on_cv_desk(1,:); 
plot_points_2(:,2) = points_on_cv_desk(2,:);
plot_points_1 = new_locs1;
figure()
showMatchedFeatures(cv_cover, cv_desk, plot_points_1, plot_points_2, 'montage')

