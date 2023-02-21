function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

ps = size(pts1,1);
tp = ones(1, ps);
p = [pts1'; tp];
p2 = [pts2'; tp];

for i = 1:ps
    A1 = [0 p(3,i) -p(2,i) 
        -p(3,i) 0 p(1,i)];

    A2 = [0 p2(3,i) -p2(2,i) 
        -p2(3,i) 0 p2(1,i)];

    A = [A1*P1 
        A2*P2];

    [~,~,V] = svd(A);
    pt = V(:,end);
    p3d(:,i) = pt/pt(4);
end

pts3d = p3d(1:3,:);

error1 = 0;
error2 = 0;
projection1 = P1*p3d;
projection2 = P2*p3d;
sp = size(projection1,2);

for j = 1:sp
    projection1(:,j) = projection1(:,j)/projection1(3,j);
    projection2(:,j) = projection2(:,j)/projection2(3,j);

    single_error1 = sqrt((p(1,j)-projection1(1,j)).^2 + (p(2,j)-projection1(2,j)).^2);
    error1 = error1 + single_error1;

    single_error2 = sqrt((p2(1,j)-projection2(1,j)).^2 + (p2(2,j)-projection2(2,j)).^2);
    error2 = error2 + single_error2;
end

error1 = error1/size(projection1,2);
error2 = error2/size(projection2,2);

disp(['re-projection error1: ',num2str(error1)])
disp(['re-projection error2: ',num2str(error2)])

end



