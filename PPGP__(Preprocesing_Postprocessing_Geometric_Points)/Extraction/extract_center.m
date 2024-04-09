clc
close all
clear
dir_folder='Input address';
files = dir([dir_folder '/S*']);
data_pre_new=[];
data_post_new=[];

try
    for i=1:length(files)
        data_pre_new=[];
        data_post_new=[];
        sample = files(i).name;
        sample='sample number';
        source_pre = [dir_folder '\' sample '\o3\' sample '.pre.o3'];
        source_post = [dir_folder '\' sample '\o3\' sample '.post.o3'];
        
  
        %
        dest_pre = [dir_folder '\' sample '\points-PLY\center\'  sample '.pre_center.ply'];
        dest_post = [dir_folder '\' sample '\points-PLY\center\' sample '.post_center.ply'];
        dest_pre_T = [dir_folder '\' sample '\T_R_ply\center\' sample '.pre_center_T.ply'];
        dest_post_T = [dir_folder '\' sample '\T_R_ply\center\' sample '.post_center_T.ply'];
        %
        Num_pre = o32Num3D(source_pre);
        Num3D_pre = axesvertebrescalc(Num_pre);
        Num3D_pre.axelist=sort(Num3D_pre.axelist);
        
        Num_post = o32Num3D(source_post);
        Num3D_post = axesvertebrescalc(Num_post);
        Num3D_post.axelist=sort(Num3D_post.axelist);
        
        pre_centroids=[];
        post_centroids=[];
        
        [center_pre vect]=axesextract(Num3D_pre);
        center_pre=center_pre(:,7:23)';
        

        
        curve_pre=fnplt(cscvn(center_pre(:,:)'));
        curve_pre=curve_pre';
        length_pre=arclength(curve_pre(:,1), curve_pre(:,2), curve_pre(:,3));
        curve_pre=curve_pre/length_pre;
        center_norm_pre=center_pre/length_pre;
        
     
        pcwrite(pointCloud(curve_pre), dest_pre);
      
        [center_post vect]=axesextract(Num3D_post);
        center_post=center_post(:,7:23)';
        
  
        curve_post=fnplt(cscvn(center_post(:,:)'));
        curve_post=curve_post';
        length_post=arclength(curve_post(:,1), curve_post(:,2), curve_post(:,3));
        curve_post=curve_post/length_post;
        center_norm_post=center_post/length_post;
        
    
        pcwrite(pointCloud(curve_post), dest_post);

  
        disp(['job is done for sample=' sample]);
    end
   
    
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end



