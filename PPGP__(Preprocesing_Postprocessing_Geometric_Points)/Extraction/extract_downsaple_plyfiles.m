clc
close all
clear
sdir_folder='Input address 1';
ddir_folder='Input address 2';

files = dir([sdir_folder '\*.ply']);
num=60000;
percentage=0.10;
% gridStep = 30;

for i=1:length(files)
    sample = files(i).name;
%     ful_s_sample =sample(1:10);
    s_sample =sample(1:7);
%     source_pre = [sdir_folder '\' ful_s_sample 'Postop_Analyse.mat'];
    source_pre = [sdir_folder '\' s_sample '.pre_trunk.ply'];
    dest_pre = [ddir_folder '\' s_sample '.pre_trunk.ply'];
%     source_pre = [sdir_folder '\' s_sample '.post_trunk.ply'];
%     dest_pre = [ddir_folder '\' s_sample '.post_trunk.ply'];
    ptCloudIn_pre = pcread(source_pre)
    ptCloudOut_pre = pcdownsample(ptCloudIn_pre,'random',percentage);
%     ptCloudA = pcdownsample(ptCloudIn_pre,'gridAverage',gridStep);
%     pcwrite(pointCloud(ptCloudOut_pre(:,:).Location), dest_pre)
   
end
