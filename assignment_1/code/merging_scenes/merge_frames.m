function [ result_pc ] = merge_frames( frames_dir, frame_files, frame_sampling_rate,pose_estimation_type, icp_threshold, icp_sampling_technique, icp_sample_size )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    frame_prev = readPcd(fullfile(frames_dir, frame_files(1).name))';
    frame_prev = frame_prev(1:3, :);
    [frame_prev, ~] = remove_background(frame_prev);
    result_pc = frame_prev;
    for i = 1+frame_sampling_rate:frame_sampling_rate:3%size(frame_files,1)
        frame_files(i).name
        frame_new = readPcd(fullfile(frames_dir, frame_files(i).name))';
        frame_new = frame_new(1:3, :);
        [frame_new, ~]= remove_background(frame_new);
%         pcshow(pointCloud(frame_new'))
%         figure()

        
        [transformed_frame_new, ~, ~, ~] = icp_algorithm(frame_new, [], frame_prev, [], icp_threshold, icp_sampling_technique, icp_sample_size);
        result_pc = merge(result_pc, transformed_frame_new);
        
        switch pose_estimation_type
            case 'prev_frame'
                frame_prev = frame_new;
            case 'all_frames'
                frame_prev = result_pc;
        end
        
        pcshow(pointCloud(result_pc'))
        figure()
    end
    
end

