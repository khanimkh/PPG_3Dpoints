clc
close all
clear

dir_folder='Input address';
files = dir([dir_folder '/S*']);
data_pre_new=[];
data_post_new=[];

% Initialisation of Vertebres and Landmarks
Init;

try
     for i=1:length(files)
        data_pre_new=[];
        data_post_new=[];
        sample = files(i).name;
        
        source_pre = [dir_folder '\' sample '\o3\' sample '.pre.o3'];
        source_post = [dir_folder '\' sample '\o3\' sample '.post.o3'];
        
        dest_pre = [dir_folder '\'  sample '\points-PLY\per_vertebra\'  sample '.pre.ply'];
        dest_post = [dir_folder '\' sample '\points-PLY\per_vertebra\'  sample '.post.ply'];

        for k=[1,2]
            if k==1
                Num3D=o32Num3D(source_pre);
                dest=dest_pre;
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
            elseif k==2
                Num3D=o32Num3D(source_post);
                dest=dest_post;
                eval(['refx(1)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(2)) , '.x+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(1)) , '.x)/2;']);
                eval(['refy(1)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(2)) , '.y+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(1)) , '.y)/2;']);
                eval(['refz(1)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(2)) , '.z+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(1)) , '.z)/2;']);
                
                eval(['refx(2)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(4)) , '.x+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(3)) , '.x)/2;']);
                eval(['refy(2)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(4)) , '.y+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(3)) , '.y)/2;']);
                eval(['refz(2)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(4)) , '.z+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(3)) , '.z)/2;']);
                
                eval(['refx(3)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.x+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.x)/2;']);
                eval(['refy(3)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.y+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.y)/2;']);
                eval(['refz(3)=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.z+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.z)/2;']);
            end
            Landmarks_array=[];
            
            if size(Num3D.axelist,2)==17
                Landmarks_array=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;];
            end
            for i=Num3D.axelist
                Landmarks_XYZ=[];
                % Calculation of the centre coordinates
                k=1;
                index=1;
                for j=1:6;
                    eval(['Landmark_X=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.x-refx(' , num2str(index),');']);
                    eval(['Landmark_Y=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.y-refy(' , num2str(index),');']);
                    eval(['Landmark_Z=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.z-refz(' , num2str(index),');']);
                    Landmarks_XYZ=[Landmarks_XYZ;Landmark_X,Landmark_Y,Landmark_Z];
                    if rem(j , 2 )==0
                        index=index+1;
                    end
                end
                Landmarks_array=[Landmarks_array;Landmarks_XYZ];
            end  
     
            
            pcwrite(pointCloud(Landmarks_array), dest);
        
        end
        disp(['job is done for sample=' sample]);
     end
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end



