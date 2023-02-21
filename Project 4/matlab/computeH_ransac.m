function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
%Q2.2.3
total_points = size(locs1, 1);
random_points = 4;
most_inliers = 0;
best_inliers = zeros(1, total_points);

for i = 1:50000
    temp_inliers = zeros(1, total_points);
    r = randperm(total_points, random_points);
    p1 = zeros(random_points, 2);
    p2 = zeros(random_points, 2);

    for j = 1:random_points
        p1(j,:) = locs1(r(j), :);
        p2(j,:) = locs2(r(j), :);
    end

    [H] = computeH_norm(p1,p2);

    est_x = H * [locs1 ones(size(locs1, 1), 1)]';
    est_x = est_x./est_x(3, :);
    est_y = [locs2 ones(size(locs2, 1), 1)]';
    d = est_x - est_y;
    d = sqrt(d(1, :).^2 + d(2, :).^2);

    count = 0;
    for k = 1:total_points
        if d(k) < 0.5
            count = count + 1;
            temp_inliers(k) = 1;
        end
    end

    if count > most_inliers
        most_inliers = count;
        best_inliers = temp_inliers;
        bp = r;
    end

end
    inliers = best_inliers;
    fy = locs2(inliers==1, :);
    fx = locs1(inliers==1, :);
    ff = locs1(bp(1, :), :);
    bestH2to1 = computeH(fy, fx);
end