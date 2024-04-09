clc
close all
clear

dir_folder_source='Input directory';
files = dir([dir_folder_source '\S*']);

try
    for i=1:length(files)
        sample = files(i).name;

        source_pre = [dir_folder_source '\' sample '.pre_trunk_N.ply'];
        source_post = [dir_folder_source '\' sample '.post_trunk_N.ply'];


        delete(source_pre);
        delete(source_post);

         delete(source_pre_T);
         delete(source_pre_R);

    
        disp(['job is done for sample=' sample]);
        
    end
    
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end
