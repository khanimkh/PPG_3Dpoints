function Num3D=rebuildNum3D(Num3D,transfo,rellmpos)
%This function permits to build the new Num3D structure related to a
%transformation structure, given it's old Num3D structure and the relative
%Landmarks positions structure [see meanrelativlandmarkcalc.m].
%This function is used by meanfrechet.m and transfo2Num3D.m
%
% If no information exists on the relative rigid transformation (missing or first Vertebrae)
% or if it is not part of the same statistically consistent transformation mean
% it will build the Vertebres with the absolute rigid transformation
%
% WARNING: This function need to have the absolute transformation directly
% corresponding to the relatives one. DO NOT USE with a deltatransfo (no sense)
%
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr

% Initialisation
Init;
coordabs={'x' , 'y' , 'z'};
coordrel={'X' , 'Y' , 'Z'};

% Adapt the list with the direction
if transfo.dir==1
    axelist=sort(transfo.axelist);
else
    axelist=sort(transfo.axelist,'descend');
end


for k=axelist
    if isempty(find(transfo.transfolist==k-transfo.dir*1,1)) %if there is no relative rigid transformation
        % Build the Num3D.{Vertebre} with the absolute transformation
        % centre
        eval(['Num3D.' , cell2mat(Vertebres(k)) , '.axe.centre.x=transfo.abstrans(1,k);']);
        eval(['Num3D.' , cell2mat(Vertebres(k)) , '.axe.centre.y=transfo.abstrans(2,k);']);
        eval(['Num3D.' , cell2mat(Vertebres(k)) , '.axe.centre.z=transfo.abstrans(3,k);']);
        
        %the absolute rotation defines the local axe
        axetemp=reshape(transfo.absrmat(k,:,:),3,3);

    else
        % Build with the previous Vertebrea (according to the direction)
        % Centre

        %we need to pass again in the absolute coordinate system by
        %applying the absolute rotation matrix.
        %%%%%%%%%%%% Changed by maryam to instead of using absrotation, the
        %%%%%%%%%%%% rotation beteen consicutive vertebra can be used.
        %%%%%%%%%%%%trans=(reshape(transfo.absrmat(k-transfo.dir*1,:,:),3,3))*transfo.trans(:,k-transfo.dir*1); %#ok<NASGU>
        trans=axetemp*transfo.trans(:,k-transfo.dir*1); %#ok<NASGU>
        %trans=transfo.trans(:,k-transfo.dir*1);
        %if absolute translation------------------------------------------

        eval(['Num3D.' , cell2mat(Vertebres(k)) , '.axe.centre.x=Num3D.' , cell2mat(Vertebres(k-transfo.dir*1)) , '.axe.centre.x+trans(1);']);
        eval(['Num3D.' , cell2mat(Vertebres(k)) , '.axe.centre.y=Num3D.' , cell2mat(Vertebres(k-transfo.dir*1)) , '.axe.centre.y+trans(2);']);
        eval(['Num3D.' , cell2mat(Vertebres(k)) , '.axe.centre.z=Num3D.' , cell2mat(Vertebres(k-transfo.dir*1)) , '.axe.centre.z+trans(3);']);

        
        % The local axe is defined from the input vertebra and the rigid
        % transformation
        axetemp=reshape(transfo.rmat(k-transfo.dir*1,:,:),3,3)*axetemp; %#ok<NASGU>
    end

    % Output axe
    for r=1:3
        for s=1:3
            eval(['Num3D.' , cell2mat(Vertebres(k)) , '.axe.' , cell2mat(coordrel(r)) , '.' , cell2mat(coordabs(s)) , '=axetemp(s,r);']);
        end
    end

    % Build the position of each Landmarks in the absolute coordinate

    % Existing Landmark index
    listLandmarks=find(rellmpos.mask(k,:)~=0);

    for m=listLandmarks
        % Absolute position of Landmarks from the local origin
        result=axetemp*reshape(rellmpos.rellmpos(k,m,:),3,1); %#ok<NASGU>
        % translate to the absolute origin and save in Num3D
        eval(['Num3D.' , cell2mat(Vertebres(k)) , '.' , cell2mat(Landmarks(m)) , '.x=result(1)+Num3D.' , cell2mat(Vertebres(k)) , '.axe.centre.x;']);
        eval(['Num3D.' , cell2mat(Vertebres(k)) , '.' , cell2mat(Landmarks(m)) , '.y=result(2)+Num3D.' , cell2mat(Vertebres(k)) , '.axe.centre.y;']);
        eval(['Num3D.' , cell2mat(Vertebres(k)) , '.' , cell2mat(Landmarks(m)) , '.z=result(3)+Num3D.' , cell2mat(Vertebres(k)) , '.axe.centre.z;']);
    end
end

%--------------------------------------------------------------------------
% if the direction is -1 the Num3D structure is build in reverse.
% we need to re-order it to have an ordered .o3 with Num3D2o3.m
if transfo.dir==-1
    C=fields(Num3D);
    while length(C)>1 && eval(['~isstruct(Num3D.' , cell2mat(C(1)) , ')'])
        eval(['Num3D2.' , cell2mat(C(1)) , '=Num3D.' , cell2mat(C(1)) , ';'])
        C(1)=[];
    end
    for i=length(C):-1:1
        eval(['Num3D2.' , cell2mat(C(i)) , '=Num3D.' , cell2mat(C(i)) , ';'])
    end
    Num3D=Num3D2;
end