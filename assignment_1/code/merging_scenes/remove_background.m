function [ pointcloud, pointcloud_normals ] = remove_background( pointcloud, pointcloud_normals)
%REMOVE_BACKGROUND Summary of this function goes here
%   Detailed explanation goes here
    col_idx = pointcloud(3, :) <= 2;
    if ~isempty(pointcloud_normals)
        pointcloud_normals = pointcloud_normals(:, col_idx); 
    end
    pointcloud = pointcloud(:, col_idx);
end

