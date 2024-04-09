%% save predicted as o3
clear all;
clc;
input_sample = 'sample';
dir_Data_1='Input directory 1';
dir_Data_2='Input directory 2';

dir_Input= 'Input directory 3'

input_sample_fullname= [input_sample '.post.ply']
output_sample_fullname= [input_sample '.post.o3']
type_data='points'; %'translation';points
if strcmp(type_data,'translation') 
 dir_Data_output_1=[dir_Data_1 '\' output_sample_fullname]
 dir_Data_output_2=[dir_Data_2 '\' output_sample_fullname]
 dir_output= [dir_Input '\' input_sample '\T_R_ply\'  output_sample_fullname];
 newNum3D=predicted_transfo2Num3D(dir_Input, input_sample);
else
 dir_Data_output_1= [dir_Data_1 '\' output_sample_fullname];
 dir_output= [dir_Input '\'  output_sample_fullname ];
 newNum3D=plytoNum3D(dir_Input,input_sample, input_sample_fullname);
end
Num3D2o3(newNum3D,dir_output);
Num3D2o3(newNum3D,dir_Data_output_1);
