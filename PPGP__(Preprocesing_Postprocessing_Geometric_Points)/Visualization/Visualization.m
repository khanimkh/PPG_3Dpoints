clc
close all
clear

sample = 'SJ0000883';
source_pre = ['Input address\' sample '\points-PLY\per_vertebra\' sample '.pre.ply'];
source_post = ['Input address\' sample '\points-PLY\per_vertebra\' sample '.post.ply'];
source_post_predicted1 = ['output address\' sample '\points-PLY\per_vertebra\' sample '.predicted_P2P.ply'];
source_post_predicted2 = ['output address\' sample '\points-PLY\per_vertebra\' sample '.predicted_PDN_4.ply'];
source_post_predicted3 = ['output address\' sample '\points-PLY\per_vertebra\' sample '.predicted_CPDN_1.ply'];
source_post_predicted4 = ['output address\' sample '\points-PLY\per_vertebra\' sample '.predicted_CPDN_noMeta_2.ply'];

data_pre= pcread(source_pre);
data_post= pcread(source_post);
data_post_predicted1= pcread(source_post_predicted1);
data_post_predicted2= pcread(source_post_predicted2);
data_post_predicted3= pcread(source_post_predicted3);
data_post_predicted4= pcread(source_post_predicted4);


pointscolor=uint8(zeros(data_pre.Count,3));
pointscolor(:,1)=255;
pointscolor(:,2)=255;
pointscolor(:,3)=0;
data_pre.Color=pointscolor;

pointscolor_post_predict2=uint8(zeros(data_post.Count,3));
pointscolor_post_predict2(:,1)=0;
pointscolor_post_predict2(:,2)=255;
pointscolor_post_predict2(:,3)=0;
data_post.Color=pointscolor_post_predict2;

pointscolor_post_predict1=uint8(zeros(data_post_predicted1.Count,3));
pointscolor_post_predict1(:,1)=255;
pointscolor_post_predict1(:,2)=0;
pointscolor_post_predict1(:,3)=0;
data_post_predicted1.Color=pointscolor_post_predict1;

pointscolor_post_predict2=uint8(zeros(data_post_predicted2.Count,3));
pointscolor_post_predict2(:,1)=255;
pointscolor_post_predict2(:,2)=0;
pointscolor_post_predict2(:,3)=0;
data_post_predicted2.Color=pointscolor_post_predict2;

pointscolor_post_predict3=uint8(zeros(data_post_predicted3.Count,3));
pointscolor_post_predict3(:,1)=255;
pointscolor_post_predict3(:,2)=0;
pointscolor_post_predict3(:,3)=0;
data_post_predicted3.Color=pointscolor_post_predict3;

pointscolor_post_predict4=uint8(zeros(data_post_predicted4.Count,3));
pointscolor_post_predict4(:,1)=255;
pointscolor_post_predict4(:,2)=0;
pointscolor_post_predict4(:,3)=0;
data_post_predicted4.Color=pointscolor_post_predict4;

% ShowSpine3D(data_pre.Location);
% ShowSpine3D(data_post.Location);
figure
hold on;
ShowSpine3D(data_post_predicted1.Location,[0, 0.75, 0.75]); %cyan--P2PNET
hold on;
ShowSpine3D(data_post_predicted2.Location,[0.75, 0, 0.75]); %purple color--PDNET
hold on;
ShowSpine3D(data_post_predicted3.Location,[1,0,0]); %red--CPDNet_Meta
hold on;
ShowSpine3D(data_post_predicted4.Location,[0.9290, 0.6940, 0.1250]); %yelow--CPDNet_noMeta
hold on;
ShowSpine3D(data_post.Location,[0, 0.5, 0]); %green--Real
% legend('cyan--P2PNET','green--Real' )
% figure;
% pcshow(data_pre) %yellow
% % hold on;
% figure;
% pcshow(data_post)%green
% hold on;
% figure;
% pcshow(data_post_predicted)%red
% fnplt(cscvn(data_pre.Location(:,:)'));
% fnplt(cscvn(data_post.Location(:,:)'));

%hold off;

