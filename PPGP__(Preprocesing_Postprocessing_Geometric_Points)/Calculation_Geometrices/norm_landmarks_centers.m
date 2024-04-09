clc
close all
clear
dir_Input= 'Input directory 1';
files = dir([dir_Input '/S*']);
data_pre_new=[];
data_post_new=[];

type_normalization='LCN'; %'LCN' 'lengh_curve_norm'; %'MSN' 'mean_std_norm';

try
    for i=1:length(files)
        data_pre_new=[];
        data_post_new=[];
        sample = files(i).name;
        pre_o3 = [dir_Input '\' sample '\o3\' sample '.pre.o3'];
        post_o3 = [dir_Input '\' sample '\o3\' sample '.post.o3'];
        
        source_pre = [dir_Input '\' sample '\points-PLY\per_vertebra\' sample '.pre.ply'];
        source_post = [dir_Input '\' sample '\points-PLY\per_vertebra\' sample '.post.ply'];
        
        dest_pre = [dir_Input '\' sample '\points-PLY\per_vertebra\' sample '.pre_normalized_' type_normalization '.ply'];
        dest_post = [dir_Input '\' sample '\points-PLY\per_vertebra\' sample '.post_normalized_' type_normalization '.ply'];
        
%         dest_pre_T = [dir_Input '\' sample '\T_R_ply\' sample '.pre_normalized_T_' type_normalization '.ply'];
%         dest_post_T = [dir_Input '\' sample '\T_R_ply\' sample '.post_normalized_T_' type_normalization '.ply'];
        
        %         dest_pre = ['.\Test_4_Center_with_All_normilized\' sample '.pre_normilized.ply'];
        %         dest_post = ['.\Test_4_Center_with_All_normilized\' sample '.post_normilized.ply'];
        %
        %     dest_pre_T = ['.\Test_3_Center_Meta_T_with_All_previous\' sample '.pre_normilized_T.ply'];
        %     dest_post_T = ['.\Test_3_Center_Meta_T_with_All_previous\' sample '.post_normilized_T.ply'];
        
        Num_pre = o32Num3D(pre_o3);
        Num3D_pre = axesvertebrescalc(Num_pre);
        Num3D_pre.axelist=sort(Num3D_pre.axelist);
        [ref_x_pre, ref_y_pre, ref_z_pre]=extract_ref(Num3D_pre);
        ref_pre=[ref_x_pre; ref_y_pre; ref_z_pre];
        %
        Num_post = o32Num3D(post_o3);
        Num3D_post = axesvertebrescalc(Num_post);
        Num3D_post.axelist=sort(Num3D_post.axelist);
        [ref_x_post, ref_y_post, ref_z_post]=extract_ref(Num3D_post);
        ref_post=[ref_x_post;ref_y_post;ref_z_post];
        
        data_pre= pcread(source_pre);
        data_post= pcread(source_post);
       
        j=1;
        i=1;
        for k=6:6:108
            
            %         vertebra_post = data_post.Location(j:k,:);
            %         vertebra_pre = data_pre.Location(j:k,:);
            
            %         vertebra_center_post=center_post(i,:);
            %         vertebra_center_post=((vertebra_post(6,:)+vertebra_post(5,:))/2)-ref_post';
            %         delta_x_post=center_post(1)-ref_x_post;
            %         delta_y_post=center_post(2)-ref_y_post;
            %         delta_z_post=center_post(3)-ref_z_post;
            
            %         vertebra_center_pre=center_pre(i,:);
            %         vertebra_center_pre=((vertebra_pre(6,:)+vertebra_pre(5,:))/2)-ref_pre';
            %         delta_x_pre=center_pre(1)-ref_x_pre;
            %         delta_y_pre=center_pre(2)-ref_y_pre;
            %         delta_z_pre=center_pre(3)-ref_z_pre;
            
            x_post = data_post.Location(j:k,1);
            x_pre = data_pre.Location(j:k,1);
            
            %         x_post = x_post-vertebra_center_post(1);
            %         x_pre = x_pre-vertebra_center_pre(1);
            
            x_post = x_post-ref_x_post;
            x_pre = x_pre-ref_x_pre;
            %x_pre = x_pre-ref_x_pre(6);
            
            y_post = data_post.Location(j:k,2);
            y_pre = data_pre.Location(j:k,2);
            
            %         y_post = y_post-vertebra_center_post(2);
            %         y_pre = y_pre-vertebra_center_pre(2);
            
            y_post = y_post-ref_y_post;
            y_pre = y_pre-ref_y_pre;
            %y_pre = y_pre-ref_y_pre(6);
            
            
            z_post = data_post.Location(j:k,3);
            z_pre = data_pre.Location(j:k,3);
            
            %         z_post = z_post-vertebra_center_post(3);
            %         z_pre = z_pre-vertebra_center_pre(3);
            
            z_post = z_post-ref_z_post;
            z_pre = z_pre-ref_z_pre;
            %z_pre = z_pre-ref_z_pre(6);
            
            j=j+6;
            i=i+1;
            
            per_vertebra_pre= [x_pre,y_pre,z_pre];
            data_pre_new = [data_pre_new; per_vertebra_pre];
            
            per_vertebra_post= [x_post,y_post,z_post];
            data_post_new = [data_post_new; per_vertebra_post];
        end
        
        %    %pcshow(data_pre)
        %    %hold on;
        %    %fnplt(cscvn(data_pre(:,:)'));
        
        %%%%%%%% Compute Centeres %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [center_pre vect]=axesextract(Num3D_pre);
        center_pre=center_pre(:,8:24)';
        
        [center_post vect]=axesextract(Num3D_post);
        center_post=center_post(:,8:24)';
        
        %%%%% normalization method 1: uisng lengh of curve
        if strcmp(type_normalization,'LCN')
            %%%%%%%% PRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            curve_pre=fnplt(cscvn(center_pre(:,:)'));
            curve_pre=curve_pre';
            length_pre=arclength(curve_pre(:,1), curve_pre(:,2), curve_pre(:,3));
            %     pre_normilized=data_pre.Location(:,:)/length_pre;
            pre_normilized=data_pre_new/length_pre;
            center_pre_normalized=center_pre/length_pre;
            
            %    pcshow(pre_normilized)
            %    hold on;
            %    %fnplt(cscvn(data_pre(:,:)'));
            
            %%%%%%%% POST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            curve_post=fnplt(cscvn(center_post(:,:)'));
            curve_post=curve_post';
            length_post=arclength(curve_post(:,1), curve_post(:,2), curve_post(:,3));
            %     post_normilized=data_post.Location(:,:)/length_post;
            post_normilized=data_post_new/length_post;
            center_post_normalized=center_post/length_post;
            
            %%%%% normalization method 2: uisng lengh of curve
        end
        if strcmp(type_normalization,'MSN')
            mean_x= mean(data_pre_new(:,1));
            mean_y= mean(data_pre_new(:,2));
            mean_z= mean(data_pre_new(:,3));
            std_x= std(data_pre_new(:,1));
            std_y= std(data_pre_new(:,2));
            std_z= std(data_pre_new(:,3));
            x_norm_pre=(data_pre_new(:,1)-mean_x)/std_x;
            y_norm_pre=(data_pre_new(:,2)-mean_y)/std_y;
            z_norm_pre=(data_pre_new(:,3)-mean_z)/std_z;
            pre_normilized=[x_norm_pre,y_norm_pre,z_norm_pre];
            center_pre_normalized= normalize(center_pre);
            
            
            mean_x= mean(data_post_new(:,1));
            mean_y= mean(data_post_new(:,2));
            mean_z= mean(data_post_new(:,3));
            std_x= std(data_post_new(:,1));
            std_y= std(data_post_new(:,2));
            std_z= std(data_post_new(:,3));
            x_norm_post=(data_post_new(:,1)-mean_x)/std_x;
            y_norm_post=(data_post_new(:,2)-mean_y)/std_y;
            z_norm_post=(data_post_new(:,3)-mean_z)/std_z;
            post_normilized=[x_norm_post,y_norm_post,z_norm_post];
            center_post_normalized= normalize(center_post);
        end
        
        
        %%%%%%%%%%%%%%%%%%%%
        %    pcshow(pre_normilized);
        %    hold on;
        %    pcshow(post_normilized);
        %    hold on;
        %fnplt(cscvn(data_pre(:,:)'));
        pcwrite(pointCloud(pre_normilized), dest_pre)
        pcwrite(pointCloud(post_normilized), dest_post)
        
        direction=1;
        trans_pre=zeros(16,3);
        for i=1:1:16
            trans_pre(i,:)=center_pre_normalized(i+direction*1,:)-center_pre_normalized(i,:);
        end
        
        direction=1;
        trans_post=zeros(16,3);
        for i=1:1:16
            trans_post(i,:)=center_post_normalized(i+direction*1,:)-center_post_normalized(i,:);
        end
        
%         pcwrite(pointCloud(trans_pre), dest_pre_T);
%         pcwrite(pointCloud(trans_post), dest_post_T);
        disp(['job is done for sample=' sample]);
    end

catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end