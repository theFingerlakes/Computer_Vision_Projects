% For Part 4.3, 4.4
close all;
clear;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');
[locs1, locs2] = matchPics(cv_cover, cv_desk);

random_points = zeros(10, 2);
[x,y] = size(cv_cover);

for i = 1:10
    random_points(i,1) = randi(x);
    random_points(i,2) = randi(y);
end

%H = computeH(locs1, locs2);
H = computeH_norm(locs1, locs2);

m = ones(3,10);
m(1,:) = random_points(:,1);
m(2,:) = random_points(:,2);

desk_points = (H * m);
desk_points(1,:) = desk_points(1,:)./desk_points(3,:);
desk_points(2,:) = desk_points(2,:)./desk_points(3,:);

plot2 = zeros(10,2);
plot2(:,1) = desk_points(1,:);
plot2(:,2) = desk_points(2,:);
plot1 = random_points;

figure()
showMatchedFeatures(cv_cover, cv_desk, plot1, plot2, 'montage')





