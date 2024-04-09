function [transfo]=rigidtransfocalc(Num3D,t,r,varargin)
%This function permits to calculate the intervertebrals rigid
%transformations from the Num3D structure.
%It can be done in both directions :
%    argument: direction=1->up-down direction=-1->down-up (default 1)
%
% It will create the structure transfo which contains the absolute
% transformations of each existing Vertebrae (from the  (0,0,0) point and
% the (1,0,0) (0,1,0) (0,0,1) basis). And the relative rigid
% transformations for each consecutive couple of Vertebrae. It will save the 
% rigid transformations in the fields of the input vertebrea.
%
% transfo struct: 
%        .absrmat -> absolute rotations matrices from the (1,0,0) (0,1,0) (0,0,1) basis 
%                        [Vertebrae N° * (absolute x y z * relative1 X Y Z)]
%        .abstrans -> absolute translation vector from the (0,0,0) point 
%                        [(absolute x y z) * Vertebrae N°]
%        .rmat -> rotation matrice from the actual Vertebrea axe to the next in the direction 
%                        [Vertebrae N° * (relative1 X Y Z * relative2 X' Y' Z')]
%        .trans -> translation vector from the actual Vertebrea axe to the next in the direction in
%                  the relative basis
%                        [(relative1 X Y Z) * Vertebrae N°]
%        .transfolist -> index of existing rigid transformations between consecutive Vertebras, 
%                        the numbers are the input Vertebrae Number [see Init.m]
%        .dir -> direction=1 : up-down, direction=-1 : down-up
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr

% Argument definition
if nargin<2
    direction=1;
else
    direction=cell2mat(varargin(1));
end
if direction~=1 && direction~=-1
    direction=1;
end

% Initialisation :::: transfo.dir, transfo.transfolist, transfo.absrmat,
% transfo.trans, transfo.rmat, 
Init;

transfo.absrmat=zeros(length(Vertebres),3,3);
transfo.abstrans=zeros(3,length(Vertebres));
transfo.rmat=zeros(length(Vertebres),3,3);
transfo.trans=zeros(3,length(Vertebres));
transfo.rvect=zeros(3,length(Vertebres));


% Security -> reorder the Vertebrea list from the Num3D struct
Num3D.axelist=sort(Num3D.axelist);
 
if length(Num3D.axelist)>=1
    
    %extract the axes information
    [centre, vect]=axesextract(Num3D);
    
    %%%%%Normalizartion between 0 and 1
%     center_=centre(:,7:23)';
%     center_curve=fnplt(cscvn(center_(:,:)'));
%     center_curve_=center_curve';
%     length_curve=arclength(center_curve_(:,1), center_curve_(:,2), center_curve_(:,3));
%     center_normalized=center_/length_curve;
%     center_normalized=center_normalized';
%     %%%%%
    
    % Creation of the list correspoonding to the consecutive Vertebrae in
    % the choosed direction (the list will represent the number of the input Vertebrae 
    if direction==1
        transfo.transfolist=Num3D.axelist((Num3D.axelist(1:end-1)-Num3D.axelist(2:end)==-1).*(1:length(Num3D.axelist(1:end-1))));
        transfo.transfolist=sort(transfo.transfolist,'ascend');
    end
    if direction==-1
        transfo.transfolist=Num3D.axelist((Num3D.axelist(1:end-1)-Num3D.axelist(2:end)==-1).*(1:length(Num3D.axelist(1:end-1))))+1;
        transfo.transfolist=sort(transfo.transfolist,'descend');
    end
    
    transfo.axelist=Num3D.axelist;
    transfo.dir=direction;
    transfo.instrum=Num3D.instrum;
    transfo.apex=Num3D.apex;
    
%%    Rigid transfo calculation
    for i=transfo.transfolist
        % Calcutation of the translation vector
        transfo.trans(:,i)=centre(:,i+direction*1)-centre(:,i);
        
        % Calculation of the rotation matrix input -> output
        R=Challismethod(reshape(vect(i,:,:),3,3),reshape(vect(i+direction*1,:,:),3,3));
        
        transfo.rmat(i,:,:)=reshape(R,1,3,3);
        % Calculation of the rotation vector input -> output
        [transfo.rvect(:,i) transfo.rangle(i) transfo.raxe(:,i)]=rmat2rvect(R);
    end
%     transfo.trans = t;
%     transfo.rmat = r;
    
    % Absolute rigid transformations calculation
%     transfo = abstransforecalc(transfo);
    for i=transfo.axelist
        transfo.abstrans(:,i)=centre(:,i);
        
        % The absolute axe matrix gives already the rotation matrix [take
        % care of the axe direction defined by axesvertebrescalc.m]
        transfo.absrmat(i,:,:)=vect(i,:,:);
        % Calculation of the rotation vector absolute -> Vertebrae
        [transfo.absrvect(:,i), transfo.absrangle(i), transfo.absraxe(:,i)]=rmat2rvect(reshape(vect(i,:,:),3,3));
    end
    
    %we apply here the inverse absolute rotation matrice in order to have the
    %translation vector in the local axes.
    for j=transfo.transfolist
        transfo.trans(:,j)=(reshape(transfo.absrmat(j,:,:),3,3)^(-1))*transfo.trans(:,j);
        %transfo.trans(:,j)=trans(:,j);
        %if absolute translations-----------------------------------------
    end
%     
else %if there is no information -> return an empty struct
    transfo=[];
    disp('In rigidtransfocalc.m -> Empty transfo');
end

