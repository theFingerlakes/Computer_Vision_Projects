% A test script using templeCoords.mat
%
% Write your code here
%

load('../data/someCorresp.mat')
load('../data/intrinsics.mat')
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
F = eightpoint(pts1, pts2, M);
load('../data/templeCoords.mat')
n = size(pts1,1);

for i = 1:n
    [pts2] = epipolarCorrespondence(im1, im2, F, pts1(i,:));
    pts2_t(i,:) = pts2;
end

load('../data/intrinsics.mat')

E = essentialMatrix(F, K1, K2)
P1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];
cd = camera2(E);

for i = 1:4
    P = triangulate(K1*P1, pts1, K2*cd(:,:,i), pts2_t);
    if all(P(3,:)>0)
        fp = P;
        M2 = cd(:,:,i);
    end
end

R1 = P1(:,1:3);
t1 = P1(:,4);
R2 = M2(:,1:3);
t2 = M2(:,4);

save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');

plot3(fp(1,:), fp(2,:), fp(3,:), '.'); axis equal

