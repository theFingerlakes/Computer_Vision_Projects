function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    % Replace the following line with your implementation.

    output.height = h_out;
    output.width = w_out;
    output.batch_size = batch_size;
    output.channel = c;

    output.data = zeros([output.height, output.width, output.channel, output.batch_size]);
    test = zeros([output.height, output.width, output.channel, output.batch_size]);
    
    for i = 1:output.batch_size
        img1 = reshape(input.data(:,i), input.height, input.width, input.channel);
        img2 = padarray(img1, [pad pad]);
        img_height = size(img2,1);
        img_weight = size(img2,2);

        for j = 1:output.channel
            for l = 1:stride:img_height
                for m = 1:stride:img_weight
                    
                    if (l+k-1 <= img_height && m+k-1 <= img_weight)
                        aa = ceil(l/stride);
                        bb = ceil(m/stride);
                        area = img2(l:l+k-1, m:m+k-1, j);
                        t = max(area, [], "all");
                        test(aa, bb, j, i) = t;

                    end
                end
            end
        end
    end
    
    output.data = reshape(test, output.height * output.width * output.channel, output.batch_size);
end

