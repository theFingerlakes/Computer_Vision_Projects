function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
num_points = size(x1, 1);
H = zeros(2 * num_points, 9);
if any(isnan(x2(:)))
    x2 = zeros(size(x2,1), size(x2,2));
end

for i = 1:num_points
    x11 = x1(i,1);
    x12 = x1(i,2);
    x21 = x2(i,1);
    x22 = x2(i,2);
    H(2*i-1, :) = [-x11 -x12 -1 0 0 0 x21*x11 x21*x12 x21];
    H(2*i, :) = [0 0 0 -x11 -x12 -1 x22*x11 x22*x12 x22];
end

[U, S, V] = svd(H);
H2to1 = reshape(V(:,end), 3, 3)';
end
