function [output] = conv_layer_forward(input, layer, param)
% Conv layer forward
% input: struct with input data
% layer: convolution layer struct
% param: weights for the convolution layer

% output: 

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
pad = layer.pad;
stride = layer.stride;
num = layer.num;
% resolve output shape
h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;

assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')
input_n.height = h_in;
input_n.width = w_in;
input_n.channel = c;

%% Fill in the code
% Iterate over the each image in the batch, compute response,
% Fill in the output datastructure with data, and the shape. 

output.height = h_out;
output.width = w_out;
output.channel = num;
output.batch_size = batch_size;

test = zeros([output.height, output.width, output.channel, output.batch_size]);

for i = 1:output.batch_size
    img1 = reshape(input.data(:,i), input.height, input.width, input.channel);
    img2 = padarray(img1, [pad pad]);
    img_height = size(img2,1);
    img_weight = size(img2,2);

    for j = 1:output.channel
        pw = param.w(:,j);
        w = reshape(pw, [k k c]);
        b = param.b(j);

        for l = 1:stride:img_height
            for m = 1:stride:img_weight
                
                if (l+k-1 <= img_height && m+k-1 <= img_weight)
                    aa = ceil(l/stride);
                    bb = ceil(m/stride);
                    area = img2(l:l+k-1, m:m+k-1, :);
                    val = sum(area .* w, "all") + b;
                    test(aa, bb, j, i) = val;

                end
            end
        end
    end
end

output.data = reshape(test, output.height * output.width * output.channel, output.batch_size);

end

