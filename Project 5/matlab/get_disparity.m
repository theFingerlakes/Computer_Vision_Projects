function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
[h,w,~] = size(im1);
dispM = zeros(h,w);
s = windowSize;

for i = 1:h
    for j = 1:w
        if i-s >= 1 && i+s <= h && j-s >= 1 && j+s <= w
            dist_tp = [];
            dispM_tp = [];
            im1_tp = im1(i-s:i+s,j-s:j+s);
            for k = 0:maxDisp
                if j-s-k >= 1 && j+s-k <= w
                    im2_tp = im2(i-s:i+s, j-s-k:j+s-k);
                    dist_tp = [dist_tp; sum(im1_tp(:)-im2_tp(:)) .^ 2];
                    dispM_tp = [dispM_tp; k];
                end
            end
            dispM(i,j) = dispM_tp(find(dist_tp==min(dist_tp),1));
        end
    end
end
end


