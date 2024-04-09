
addpath '.\Calculation_Geometrices'
addpath '.\Calculation_Statistiques'
addpath '.\Commands'
addpath '.\Conversion'
addpath '.\Defination'
addpath '.\Extraction'
addpath '.\Visualization'
sample = 'sample number';


%% 1-Convert Predicted Landmarks of Post to O3 file

dir_Input='Input directory';
input_sample_fullname_predicted= [sample '.predicted_CPDNet.ply']
input_sample_fullname_real_2= [sample '.post.ply']

Num_predicted=plytoNum3D(dir_Input,sample, input_sample_fullname_predicted);
Num3D_predicted = axesvertebrescalc(Num_predicted);
transfo_predicted = rigidtransfocalc(Num3D_predicted);

Num_predicted_=plytoNum3D(dir_Input,sample, input_sample_fullname_real_2);
Num3D_predicted_ = axesvertebrescalc(Num_predicted_);
transfo_predicted_ = rigidtransfocalc(Num3D_predicted_);

diff_trans=transfo_predicted.trans-transfo_predicted_.trans;
diff_trans=diff_trans.^2;
M_trans=sqrt(mean(diff_trans))
err_trans=mean(M_trans)


diff_rvect=transfo_post.rvect-transfo_predicted.rvect;
diff_rvect=diff_rvect.^2;
M_rvect=sqrt(mean(diff_rvect))
err_rvect=mean(M_rvect)


