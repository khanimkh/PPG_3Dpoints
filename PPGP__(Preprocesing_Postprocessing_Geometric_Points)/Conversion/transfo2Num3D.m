function newNum3D=transfo2Num3D(oldNum3D,newtransfo)
%This function permits to create a Num3D structure from a new
%transformation structure given its old Num3D. It is sensibly the same as 
%rebuildNum3D.m except that it redefine a different Folderpath name in the
%new Num3D and that you don't need to calculate the mean Landmarks position.
%
% WARNING: This function need to have the absolute transformation directly
% corresponding to the relatives one. DO NOT USE with a deltatransfo (no
% sense) %
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr

%new transformation list (in case it changes)
newNum3D.axelist=newtransfo.axelist;

%redefine folderpath
indexstr=findstr(oldNum3D.Filepath,'\');
newNum3D.Filepath=[oldNum3D.Filepath , '_after.o3'];
newNum3D.Name=[oldNum3D.Filepath(indexstr(end)+1:end) , '_after.o3'];
newNum3D.instrum=oldNum3D.instrum;
newNum3D.apex=oldNum3D.apex;

%copy information fields
C=fields(oldNum3D);
for i=4:length(C)
    if eval(['~isstruct(oldNum3D.' , cell2mat(C(i)) , ')'])
        eval(['newNum3D.' , cell2mat(C(i)) , '=oldNum3D.' , cell2mat(C(i)) , ';'])
    end
end


%calculation of the mean relative Landmarks position
[rellmpos]=meanrelativlandmarkcalc(oldNum3D);

%rebuild the Num3D
newNum3D=rebuildNum3D(newNum3D,newtransfo,rellmpos);