% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
img = imread('../data/cv_cover.jpg');
if size(img, 3) == 3
    img = rgb2gray(img);
end

%% Compute the features and descriptors
% BRIEF
img_features = detectFASTFeatures(img);
[img_desc, img_locs] = computeBrief(img, img_features.Location);

% SURF
% img_features = detectSURFFeatures(img);
% [img_desc, img_locs] = extractFeatures(img, img_features, 'Method', 'SURF');

histogram = [];
for i = 0:36
    %% Rotate image
    img_rotated = imrotate(img, i*10);
    %% Compute features and descriptors
    % BRIEF
    img_rotated_features = detectFASTFeatures(img_rotated);
    [img_rotated_desc, img_rotated_locs] = computeBrief(img_rotated, img_rotated_features.Location);
    % SURF
%     img_rotated_features = detectSURFFeatures(img_rotated);
%     [img_rotated_desc, img_rotated_locs] = extractFeatures(img_rotated, img_rotated_features, 'Method', 'SURF');
    %% Match features
    % BRIEF
    index_pairs = matchFeatures(img_desc, img_rotated_desc, 'MatchThreshold', 10.0, 'MaxRatio', 0.67);
    % SURF
%     index_pairs = matchFeatures(img_desc, img_rotated_desc, 'MatchThreshold', 10.0);
    
    matched_points1 = img_locs(index_pairs(:,1),:);
    matched_points2 = img_rotated_locs(index_pairs(:,2),:);
    if i == 7 || i == 14 || i == 21
        figure()
        showMatchedFeatures(img, img_rotated, matched_points1, matched_points2, 'montage');
    end
    %% Update histogram
    [x, y] = size(index_pairs);
    histogram = [histogram, x];
end

%% Display histogram
degree = linspace(0, 360, 360/10 + 1);
figure()
bar(degree,histogram);