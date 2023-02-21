function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

s_pts1 = pts1./M;
s_pts2 = pts2./M;

s = size(pts1, 1);
n = ones(s,1);

x = s_pts1(:,1);
y = s_pts1(:,2);
x2 = s_pts2(:,1);
y2 = s_pts2(:,2);

A = [x.*x2, x.*y2, x, y.*x2, y.*y2, y, x2, y2, n];

[~,~,V] = svd(A);

F = V(:,9);
F = reshape(F,3,3);

[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';

S = [1/M 0 0; 0 1/M 0; 0 0 1];
F = S'*F*S;
disp(F);
end