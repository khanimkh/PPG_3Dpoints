clc
close all
clear

dir_folder_source='Input directory 1\';
dir_folder_des='Input directory 2\';
files = dir([dir_folder_source '/S*']);
temp='ascend_'; % temp='ascend_' OR temp='descend_' OR temp=''
type_normalization='LCN'; %'LCN' 'lengh_curve_norm'; %'MSN' 'mean_std_norm';
try
    for i=1:length(files)
        sample = files(i).name;

        source_pre = [dir_folder_source '\' sample '\points-PLY\per_vertebra\' sample '.pre.ply'];
        source_post = [dir_folder_source '\' sample '\points-PLY\per_vertebra\' sample '.post.ply'];

%         
        source_pre_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.'  temp 'pre_center_without_normalized_transfo_T.ply'];
        source_pre_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.'  temp 'pre_center_without_normalized_transfo_R.ply'];
        source_post_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.' temp 'post_center_without_normalized_transfo_T.ply'];
        source_post_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.' temp 'post_center_without_normalized_transfo_R.ply'];
        source_meta = [dir_folder_source '\' sample '\T_R_ply\' sample '.meta_T.ply'];
%  
        st1=copyfile(source_pre,dir_folder_des);
        st2=copyfile(source_post,dir_folder_des);
        st3=copyfile(source_meta,dir_folder_des);
        st4=copyfile(source_pre_T,dir_folder_des);
        st5=copyfile(source_pre_R,dir_folder_des);
        st6=copyfile(source_post_T,dir_folder_des);
        st7=copyfile(source_post_R,dir_folder_des);
        disp(['job is done for sample=' sample]);
        
    end
    
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end
