function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]

A = [];
dx = x';
dX = X';

for i = 1:size(dx,1)
    x = dx(i,1);
    y = dx(i,2);
    X = dX(i,1);
    Y = dX(i,2);
    Z = dX(i,3);

    A = [A;
        X, Y, Z, 1, 0, 0, 0, 0, -x*X, -x*Y, -x*Z, -x;
        0, 0, 0, 0, X, Y, Z, 1, -y*X, -y*Y, -y*Z, -y];
end

[~,~,V] = svd(A);

smt = V(:,size(V,2));

P = [smt(1:4)'
    smt(5:8)'
    smt(9:12)'];

end



