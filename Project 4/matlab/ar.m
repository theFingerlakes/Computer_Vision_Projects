% Q3.3.1
book_cover = imread('../data/cv_cover.jpg');
book_video = loadVid('../data/book.mov');
source_video = loadVid('../data/ar_source.mov');
ar_video = VideoWriter('../results/ar.avi');

frame = size(source_video, 2);

open(ar_video);
for i = 1:frame
    book_frame = book_video(i).cdata;
    source_frame = source_video(i).cdata;

    [locs1, locs2] = matchPics(book_cover, book_frame);
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);

    source_frame = imcrop(source_frame, [0 45 size(source_frame, 2) size(source_frame, 1)-90]);
    scaled_hp_img = imresize(source_frame, [size(book_cover, 1) size(book_cover, 2)]);
    imshow(compositeH(bestH2to1.', scaled_hp_img, book_frame));
    writeVideo(ar_video, compositeH(bestH2to1.', scaled_hp_img, book_frame));
end

close(ar_video);