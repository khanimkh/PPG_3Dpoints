clc
close all
clear
files = dir('./S*');

data_pre_new=[];
data_post_new=[];

type_normalization='LCN'; %'LCN' 'lengh_curve_norm'; %'MSN' 'mean_std_norm';
sample = 'sample number';
folder_address='Input directory 2';

pre_o3 = ['Input directory 1\' folder_address '\' sample '\o3\' sample '.pre.o3'];
post_o3 = ['Input directory 1\' folder_address '\' sample '\o3\' sample '.post.o3'];

predicted = ['Input directory 1\' folder_address '\' sample '\points-PLY\per_vertebra\' sample '.predicted_landmarks_3_4.ply'];

dest_predicted = ['Input directory 1\' folder_address '\' sample '\points-PLY\per_vertebra\' sample '.predicted_landmarks_3_4_RevNorm.ply'];

t_= pcread(predicted);
t_vector_=t_.Location();

Num_pre = o32Num3D(pre_o3);
Num3D_pre = axesvertebrescalc(Num_pre);
Num3D_pre.axelist=sort(Num3D_pre.axelist);

Num_post = o32Num3D(post_o3);
Num3D_post = axesvertebrescalc(Num_post);

%%%%% normalization method 1: uisng lengh of curve
if strcmp(type_normalization,'LCN')
    [center_pre vect]=axesextract(Num3D_pre);
    center_pre=center_pre(:,8:24)';
    
    [center_post vect]=axesextract(Num3D_post);
    center_post=center_post(:,8:24)';
    
    curve_pre=fnplt(cscvn(center_pre(:,:)'));
    curve_pre=curve_pre';
    length_pre=arclength(curve_pre(:,1), curve_pre(:,2), curve_pre(:,3));
    %pre_normilized=data_pre.Location(:,:)/length_pre;
    predicted_normilized_based_pre=t_vector_*length_pre;
%     z=abs(predicted_normilized_based_pre(:,3));
%     predicted_normilized_based_pre(:,3)=z;
    
%     curve_post=fnplt(cscvn(center_post(:,:)'));
%     curve_post=curve_post';
%     length_post=arclength(curve_post(:,1), curve_post(:,2), curve_post(:,3));
%     %pre_normilized=data_pre.Location(:,:)/length_pre;
%     predicted_normilized_based_post=t_vector_*length_post;
   
end
if strcmp(type_normalization,'MSN')
    %codes
end

%pcwrite(pointCloud(predicted_normilized_T_based_post), dest_predicted_T);
%save predicted post based on pre
pcwrite(pointCloud(predicted_normilized_based_pre), dest_predicted);
%save predicted post based on post
%pcwrite(pointCloud(predicted_normilized_based_post), dest_predicted_center);

%pcwrite(pointCloud(curve_pre), dest_center);
