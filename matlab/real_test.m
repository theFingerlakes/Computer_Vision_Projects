%% Network defition
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat
%% Real-world testing

% convert input images to grayscale images
gray1 = rgb2gray(imread('../images/test1.jpg'));
gray2 = rgb2gray(imread('../images/test2.jpg'));
gray3 = rgb2gray(imread('../images/test3.jpg'));
gray4 = rgb2gray(imread('../images/test4.jpg'));
gray5 = rgb2gray(imread('../images/test5.jpg'));

% convert grayscale images to binary images by thresholding
bw1 = 1 - imbinarize(gray1);
bw2 = 1 - imbinarize(gray2);
bw3 = 1 - imbinarize(gray3);
bw4 = 1 - imbinarize(gray4);
bw5 = 1 - imbinarize(gray5);

% resize images
crop = 28;
img1 = imresize(bw1, [crop,crop]);
img2 = imresize(bw2, [crop,crop]);
img3 = imresize(bw3, [crop,crop]);
img4 = imresize(bw4, [crop,crop]);
img5 = imresize(bw5, [crop,crop]);

% reshape 5 processed images to one column
test = zeros(crop*crop, 100);
test(:,1) = reshape(img1',[],1);
test(:,2) = reshape(img2',[],1);
test(:,3) = reshape(img3',[],1);
test(:,4) = reshape(img4',[],1);
test(:,5) = reshape(img5',[],1);

% pass processed data through the network
[~, A] = convnet_forward(params, layers, test);
[~, res] = max(A);
disp(A(:,1:5))
disp(res(1:5)-1)