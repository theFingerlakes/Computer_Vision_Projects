function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.
param_grad.b = zeros(size(param.b));
param_grad.w = zeros(size(param.w));

pw = param.w;
od = output.diff;
in_data = input.data;

param_grad.b = sum(od.');
param_grad.w = in_data * (od.');
input_od = pw * od;



end
