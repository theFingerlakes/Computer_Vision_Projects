layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
imshow(img')
 
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
% Fill in your code here to plot the features.

od_2 = output{2}.data;
od_3 = output{3}.data;
figure;
output_2 = reshape(od_2,[],20);
for n = 1:20
    subplot(4,5,n);
    temp1 = rescale(output_2(:,n),0,1);
    temp1 = reshape(temp1,24,24)';
    imshow(temp1);
end

figure;
output_3 = reshape(od_3,[],20);
for n = 1:20
    subplot(4,5,n);
    temp2 = rescale(output_3(:,n),0,1);
    temp2 = reshape(temp2,24,24)';
    imshow(temp2);
end