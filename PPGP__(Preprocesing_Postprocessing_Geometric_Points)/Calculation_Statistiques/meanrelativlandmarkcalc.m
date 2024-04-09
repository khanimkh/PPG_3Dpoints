function [meanrellmposstruct]=meanrelativlandmarkcalc(Num3Ds)
%This function permits to calculate the mean landmarks relative position
%from a structure Num3Ds containing several (or one) Num3D [Num3Ds is
%directly a single Num3D strucure it will calculate the extract the relative
%positions of the landmarks].
%It's calculated in the local Vertebrae axis coordinate.
%
% It output a meanrellmposstruct structure:
%        .rellmpos -> (mean) relative position of each landmarks in mm
%                        [{Vertebrae N°} * {Landmarks} * {relative X Y Z}]
%        .mask -> mask of the existing Landmarks for each vertebrae, it gives
%                 the number of points used to compute the mean
%
% The non-existing field will be filled by zeros.
%
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr

% Initialisation
Init
meanrellmpos=zeros(length(Vertebres),length(Landmarks),3);
count=zeros(length(Vertebres),length(Landmarks));

%if only one Num3D structure
if ~isfield(Num3Ds,'Num3D')
    Num3D=Num3Ds;
    clear Num3Ds
    Num3Ds(1).Num3D=Num3D;
    clear Num3D
end

% for each Num3D
for i=1:length(Num3Ds)
    eval(['refx=(Num3Ds(i).Num3D.' , cell2mat(Vertebres(Num3Ds(i).Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.x+Num3Ds(i).Num3D.' ,cell2mat(Vertebres(Num3Ds(i).Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.x)/2;']);
    eval(['refy=(Num3Ds(i).Num3D.' , cell2mat(Vertebres(Num3Ds(i).Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.y+Num3Ds(i).Num3D.' ,cell2mat(Vertebres(Num3Ds(i).Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.y)/2;']);
    eval(['refz=(Num3Ds(i).Num3D.' , cell2mat(Vertebres(Num3Ds(i).Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.z+Num3Ds(i).Num3D.' ,cell2mat(Vertebres(Num3Ds(i).Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.z)/2;']);

    [centre vect]=axesextract(Num3Ds(i).Num3D); %#ok<ASGLU>
    for j=Num3Ds(i).Num3D.axelist

        % Take the existing Landmarks
        eval(['listLandmarks=fields(Num3Ds(i).Num3D.' , cell2mat(Vertebres(j)) , ');'])

        for l=1:length(listLandmarks)
            for m=1:length(Landmarks)
                if strcmp(cell2mat(Landmarks(m)),cell2mat(listLandmarks(l)))

                    % for each existing Landmarks calculate the
                    % translated coordinates
                    eval(['x=Num3Ds(i).Num3D.' , cell2mat(Vertebres(j)) , '.', cell2mat(Landmarks(m)) ,'.x-centre(1,j)-refx;']);
                    eval(['y=Num3Ds(i).Num3D.' , cell2mat(Vertebres(j)) , '.', cell2mat(Landmarks(m)) ,'.y-centre(2,j)-refy;']);
                    eval(['z=Num3Ds(i).Num3D.' , cell2mat(Vertebres(j)) , '.', cell2mat(Landmarks(m)) ,'.z-centre(3,j)-refz;']);

                    %apply the inverse rotation absolute -> relative
                    pos=(reshape(vect(j,:,:),3,3)^-1)*([x ; y ; z]);

                    %sum the relative positions
                    meanrellmpos(j,m,:)=meanrellmpos(j,m,:)+reshape(pos,1,1,3);

                    %add one to the count to average
                    count(j,m)=count(j,m)+1;
                end
            end
        end
    end
end


% averaging
for k=1:length(Vertebres)
    for m=1:length(Landmarks)
        if count(k,m)
            meanrellmpos(k,m,:)=meanrellmpos(k,m,:)/count(k,m);
        end
    end
end

%saving
meanrellmposstruct.rellmpos=meanrellmpos;
meanrellmposstruct.mask=count;
