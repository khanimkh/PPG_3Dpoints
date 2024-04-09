clc
close all
clear
files = dir('./S*');

data_pre_new=[];
data_post_new=[];
sample = 'SJ0001333';
folder_address='3-Between 1 year and 2 years';

pre_o3 = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\o3\' sample '.pre.o3'];
post_o3 = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\o3\' sample '.post.o3'];

predicted_center = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\points-PLY\center\' sample '.predicted_2_CNN_Undirect_Cycle_without_N.ply'];
%predicted_r = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\T_R_ply\' sample '.predicted_normilized_R.ply'];

dest_predicted_center = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\points-PLY\center\' sample '.predicted_2_CNN_Undirect_Cycle_without.ply'];
%dest_center = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\points-PLY\center\' sample '.pre_without_normalize_center.ply'];

t_= pcread(predicted_center);
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
    predicted_normilized_center_based_pre=t_vector_*length_pre;
    
    curve_post=fnplt(cscvn(center_post(:,:)'));
    curve_post=curve_post';
    length_post=arclength(curve_post(:,1), curve_post(:,2), curve_post(:,3));
    %pre_normilized=data_pre.Location(:,:)/length_pre;
    predicted_normilized_center_based_post=t_vector_*length_post;
end
if strcmp(type_normalization,'MSN')
    %codes
end

%pcwrite(pointCloud(predicted_normilized_T_based_post), dest_predicted_T);
%save predicted post based on pre
pcwrite(pointCloud(predicted_normilized_center_based_pre), dest_predicted_center);
%save predicted post based on post
%pcwrite(pointCloud(predicted_normilized_center_based_post), dest_predicted_center);

%pcwrite(pointCloud(curve_pre), dest_center);
