clc
close all
clear

dir_folder='Input directory 1';
files = dir([dir_folder '/*.o3']);
data_pre_new=[];
data_post_new=[];
RMSE_total=[];
dir_Input= 'Input directory 2';
% Initialisation of Vertebres and Landmarks
Init;

try
%     for i=1:length(files)
        data_pre_new=[];
        data_post_new=[];
        RMSE=[];
%         sample = files(i).name([1:9]);
        sample='sample number';
        
        dest = [dir_Input '\' sample '\T_R_ply\' sample '.predicted_5_1.ply'];
        source_post = [dir_Input '\' sample '\points-PLY\per_vertebra\' sample '.post.ply'];
        source_post_predicted = [dir_folder '\' sample '.predicted_5_1.o3'];

        
        landmarks_p= pcread(source_post);
        Landmarks_post=landmarks_p.Location();
        
        Num3D=o32Num3D(source_post_predicted);

        
        %% extract ref
        % last vertebra translation reference (different system have differents
        % absolute axes centres, so the origin is define as the lowest vertebra centre)
        eval(['refx(1)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(2)) , '.x+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(1)) , '.x)/2;']);
        eval(['refy(1)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(2)) , '.y+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(1)) , '.y)/2;']);
        eval(['refz(1)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(2)) , '.z+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(1)) , '.z)/2;']);
        
        eval(['refx(2)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(4)) , '.x+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(3)) , '.x)/2;']);
        eval(['refy(2)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(4)) , '.y+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(3)) , '.y)/2;']);
        eval(['refz(2)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(4)) , '.z+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(3)) , '.z)/2;']);
        
        eval(['refx(3)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.x+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.x)/2;']);
        eval(['refy(3)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.y+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.y)/2;']);
        eval(['refz(3)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.z+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.z)/2;']);
        
        %% extract landmarks
        Landmarks_post_predicted=[];
        
        if size(Num3D.axelist,2)==17
            Landmarks_post_predicted=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;];
        end
        for i=Num3D.axelist
            Landmarks_XYZ=[];
            % Calculation of the centre coordinates
            k=1;
            index=1;
            for j=1:6;
%                 eval(['Landmark_X=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.x-refx(' , num2str(index),');']);
%                 eval(['Landmark_Y=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.y-refy(' , num2str(index),');']);
%                 eval(['Landmark_Z=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.z-refz(' , num2str(index),');']);
                eval(['Landmark_X=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.x;']);
                eval(['Landmark_Y=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.y;']);
                eval(['Landmark_Z=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.z;']);
                Landmarks_XYZ=[Landmarks_XYZ;Landmark_X,Landmark_Y,Landmark_Z];
                if rem(j , 2 )==0
                    index=index+1;
                end
            end
            Landmarks_post_predicted=[Landmarks_post_predicted;Landmarks_XYZ];
        end
        
%         %% normalization LCN
%         %% extracting center of predicted o3
%         Num3D_predicted = axesvertebrescalc(Num3D);
%         [center_predicted vect]=axesextract(Num3D_predicted);
%         center_predicted=center_predicted(:,8:24)';
%         %% extracting center of pre o3
% %         Num3D_predicted = axesvertebrescalc(Num3D_pre);
% %         [center_predicted vect]=axesextract(Num3D_predicted);
% %         center_predicted=center_predicted(:,8:24)';
%         
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         curve_pre=fnplt(cscvn(center_predicted(:,:)'));
%         curve_pre=curve_pre';
%         length_pre=arclength(curve_pre(:,1), curve_pre(:,2), curve_pre(:,3));
%         %     pre_normilized=data_pre.Location(:,:)/length_pre;
%         predicted_normilized=Landmarks_post_predicted/length_pre;
        
        %% compute accuracy 3D rec
        z=abs(Landmarks_post_predicted(:,3));
        Landmarks_post_predicted(:,3)=z;
        pcwrite(pointCloud(Landmarks_post_predicted), dest);
       
        %err = immse(Landmarks_post_predicted,Landmarks_post);
        RMSE = mean(sqrt(sum((Landmarks_post_predicted - Landmarks_post).^2)));
        RMSE_total=[RMSE_total;RMSE];

        %disp(['err for sample=' sample ' is = ' string(err)]);
%     end
err=sum(RMSE_total);
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end
    
    
    
