function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1(:, 1:2));
centroid2 = mean(x2(:, 1:2));

%% Shift the origin of the points to the centroid
x1row = x1(:,1);
x1col = x1(:,2);
x2row = x2(:,1);
x2col = x2(:,2);

x1(:,1) = x1row - centroid1(1);
x1(:,2) = x1col - centroid1(2);
x2(:,1) = x2row - centroid2(1);
x2(:,2) = x2col - centroid2(2);

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
ave1 = mean(sqrt(x1(1, :).^2 + x1(2, :).^2));
ave2 = mean(sqrt(x2(1, :).^2 + x2(2, :).^2));
s1 = sqrt(2) / ave1;
s2 = sqrt(2) / ave2;
x1 = x1 * s1;
x2 = x2 * s2;

%% similarity transform 1
T1 = [s1 0 -s1*centroid1(1); 0 s1 -s1*centroid1(2); 0 0 1];

%% similarity transform 2
T2 = [s2 0 -s2*centroid2(1); 0 s2 -s2*centroid2(2); 0 0 1];

%% Compute Homography
H = computeH(x1,x2);
%% Denormalization
H2to1 = T2\H*T1;
end
