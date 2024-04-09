%% Extracting R and T from input data O3 %%%%%%%%%%%%%%%%
clc
close all
clear

addpath '.\Calculation_Geometrices'
addpath '.\Calculation_Statistiques'
addpath '.\Commands'
addpath '.\Conversion'
addpath '.\Defination'
addpath '.\Extraction'
addpath '.\Visualization'

dir_folder='Input address';
files = dir([dir_folder '\S*']);
direction=1; 
if direction==1
   dir_='ascend';
else
   dir_='descend';
end

type_normalization=''; %'LCN' 'lengh_curve_norm'; %'MSN' 'mean_std_norm';

try
    for i=1:length(files)
        sample = files(i).name;

        %% pre
       
        if strcmp(type_normalization,'LCN')
             source_pre = [dir_folder '\'  sample '\points-PLY\per_vertebra\'  sample '.pre_normalized_LCN.ply'];
             dest_pre_T = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_pre_point_LCN_T.ply'];
             dest_pre_R = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_pre_point_LCN_R.ply'];
        end
        if strcmp(type_normalization,'MSN')
             source_pre = [dir_folder '\'  sample '\points-PLY\per_vertebra\'  sample '.pre_normalized_MSN.ply'];
             dest_pre_T = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_pre_point_MSN_T.ply'];
             dest_pre_R = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_pre_point_MSN_R.ply'];
        end
        source_pre = [dir_folder '\'  sample '\points-PLY\per_vertebra\'  sample '.pre.ply'];
        dest_pre_T = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_pre_point_T.ply'];
        dest_pre_R = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_pre_point_R.ply'];
        
        
        landmarks_Norm= pcread(source_pre);
        vector=landmarks_Norm.Location();

        for i=1:6:102
            %% Calcutation of the translation vector

            trans_pre(:,i)=vector(i+6,:)-vector(i,:);
            trans_pre(:,i+1)=vector(i+7,:)-vector(i+1,:);
            trans_pre(:,i+2)=vector(i+8,:)-vector(i+2,:);
            trans_pre(:,i+3)=vector(i+9,:)-vector(i+3,:);
            trans_pre(:,i+4)=vector(i+10,:)-vector(i+4,:);
            trans_pre(:,i+5)=vector(i+11,:)-vector(i+5,:);

        end
        pcwrite(pointCloud(trans_pre'), dest_pre_T);
        pcwrite(pointCloud(trans_pre'), dest_pre_R);
        
         %% post
       
        if strcmp(type_normalization,'LCN')
             source_post = [dir_folder '\'  sample '\points-PLY\per_vertebra\'  sample '.post_normalized_LCN.ply'];
             dest_post_T = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_post_point_LCN_T.ply'];
             dest_post_R = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_post_point_LCN_R.ply'];
        end
        if strcmp(type_normalization,'MSN')
             source_post = [dir_folder '\'  sample '\points-PLY\per_vertebra\'  sample '.post_normalized_MSN.ply'];
             dest_post_T = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_post_point_MSN_T.ply'];
             dest_post_R = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_post_point_MSN_R.ply'];
        end
        source_post = [dir_folder '\'  sample '\points-PLY\per_vertebra\'  sample '.post.ply'];
        dest_post_T = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_post_point_T.ply'];
        dest_post_R = [dir_folder '\'  sample '\T_R_ply\'  sample '.' dir_ '_post_point_R.ply'];
        
        landmarks_Norm= pcread(source_post);
        vector=landmarks_Norm.Location();

        for i=1:6:102
            %% Calcutation of the translation vector

            trans_post(:,i)=vector(i+6,:)-vector(i,:);
            trans_post(:,i+1)=vector(i+7,:)-vector(i+1,:);
            trans_post(:,i+2)=vector(i+8,:)-vector(i+2,:);
            trans_post(:,i+3)=vector(i+9,:)-vector(i+3,:);
            trans_post(:,i+4)=vector(i+10,:)-vector(i+4,:);
            trans_post(:,i+5)=vector(i+11,:)-vector(i+5,:);

        end
        pcwrite(pointCloud(trans_post'), dest_post_T);
          pcwrite(pointCloud(trans_post'), dest_post_R);
        
        disp(['job is done for sample=' sample]);
        
    end
    
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end

