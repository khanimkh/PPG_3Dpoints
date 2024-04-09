function R=rvect2rmat(rvect)
% This function builds the rotation matrix from the rotation vector
%
% rotation matrix: [(absolute x y z * relative X Y Z)]
% rotation vector: [rows: absolute x y z]
% It permits to go from the tangent space to the Manifold -> Exponentiel map
%
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr


if size(rvect,1) < size(rvect,2)
    rvect = rvect';
end

if(size(rvect,1)~=3 || size(rvect,2)~=1 )
    error('rvect should be 3 by 1')
end

angl=sqrt(sum((rvect).^2));
if angl~=0
    n=rvect/angl;
else
    n=[0 0 0];
end

% Rodrigues' Formula
S=[[0 , -n(3) , n(2)];[n(3) , 0 , -n(1)];[-n(2), n(1) , 0]];
R=eye(3,3)+sin(angl)*S+(1-cos(angl))*S^2;



