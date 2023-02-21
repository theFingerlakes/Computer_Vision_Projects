someCorresp = load('../data/someCorresp.mat');
pts1 = someCorresp.pts1;
pts2 = someCorresp.pts2;
M = someCorresp.M;

F = eightpoint(pts1, pts2, M);

I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');

instrinsics = load('../data/intrinsics.mat');
k1 = instrinsics.K1;
k2 = instrinsics.K2;
%displayEpipolarF(I1, I2, F);
%epipolarMatchGUI(I1, I2, F);
E = essentialMatrix(F,k1,k2);
disp(E);


