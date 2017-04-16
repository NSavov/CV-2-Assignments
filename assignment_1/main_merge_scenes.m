addpath(genpath('code'))
addpath('plotting_code')

%define parameters of the merging
scenes_dir = strcat('data');
file_ext = '*.pcd';

pose_estimation_type = 'prev_frame'; %choices are: 'prev_frame' (apply icp on the previous frame and the current frame)
                           %             'all_frames' (apply icp on the previous result pointcloud and the current frame)
                           
frame_sampling_rate = 3;   %step for iterating through the frames
icp_threshold = 0.00001;
icp_sampling_technique = 'uniform'; 
icp_sample_size = 15000;

frame_files = dir(fullfile(scenes_dir, file_ext));
frame_files = frame_files (1:2:end);
% pc_files_ind = contains({frame_files.name}, '*\d+.pcd');
% frame_files = frame_files(pc_files_ind == 1);

%perform the merging of the frames
result_cloud = merge_frames(scenes_dir, frame_files, frame_sampling_rate, pose_estimation_type, icp_threshold, icp_sampling_technique, icp_sample_size);
pcshow(pointCloud(result_cloud'))

