function  newNum3D = plytoNum3D(dir_Input, input_sample, input_sample_fullname)

Init;

source_predicted = ['Input address\' input_sample_fullname];

source_pre = ['Input address\sample.o3'];

predicted_landmarks= pcread(source_predicted);
vector=predicted_landmarks.Location();

newNum3D=o32Num3D(source_pre);
i=7; % start from Vertebre_C7

for k=1:6:108
    index=k;
    for j=1:6;
        eval(['newNum3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.x=', num2str(vector(index,1)),';']);
        eval(['newNum3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.y=', num2str(vector(index,2)),';']);
        eval(['newNum3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.z=', num2str(vector(index,3)),';']);
    index=index+1;
    end

    i=i+1;
end

newNum3D;