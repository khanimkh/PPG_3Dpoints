clc
close all
clear
files = dir('./S*');
for i=1:length(files)
    sample = files(i).name;
    source_pre = ['.\' sample '\points-PLY\' sample '.pre_old.ply'];
    source_post = ['.\' sample '\points-PLY\' sample '.post_old.ply'];
    
    dest_pre = ['.\' sample '\points-PLY\' sample '.pre_new_xy.ply'];
    dest_post = ['.\' sample '\points-PLY\' sample '.post_new_xy.ply'];
    
    data_pre= pcread(source_pre);
    data_post= pcread(source_post);
    
     
    x_post = data_post.Location(:,1);
    x_pre = data_pre.Location(:,1);
    x_pre = (x_pre-min(x_pre))/(max(x_pre)-min(x_pre));
    x_post = (x_post-min(x_post))/(max(x_post)-min(x_post));

    y_post = data_post.Location(:,2);
    y_pre = data_pre.Location(:,2);
    y_pre = (y_pre-min(y_pre))/(max(y_pre)-min(y_pre));
    y_post = (y_post-min(y_post))/(max(y_post)-min(y_post));
% % 
% %     
    z_post = data_post.Location(:,3);
    z_pre = data_pre.Location(:,3);
    z_pre = (z_pre-min(z_pre))/(max(z_pre)-min(z_pre));
    z_post = (z_post-min(z_post))/(max(z_post)-min(z_post));
% % %   
%     x_mean = mean(data_pre.Location(:,1));
%     x_std = std(data_pre.Location(:,1));
%     y_mean = mean(data_pre.Location(:,2));
%     y_std = std(data_pre.Location(:,2));
%     z_mean = mean(data_pre.Location(:,3));
%     z_std = std(data_pre.Location(:,3));    
% % % %     
%     x_pre = (data_pre.Location(:,1)-x_mean)/(x_std);
%     x_post = (data_post.Location(:,1)-x_mean)/(x_std);
%     y_pre = (data_pre.Location(:,2)-y_mean)/(y_std);
%     y_post = (data_post.Location(:,2)-y_mean)/(y_std);
%     z_pre = (data_pre.Location(:,3)-z_mean)/(z_std);
%     z_post = (data_post.Location(:,3)-z_mean)/(z_std);
    
    data_pre_new = pointCloud([x_pre,y_pre,z_pre]);
    pcwrite(data_pre_new, dest_pre)
    
    data_post_new = pointCloud([x_post,y_post,z_post]);
    pcwrite(data_post_new, dest_post)
end