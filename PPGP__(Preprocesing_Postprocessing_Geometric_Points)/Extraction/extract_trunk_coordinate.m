clc
close all
clear

sdir_folder='Input address 1';
ddir_folder='Input address 2';


files = dir([sdir_folder '\*.mat']);
% num=60000;
num=3000;

for i=1:3:length(files)
    sample = files(i).name;
  
%     patient_num= extractBefore(sample,'_');
%     if (i<=18)
%         s_sample =sample(1:9);
%     else
%         s_sample =sample(1:7);
    s_sample =sample(8:14);
%     end
    source_pre = [sdir_folder '\Maryam_' s_sample '_Preop_Analyse_new.mat'];
    source_post = [sdir_folder '\Maryam_' s_sample '_Postop_Analyse_new.mat'];
%     source_pre = [sdir_folder '\' sample];
%     source_post = [sdir_folder '\' sample];
%     d_sample =sample(1:7);
    d_sample =sample(8:14);
    dest_pre = [ddir_folder '\' d_sample '.pre_trunk.ply'];
    dest_post = [ddir_folder '\' d_sample '.post_trunk.ply'];
    
    %% Pre
    load(source_pre);
%     coord_pre= FV.Coord(:,:);
%     connect_pre= FV.Connect(:,:);
    
%     max_pre=max(coord_pre(:,:,:));
%     coord_pre_norm=coord_pre/max_pre(3);
    
    % coord_pre_norm_x=coord_pre(:,1)/max_pre(1);
    % coord_pre_norm_y=coord_pre(:,2)/max_pre(2);
    % coord_pre_norm_z=coord_pre(:,3)/max_pre(3);
    % coord_pre_norm =[coord_pre_norm_x, coord_pre_norm_y, coord_pre_norm_z];
    
    %% Post
    load(source_post);
%     coord_post= FV.Coord(:,:);
%     connect_post= FV.Connect(:,:);
    
%     max_post=max(coord_post(:,:,:));
%     coord_post_norm=coord_post/max_post(3);

    [numR_index_pre, numC_index]=size(coord_pre);
    [numR_index_post, numC_index]=size(coord_post);
    diff_pre=num-numR_index_pre;
    diff_post=num-numR_index_post;
   
    vec=[0,0,0];
    if diff_pre>0 
        for i=1:diff_pre
            coord_pre = [coord_pre;vec];
        end
    else
         coord_pre = coord_pre(1:num,:,:);
    end
    
    
    vec=[0,0,0];
    if diff_post>0
        for i=1:diff_post
            coord_post = [coord_post;vec];
        end
     else
         coord_post = coord_post(1:num,:,:);
    end
    
    pcwrite(pointCloud(coord_pre(:,:)), dest_pre)
    pcwrite(pointCloud(coord_post(:,:)), dest_post)
    
end





