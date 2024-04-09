function ShowSpine3D(Rec,colour)
% Display the spine in 3D figure with prisms formed from the 6 points per
% vertebra.
% Input 'Rec' is simply a (Nx3) matrix containing the N points to display
% (points from M vertebrae concatenated, N = M*6).
%
% colour = [0 0 0];
% figure
for j = 1 : 2
    subplot(1,2,j)
    for i = 1 : 6 : length(Rec)
        Inf = [Rec(i:i+1,:); Rec(i+4,:);Rec(i,:)];
        Sup = [Rec(i+2:i+3,:);Rec(i+5,:);Rec(i+2,:)];
        Plat = Rec(i+4:i+5,:);
        G = [Rec(i+1,:);Rec(i+3,:)];
        D = [Rec(i,:);Rec(i+2,:)];
        line('LineStyle','-','LineWidth',1.5,'Marker','.','MarkerSize',2,...
            'MarkerFaceColor',colour,'Color',colour,'XData',Inf(:,1),...
            'YData',Inf(:,2),'ZData',Inf(:,3));
        line('LineStyle','-','LineWidth',1.5,'Marker','.','MarkerSize',2,...
            'MarkerFaceColor',colour,'Color',colour,'XData',Sup(:,1),...
            'YData',Sup(:,2),'ZData',Sup(:,3));
        line('LineStyle','-','LineWidth',1.5,'Marker','.','MarkerSize',2,...
            'MarkerFaceColor',colour,'Color',colour,'XData',Plat(:,1),...
            'YData',Plat(:,2),'ZData',Plat(:,3));
        line('LineStyle','-','LineWidth',1.5,'Marker','.','MarkerSize',2,...
            'MarkerFaceColor',colour,'Color',colour,'XData',G(:,1),...
            'YData',G(:,2),'ZData',G(:,3));
        line('LineStyle','-','LineWidth',1.5,'Marker','.','MarkerSize',2,...
            'MarkerFaceColor',colour,'Color',colour,'XData',D(:,1),...
            'YData',D(:,2),'ZData',D(:,3));
    end
    axis equal
    axis tight
    view([2-j,j-1,0]);
end
