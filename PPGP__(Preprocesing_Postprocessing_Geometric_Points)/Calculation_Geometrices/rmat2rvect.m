function [rvect rangle raxe]=rmat2rvect(R)
%This function permits to calculate the angle the axe and the rotation
%vector from the rotation matrix.
%
% rotation matrix: [(absolute x y z * relative X Y Z)]
% rotation vector: [rows: absolute x y z]
%It corresponds to the logarithmic map (Manifold to the tangent space)
%
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr

if( size(R,1)~=3 || size(R,2)~=3 || norm(R*R'-eye(3))>1E-10 || abs(det(R)-1)>1E-10 )
    error('R is not a rotation matrix')
end


rangle=acos((trace(R)-1)/2);

if rangle~=0
    matri=(R-R')/(2*sin(rangle));
else %if there is no rotation
    matri=zeros(3,3);
end
raxe=[matri(3,2) ; matri(1,3) ; matri(2,1)];
rvect=raxe*rangle;
