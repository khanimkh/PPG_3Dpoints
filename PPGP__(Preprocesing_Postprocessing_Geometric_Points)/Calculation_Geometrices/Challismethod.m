function R=Challismethod(x,y)
% This function calculates the rotation matrix from the input axes matrix
% (x) and the output axes matrix (y) using the Challis method (see paper 1995)
% x and y could be of higher dimension, then the calculated rotation is the
% more efficient one to go from the x puncts to the y.
%
% The axis matrices, as the rotation matrix, are defined with:
%            [(x y z absolute coordinates) * (X Y Z relative coordinates)]
%
% Warning: This function needs to have the same orientation of x and y 
% otherwise it will output a symmetry matrix 
%
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr


[rowsx colsx]=size(x);
[rowsy colsy]=size(y);

if rowsx~=rowsy || rowsx~=3
    error('x or y is not in 3 dimension')
end

if colsx~=colsy
    error('x and y doesnot have the same number of puncts')
end

C=1/colsx*y*x';
[U,S,V] = svd(C);
R=U*[[1,0,0];[0,1,0];[0,0,det(U*V')]]*V'; %this step is necessary to prefer rotation matrix to symmetry
