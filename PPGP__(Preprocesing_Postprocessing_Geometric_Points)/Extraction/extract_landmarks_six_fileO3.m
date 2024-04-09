function extract_landmarks_six_fileO3(Num3D, smaple_name)

Init;
sample_post= [smaple_name '.post_new.ply'];
dest_post= ['Input address\' sample_post];



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
