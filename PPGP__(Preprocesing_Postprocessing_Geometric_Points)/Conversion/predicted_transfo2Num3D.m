function newNum3D=predicted_transfo2Num3D(dir_folder_, input_sample)

% clc
% clear;
% close all;

addpath '.\Calculation_Geometrices'
addpath '.\Calculation_Statistiques'
addpath '.\Commands'
addpath '.\Conversion'
addpath '.\Defination'
addpath '.\Extraction'
addpath '.\Visualization'
sample = input_sample; 

dir_folder=dir_folder_;
%ascend means dir=1
%descend means dir=-1
dir=-1;

%%

%% Extracting R and T from input data Num3D %%%%%%%%%%%%%%%%
sample_pre = [dir_folder '\' sample '\o3\' sample '.pre.o3'];
% sample_pre = [dir_folder '\' sample '\o3\' sample '.pre.o3'];
sample_post = [dir_folder '\' sample '\o3\' sample '.post.o3'];

% predicted_t = [dir_folder '\' sample '\T_R_ply\' sample '.pre_center_without_normilized_transfo_T.ply'];
% predicted_r = [dir_folder '\' sample '\T_R_ply\' sample '.pre_center_without_normilized_transfo_R.ply'];

predicted_t = [dir_folder '\' sample '\T_R_ply\' sample '.predicted_5_1_T.ply'];
predicted_r = [dir_folder '\' sample '\T_R_ply\' sample '.predicted_5_1_R.ply'];


%% copy transform.trans as T and transform.rvect as R to an excel
%% write T and R in a .ply file with size 24*(T+R)=24*6
%% Run code python to predict T and R
%% Copy the result T and R into t and r in this file
%% Reverse: Adding R and T to pre to have post
%build transform structure for new R and T
%% 1- building transfo structure
%% read pre
NumPre =o32Num3D(sample_pre);
Num3D_Pre = axesvertebrescalc(NumPre);

NumPost =o32Num3D(sample_post);
Num3D_Post = axesvertebrescalc(NumPost);
% [centre vect]=axesextract(Num3D_Post);

%% read predicted t
t_= pcread(predicted_t);
t_vector_=t_.Location();

%% read predicted r
r_= pcread(predicted_r);
r_vector_=r_.Location();

r_mat_ = zeros(24,3,3);
%r_mat_post = zeros(16,3,3);
%for i = 1:23
for i = 1:24
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
% newtransfo = rigidtransfocalc(Num3D_pre_normalized,0,0,dir);
%% %%%%%

%% compute transfo for t and r
% t_vector_post=t_vector_*length_pre;
newtransfo = rigidtransfocalc(Num3D_Pre,0,0,dir);
newtransfo_post = rigidtransfocalc(Num3D_Post,0,0,dir);
% newtransfo.abstrans = t_vector_post';
% newtransfo.absrmat = r_mat_post;

oldtransfo=newtransfo;

newtransfo.trans = t_vector_';
newtransfo.rmat = r_mat_;

% newtransfo_post = rigidtransfocalc(Num3D_Post,0,0,dir);

if dir==1
    newtransfo.transfolist=Num3D_Pre.axelist((Num3D_Pre.axelist(1:end-1)-Num3D_Pre.axelist(2:end)==-1).*(1:length(Num3D_Pre.axelist(1:end-1))));
    newtransfo.transfolist=sort(newtransfo.transfolist,'ascend');
    newtransfo.dir=1;
end
if dir==-1
    newtransfo.transfolist=Num3D_Pre.axelist((Num3D_Pre.axelist(1:end-1)-Num3D_Pre.axelist(2:end)==-1).*(1:length(Num3D_Pre.axelist(1:end-1))))+1;
    newtransfo.transfolist=sort(newtransfo.transfolist,'descend');
    newtransfo.dir=-1;
end
    
t_vector_abs = zeros(3,24);
r_vector_abs = zeros(24,3,3);
if dir==1
    id=7;
else
    id=24;
end

%% should be improved by replacing from predicted result not pre and not post
vec_abst=newtransfo.abstrans(:,id);
% vec_abst=newtransfo_post.abstrans(:,id);
newtransfo.abstrans=t_vector_abs;
newtransfo.abstrans(:,id)=vec_abst;
% newtransfo.absrmat=newtransfo_post.absrmat;
%newtransfo.absrmat=r_mat_;

%% should be improved by replacing from predicted result not pre and not post
vec_absr=newtransfo.absrmat(id,:,:);
% vec_absr=newtransfo_post.absrmat(id,:,:);
newtransfo.absrmat=r_vector_abs;
newtransfo.absrmat(id,:,:)=vec_absr;

%% calling transfo2Num3D...> rebuildNum3D

% NumPredicted =o32Num3D(sample_o3);
% NumPredicted = axesvertebrescalc(NumPredicted);
% newNum3D = transfo2Num3D(NumPredicted,newtransfo);

newNum3D = transfo2Num3D(Num3D_Pre,newtransfo);

[centre_1 vect_1]=axesextract(newNum3D);
[centre vect]=axesextract(Num3D_Pre);

%% to draw the shapes
% plotvertebresaxes(newNum3D)
% plotvertebresaxes(Num3D_Post)
% plotvertebresaxes(Num3D_Pre)


% curve_pre=fnplt(cscvn(centre_1(:,:)));
% points=pointCloud(curve_pre');
% pointscolor=uint8(zeros(points.Count,3));
% %pointscolor=uint8(zeros(data_predicted_center.Count,3));
% pointscolor(:,1)=255;
% pointscolor(:,2)=255;
% pointscolor(:,3)=51;
% points.Color=pointscolor;
% pcshow(points);
% % data_predicted_center.Color=pointscolor;
% % pcshow(data_predicted_center);
% hold on;
% L=legend('\color{blue}preoperative shape','\color{red}real postoperative shape','\color{yellow}predicted postoperative shape');




