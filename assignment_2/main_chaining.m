addpath code/chaining
addpath code/fundamental_matrix
addpath code/helper
addpath code/plotting_and_printing
addpath code/structure_from_motion
run ./vlfeat/toolbox/vl_setup.m

% chaining hyper-parameters
trials = 100; 
outlier_threshold = 1;
sample_count = 8;

img_names = get_image_names_from_directory('data/', 'png');
start_index = 1;
end_index = 20; %size(img_names, 2);

% create a binary matrix that keeps track of all the keypoints that remain
% in consequative frames.
[pointview, tracked_descriptors] = chain( img_names,start_index, end_index, trials, outlier_threshold, sample_count );
% visualize this matrix
plot_pointview_matrix( pointview )
save('pointview_t1.mat', 'pointview', 'tracked_descriptors')
