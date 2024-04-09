function [Num3D]=axesvertebrescalc(Num3D)
%This function permits to calculate the axes related to each vertebrae
%using the Gram Schmidt procedure. It will expend the Num3D structure.
%
% The vertebres axes are defined as the local vertebral SRS axe
%     origin -> centre of the vertebral body
%     Z-> centre of the inferior plateau vertebral to the centre of the superior plateau vertebral
%     Y-> mean of the right to left inferior and superior pedicular vector
%     X-> the othonormal complementary
%
% add to Num3D.{Vertebre} struc:
%        .axe.X.x .axe.X.y .axe.X.z -> absolute coordinate (x y z) of the relative X axes 
%        .axe.Y.x .axe.Y.y .axe.Y.z -> absolute coordinate (x y z) of the relative Y axes               
%        .axe.Z.x .axe.Z.y .axe.Z.z -> absolute coordinate (x y z) of the relative Z axes
%        .centre.x .centre.y .centre.z -> absolute coordinate (x y z) of the origin
%
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr

% Initialisation of Vertebres and Landmarks
Init;

% last vertebra translation reference (different system have differents
% absolute axes centres, so the origin is define as the lowest vertebra centre)
eval(['refx=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.x+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.x)/2;']);
eval(['refy=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.y+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.y)/2;']);
eval(['refz=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.z+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.z)/2;']);

for i=Num3D.axelist
    
    clear vectX vectY vectZ
    
    % Calculation of the centre coordinates
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.centre.x=(Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(6)) , '.x+Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(5)) , '.x)/2-refx;']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.centre.y=(Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(6)) , '.y+Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(5)) , '.y)/2-refy;']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.centre.z=(Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(6)) , '.z+Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(5)) , '.z)/2-refz;']);

    % Calculation of the Z axe
    eval(['vectZ(1,1)=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(6)) , '.x-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(5)) , '.x;']);
    eval(['vectZ(2,1)=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(6)) , '.y-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(5)) , '.y;']);
    eval(['vectZ(3,1)=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(6)) , '.z-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(5)) , '.z;']);

    vectZ=vectZ./norm(vectZ);
    
    % Calculation of the Y axe
    
%      %Test: takes only the inferior pedicular vector
%      eval(['vectYx=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(2)) , '.x-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(1)) , '.x;']);
%      eval(['vectYy=Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(2)) , '.y-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(1)) , '.y;']);
%      eval(['vectYz=Num3D.' , cell2mat(Vertebres(i)) , '.' ,
%      cell2mat(Landmarks(2)) , '.z-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(1)) , '.z;']);
    
    % mean of both inferior and superior pedicular vectors
    eval(['vectY(1,1)=(Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(2)) , '.x-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(1)) , '.x+Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(4)) , '.x-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(3)) , '.x)/2;']);
    eval(['vectY(2,1)=(Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(2)) , '.y-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(1)) , '.y+Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(4)) , '.y-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(3)) , '.y)/2;']);
    eval(['vectY(3,1)=(Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(2)) , '.z-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(1)) , '.z+Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(4)) , '.z-Num3D.' ,cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(3)) , '.z)/2;']);

    
    % Gram Schmidt procedure to construct the Y axe
    [vectY]=gramschmidt(vectZ,vectY);
    
    
    % Initialisation of the X coordinate vector 
    vectX=[1 1 1]';
    
    
    % Gram Schmidt procedure to construct the X axe
    [vectX]=gramschmidt([vectZ vectY],vectX);
        
    % If the axe direction isn't good (we want a direct axe: det(axe)=1),
    % invert the x axe coordinate
    if det([vectX  vectY  vectZ])+1<10E-5
        vectX=-vectX; %#ok<NASGU>
    end
        
    % Save in the Num Landmarks
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.X.x=vectX(1);']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.X.y=vectX(2);']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.X.z=vectX(3);']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.Y.x=vectY(1);']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.Y.y=vectY(2);']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.Y.z=vectY(3);']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.Z.x=vectZ(1);']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.Z.y=vectZ(2);']);
    eval(['Num3D.' , cell2mat(Vertebres(i)) , '.axe.Z.z=vectZ(3);']);

end