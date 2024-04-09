function [axe]=gramschmidt(axes,axeinit)
%This function permits to use the graam schmidt procedure in order to
%ceate an orthogonal axe from an initialisation and a list of axes.
%
% By: Xavier Glorot August 2008
% xavier.glorot@cpe.fr

bool=0;
if size(axes,2)>size(axes,1)
    bool=1;
    axes=axes';
end

[dimension Nbaxes]=size(axes);

axe=axeinit;

if ~isempty(axes)
    bool=0;
    if size(axeinit,1)~=dimension
        bool=1;
        axeinit=axeinit';
        if size(axeinit,1)~=dimension
            error('axeinit is not in the good size');
        end
    end
    for i=1:Nbaxes
        axe=axe-(sum(axeinit.*axes(:,i))/(norm(axes(:,i))^2)).*axes(:,i);
    end
    axe=axe/norm(axe);
end


if bool
    axe=axe';
end

