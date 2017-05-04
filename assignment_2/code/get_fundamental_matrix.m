function [ F ] = get_fundamental_matrix( im1, im2, ransac_iterations, ransac_sample_size, outlier_threshold )
%GET_FUNDAMENTAL_MATRIX Summary of this function goes here
%   Detailed explanation goes here
    [f1, d1] = vl_sift(single(im1));
    [f1, d1] = remove_sift_descriptors_in_background(f1, d1, im1);
%     visualize_features(f1, im1)
    [f2, d2] = vl_sift(single(im2));
    [f2, d2] = remove_sift_descriptors_in_background(f2, d2, im2);
    threshold = 1.5; % default is 1.5
    [matches, ~] = vl_ubcmatch(d1, d2, threshold); 
%     size(matches)
%     
     % fixed for this assignment
    [F, inlier_count, inlier_indices] = ransac(f1, f2, matches, ransac_iterations, ransac_sample_size, outlier_threshold);
    size(matches)
    inlier_count
    indices = randperm(size(matches, 2));
%     plot_matching_descriptors(im1, im2, matches(:, inlier_indices), f1, f2, 'test');
    selected_matches = matches(:,indices(1:10));
    
    subplot(1,2,1)
    plot_epipolar_lines(F, f1(1:2, selected_matches(1,:)), im1)
    scatter(f2(1, selected_matches(2,:)), f2(2, selected_matches(2,:)), 'g')
    
    title('Source frame')
%     figure()
    subplot(1,2,2)
    plot_epipolar_lines(F', f2(1:2, selected_matches(2,:)), im2)
    scatter(f1(1, selected_matches(1,:)), f1(2, selected_matches(1,:)), 'g')
    
    title('Target frame')
end