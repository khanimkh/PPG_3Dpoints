clc
clear
close all

sample_test='sample number';
predicted_point = ['Input directory 1\' sample_test '.post_new.ply'];
real_point = ['Input directory 2\' sample_test '.post.ply'];


%load([sample_test '.mat']);
predict= pcread(predicted_point);
predict_vector_1=predict.Location();

real= pcread(real_point);
real_vector_1=real.Location();

% diff_predicted=predict_vector_1(index1,:)-predict_vector_1(index2,:);
% diff_real=real_vector_1(index1,:)-real_vector_1(index2,:);
% diff=diff_predicted-diff_real

diff=predict_vector_1-real_vector_1

diff=diff.^2
M=sqrt(mean(diff))
err=mean(M)

%err = rmse(diff_predicted,diff_real);
