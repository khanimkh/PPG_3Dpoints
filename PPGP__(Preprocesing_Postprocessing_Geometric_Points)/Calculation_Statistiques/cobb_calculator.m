clc
clear;
close all;

addpath '.\Calculation_Geometrices'
addpath '.\Calculation_Statistiques'
addpath '.\Commands'
addpath '.\Conversion'
addpath '.\Defination'
addpath '.\Extraction'
addpath '.\Visualization'
sample = 'SJ0001690';
folder_address='3-Between 1 year and 2 years';
type_data=''; %type='trans'

%% Extracting R and T from input data Num3D %%%%%%%%%%%%%%%%
sample_pre = ['Input directory 1\' folder_address '\' sample '\o3\' sample '.pre.o3'];
sample_post = ['Input directory 1\' folder_address '\' sample '\o3\' sample '.post.o3'];

source_pre_center = ['Input directory 1\' folder_address '\' sample '\points-PLY\per_vertebra\' sample '.pre.ply'];
source_post_center = ['Input directory 1\' folder_address '\' sample '\points-PLY\per_vertebra\' sample '.post.ply']; %%4_1000
source_predicted_center = ['Input directory 1\' folder_address '\' sample '\points-PLY\per_vertebra\' sample '.predicted_2_3.ply'];


predicted_t = ['Input directory 1\' folder_address '\' sample '\T_R_ply\' sample '.predicted_2_T_descend_CNN_Undirect_Cycle.ply'];
predicted_r = ['Input directory 1\' folder_address '\' sample '\T_R_ply\' sample '.predicted_1_R_descend_CNN_Undirect.ply']; %_Cycle



    %% copy transform.trans as T and transform.rvect as R to an excel
    %% write T and R in a .ply file with size 24*(T+R)=24*6
    %% Run code python to predict T and R
    %% Copy the result T and R into t and r in this file
    %% Reverse: Adding R and T to pre to have post
    %build transform structure for new R and T
    %% 1- building transfo structure
    %% read pre
% NumPre =o32Num3D(sample_pre);
% Num3D_Pre = axesvertebrescalc(NumPre);
% 
% NumPost =o32Num3D(sample_post);
% Num3D_Post = axesvertebrescalc(NumPost);
% [centre vect]=axesextract(Num3D_Post);
if strcmp(type_data,'trans')   
    %% read predicted t
    t_= pcread(predicted_t);
    t_vector_=t_.Location();
    
    %% read predicted r
    r_= pcread(predicted_r);
    r_vector_=r_.Location();
    
    r_mat_ = zeros(24,3,3);
    %r_mat_post = zeros(16,3,3);
    %for i = 1:23
    for i = 1:23
        r = rvect2rmat(r_vector_(i,:));
        r_mat_(i,:,:) = reshape(r,1,3,3);
    end
    
    % %%
    % [center_pre vect]=axesextract(Num3D_Pre);
    % center_pre=center_pre(:,8:24)';
    %
    % curve_pre=fnplt(cscvn(center_pre(:,:)'));
    % curve_pre=curve_pre';
    % length_pre=arclength(curve_pre(:,1), curve_pre(:,2), curve_pre(:,3));
    
    %% %%%%%Extra: if we want to have normilized data
    % Num_pre_normalized = o32Num3D_Normalized(sample_pre, length_pre);
    % Num3D_pre_normalized = axesvertebrescalc(Num_pre_normalized); %% subtract from ref is done inside this file
    % newtransfo = rigidtransfocalc(Num3D_pre_normalized,0,0,'1');
    %% %%%%%
    
    %% compute transfo for t and r
    % t_vector_post=t_vector_*length_pre;
    newtransfo = rigidtransfocalc(Num3D_Pre,0,0,'1');
    % newtransfo.abstrans = t_vector_post';
    % newtransfo.absrmat = r_mat_post;
    
    oldtransfo=newtransfo;
    
    newtransfo.trans = t_vector_';
    newtransfo.rmat = r_mat_;
    
    % newtransfo_post = rigidtransfocalc(Num3D_Post,0,0,'1');
    t_vector_abs = zeros(3,24);
    % vec=newtransfo_post.abstrans(:,7);
    vec=newtransfo.abstrans(:,7);
    newtransfo.abstrans=t_vector_abs;
    newtransfo.abstrans(:,7)=vec;
    % newtransfo.absrmat=newtransfo_post.absrmat;
    newtransfo.absrmat=r_mat_;
    
    %% calling transfo2Num3D...> rebuildNum3D
    newNum3D = transfo2Num3D(Num3D_Pre,newtransfo);
    
    [centre_predicted vect]=axesextract(newNum3D);
    [centre_post vect]=axesextract(Num3D_Post);
    [centre_pre vect]=axesextract(Num3D_Pre);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for i=1:3
        if i==1
            y=centre_predicted(2,7:23);
            z=centre_predicted(3,7:23);
            text_title='Predicted Post Spine Curve';
            text_df_title='1th and 2th gradient for Predicted Predicted Post';
        elseif i==2
            y=centre_post(2,7:23);
            z=centre_post(3,7:23);
            text_title='Post Spine Curve';
            text_df_title='1th and 2th gradient for Post';
        elseif i==3
            y=centre_pre(2,7:23);
            z=centre_pre(3,7:23);
            text_title='Pre Spine Curve';
            text_df_title='1th and 2th gradient for Pre';
        end
        %pp=spline(z,y);
        zz = linspace(min(z),max(z), 100);
        yy = spline(z,y, zz);
        figure;
        plot(zz,yy);
        title(text_title);
        xlabel('z');
        ylabel('y');
        axis equal
        
        df1=gradient(yy,zz);
        figure;
        L(1)=plot(zz, df1,'color','b');
        hold on
        df2=gradient(df1,zz);
        L(2)=plot(zz,df2,'color','r');
        legend(L,{'df1', 'df2'});
        title(text_df_title);
        xlabel('z');
        ylabel('df1 && df2');
        
        
        %%%%%%%
        [a, I] = findpeaks(df1);
        [max1,index1]=max(a);
        [aa, II] = findpeaks(-df1);
        [max2,index2]=max(aa);
        m1=df1(I(index1));
        m2=df1(II(index2));
        %%%%%%%
        %     m1=max(df1);
        %     m2=min(df1);
        theta1=atan(m1);
        theta2=atan(m2);
        cobb=theta1-theta2;
        D=rad2deg(cobb);
        
        if i==1
            disp(['cobb_predicted: ', num2str(D)]);
        elseif i==2
            disp(['cobb_post: ', num2str(D)]);
        elseif i==3
            disp(['cobb_pre: ', num2str(D)]);
        end
    end
else
    
    centre_post=pcread(source_post_center);
    centre_post=centre_post.Location';
    centre_pre=pcread(source_pre_center);
    centre_pre=centre_pre.Location';
    centre_predicted=pcread(source_predicted_center);
    centre_predicted=centre_predicted.Location';
    
    for i=1:3
        if i==1
            y=centre_predicted(2,:);
            z=centre_predicted(3,:);
            y=smoothdata(y,'gaussian');
            z=smoothdata(z,'gaussian');
        
            text_title='Predicted Post Spine Curve';
            text_df_title='1th and 2th gradient for Predicted Predicted Post';
        elseif i==2
            y=centre_post(2,:);
            z=centre_post(3,:);
            text_title='Post Spine Curve';
            text_df_title='1th and 2th gradient for Post';
        elseif i==3
            y=centre_pre(2,:);
            z=centre_pre(3,:);
       
            text_title='Pre Spine Curve';
            text_df_title='1th and 2th gradient for Pre';
        end
        z=unique(z,'stable');
        y=unique(y,'stable');
        size_z=size(z,2);
        y=y(1:size_z);
        zz = linspace(min(z),max(z), 100);
        yy = spline(z,y, zz);
        figure;
        plot(zz,yy);
        title(text_title);
        xlabel('z');
        ylabel('y');
        axis equal
        
        df1=gradient(yy,zz);
        figure;
        L(1)=plot(zz, df1,'color','b');
        hold on
        df2=gradient(df1,zz);
        L(2)=plot(zz,df2,'color','r');
        legend(L,{'df1', 'df2'});
        title(text_df_title);
        xlabel('z');
        ylabel('df1 && df2');
        
        
        %%%%%%%
        [a, I] = findpeaks(df1);
        [max1,index1]=max(a);
        [aa, II] = findpeaks(-df1);
        [max2,index2]=max(aa);
        m1=df1(I(index1));
        m2=df1(II(index2));
        %%%%%%%
        %     m1=max(df1);
        %     m2=min(df1);
        theta1=atan(m1);
        theta2=atan(m2);
        cobb=theta1-theta2;
        D=rad2deg(cobb);
        
        if i==1
            disp(['cobb_predicted: ', num2str(D)]);
        elseif i==2
            disp(['cobb_post: ', num2str(D)]);
        elseif i==3
            disp(['cobb_pre: ', num2str(D)]);
        end
    end
end
