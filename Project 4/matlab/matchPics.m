function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if size(I1, 3) == 3
    I1 = rgb2gray(I1);
end

if size(I2, 3) == 3
    I2 = rgb2gray(I2);
end

%% Detect features in both images
I1_features = detectFASTFeatures(I1);
I2_features = detectFASTFeatures(I2);

%% Obtain descriptors for the computed feature locations
[I1_desc, I1_locs] = computeBrief(I1, I1_features.Location);
[I2_desc, I2_locs] = computeBrief(I2, I2_features.Location);

%% Match features using the descriptors
threshold = 10.0;
ratio = 0.67;
indexPairs = matchFeatures(I1_desc, I2_desc, 'MatchThreshold', threshold, 'MaxRatio', ratio);
locs1 = I1_locs(indexPairs(:,1),:);
locs2 = I2_locs(indexPairs(:,2),:);

end

