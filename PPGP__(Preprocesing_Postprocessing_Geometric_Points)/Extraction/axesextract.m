function [centre vect]=axesextract(Num3D) %#ok<STOUT>
%This function permit to extract the cordinates values of the relative axes
%form a Num3D structure for simpliflied treatment in two matrices: 
%  centre -> relative axis origin
%               [ (absolute x y z)*Vertebrae N°]
%  vect -> relative axis matrices
%               [ Vertebrae N°*(absolute x y z)*(relative X Y Z)]
%
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr

% Initialisation
Init;

% Extraction
for i=Num3D.axelist
    eval(['centre(1,', num2str(i) ,')=Num3D.' , cell2mat(Vertebres(i)) , '.axe.centre.x;']);
    eval(['centre(2,', num2str(i) ,')=Num3D.' , cell2mat(Vertebres(i)) , '.axe.centre.y;']);
    eval(['centre(3,', num2str(i) ,')=Num3D.' , cell2mat(Vertebres(i)) , '.axe.centre.z;']);

    eval(['vect(', num2str(i) ,',1,1)=Num3D.' , cell2mat(Vertebres(i)) , '.axe.X.x;']);
    eval(['vect(', num2str(i) ,',2,1)=Num3D.' , cell2mat(Vertebres(i)) , '.axe.X.y;']);
    eval(['vect(', num2str(i) ,',3,1)=Num3D.' , cell2mat(Vertebres(i)) , '.axe.X.z;']);

    eval(['vect(', num2str(i) ,',1,2)=Num3D.' , cell2mat(Vertebres(i)) , '.axe.Y.x;']);
    eval(['vect(', num2str(i) ,',2,2)=Num3D.' , cell2mat(Vertebres(i)) , '.axe.Y.y;']);
    eval(['vect(', num2str(i) ,',3,2)=Num3D.' , cell2mat(Vertebres(i)) , '.axe.Y.z;']);

    eval(['vect(', num2str(i) ,',1,3)=Num3D.' , cell2mat(Vertebres(i)) , '.axe.Z.x;']);
    eval(['vect(', num2str(i) ,',2,3)=Num3D.' , cell2mat(Vertebres(i)) , '.axe.Z.y;']);
    eval(['vect(', num2str(i) ,',3,3)=Num3D.' , cell2mat(Vertebres(i)) , '.axe.Z.z;']);
    
end