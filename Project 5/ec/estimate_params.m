function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.
[~,~,V] = svd(P);
n = size(V,2);
for i = 1:n
    V(:,i) = V(:,i)/V(4,i);
end

V(4,:) = [];
M = P(:,1:3);
M = sign(det(M))*M;
res = [0, 0, 1
       0, 1, 0
       1, 0, 0];
ro_res = res*M;
ro_res = sign(det(ro_res'))*ro_res';
[~, R_m] = qr(ro_res);
R1 = res * R_m' * res;
D = diag(sign(diag(R1)));
R1 = R1 * D;

K = R1;
R = inv(R1) * M;
K = K/K(end,end);
t = -R * V(:,4);

end

