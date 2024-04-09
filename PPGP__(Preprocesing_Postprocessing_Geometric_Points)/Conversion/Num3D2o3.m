function Num3D2o3(Num3D,newpath)
%This function permits to create a .o3 file from a Num3D structure.
%in the newpath defined path.
%
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr

%create the new file [erase if already exists]

fid=fopen(newpath,'w');

% Complementary information
fprintf(fid,'\n# ---- ---- ---- ---- ---- ---- General  ---- ---- ---- ---- ---- ----   \n\n');

% the num3D fields
fd=fields(Num3D);
% go over the specific Num3D information
i=4;

while eval(['~isstruct(Num3D.' , cell2mat(fd(i)) , ')']) 
    if ~strcmp(cell2mat(fd(i)),'instrum') && ~strcmp(cell2mat(fd(i)),'apex') && ~strcmp(cell2mat(fd(i)),'History')
        fprintf(fid,'%s:%s\n\n',cell2mat(fd(i)),eval(['Num3D.' , cell2mat(fd(i))]));
    end
    i=i+1;
end

% Coordinates values
fprintf(fid,'\n# ---- ---- ---- ---- ---- ---- DATA 3D  ---- ---- ---- ---- ---- ----   \n\n');

while i<=length(fd)
    objet=cell2mat(fd(i));
    ind=findstr(objet,'PA');
    if ~isempty(ind)
        objet=[objet(1:ind+1) , '-' , objet(ind+2:end)]; %convert to the .o3 format
    end
    fprintf(fid,'Objet:\t%s\n',objet);
    if ~isempty(ind)
        objet=cell2mat(fd(i));
    end
    %convert to the .o3 format
    if ~strcmp(objet(1:4),'Cote')
        dummy='Grid_3D';
    else
        dummy='Line_3D';
    end
    fprintf(fid,'%s: # ----- tag ------ x --------- y --------- z ---------- err --------- src ---- \n',dummy);
    fdtemp=fields(eval(['Num3D.',objet]));
    for j=1:length(fdtemp)
        tag=cell2mat(fdtemp(j));
        tag2=tag;
        if strcmp(objet(1:4),'Cote')
            tag2(1:2)=[]; %convert to the .o3 format (erase the Nb)
        end
        % print the values according to the case (err and src fields)
        if ~strcmp(tag,'axe')
            if ~isfield(eval(['Num3D.',objet, '.' , tag]),'err')
                fprintf(fid,'%20s%12.4f%12.4f%12.4f \n',tag2,eval(['Num3D.' , objet , '.' , tag, '.x']),eval(['Num3D.' , objet , '.' , tag, '.y']),eval(['Num3D.' , objet , '.' , tag, '.z']));
            else
                if ~isfield(eval(['Num3D.',objet, '.' , tag]),'src')
                    fprintf(fid,'%20s%12.4f%12.4f%12.4f%14.4f \n',tag2,eval(['Num3D.' , objet , '.' , tag, '.x']),eval(['Num3D.' , objet , '.' , tag, '.y']),eval(['Num3D.' , objet , '.' , tag, '.z']),eval(['Num3D.' , objet , '.' , tag, '.err']));
                else
                    if ischar(eval(['Num3D.' , objet , '.' , tag, '.src']))
                        fprintf(fid,'%20s%12.4f%12.4f%12.4f%14.4f        %-s \n',tag2,eval(['Num3D.' , objet , '.' , tag, '.x']),eval(['Num3D.' , objet , '.' , tag, '.y']),eval(['Num3D.' , objet , '.' , tag, '.z']),eval(['Num3D.' , objet , '.' , tag, '.err']),eval(['Num3D.' , objet , '.' , tag, '.src']));
                    else
                        fprintf(fid,'%20s%12.4f%12.4f%12.4f%14.4f%14.4f \n',tag2,eval(['Num3D.' , objet , '.' , tag, '.x']),eval(['Num3D.' , objet , '.' , tag, '.y']),eval(['Num3D.' , objet , '.' , tag, '.z']),eval(['Num3D.' , objet , '.' , tag, '.err']),eval(['Num3D.' , objet , '.' , tag, '.src']));
                    end
                end
            end
        end
    end
    fprintf(fid,'\n');
    %next field
    i=i+1;
end
%close file
fclose(fid);