function DisplayFamilies(FamilyGroup,SearchGroupSize,PopulationSize,Dim,DisplayParams)

TotalFamilyPopulation = PopulationSize - SearchGroupSize;

if ~DisplayParams.PlotFamily
    return;
end
    
if (Dim ~= 2) && (Dim ~= 3)
    return;
end

if ~any(findall(0)==DisplayParams.FamiliesFigureHandle)
    return;
end

if Dim == 2
    for ii = 1:SearchGroupSize
        plot(DisplayParams.FamiliesAxisHandle,FamilyGroup(ii).Leader(2),FamilyGroup(ii).Leader(3),'p',...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',DisplayParams.ColorMatrix(ii,:),...
            'MarkerSize',70*numel(FamilyGroup(ii).Leader(1))/TotalFamilyPopulation + 13);
        hold on

        plot(DisplayParams.FamiliesAxisHandle,FamilyGroup(ii).Family(:,2),FamilyGroup(ii).Family(:,3),'ok',...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',DisplayParams.ColorMatrix(ii,:),...
            'MarkerSize',8);
    end

    xlim([DisplayParams.AxisMargin.Min(1) DisplayParams.AxisMargin.Max(1)]);
    ylim([DisplayParams.AxisMargin.Min(2) DisplayParams.AxisMargin.Max(2)]);
    hold off
end

if  Dim == 3
%         figure(1)
    for ii = 1:SearchGroupSize            
        plot3(DisplayParams.FamiliesAxisHandle,FamilyGroup(ii).Leader(2),FamilyGroup(ii).Leader(3),FamilyGroup(ii).Leader(4),'p',...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',DisplayParams.ColorMatrix(ii,:),...
            'MarkerSize',70*numel(FamilyGroup(ii).Leader(1))/TotalFamilyPopulation + 13);
        hold on

        plot3(DisplayParams.FamiliesAxisHandle,FamilyGroup(ii).Family(:,2),FamilyGroup(ii).Family(:,3),FamilyGroup(ii).Family(:,4),'ok',...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor',DisplayParams.ColorMatrix(ii,:),...
            'MarkerSize',8);
    end

    xlim([DisplayParams.AxisMargin.Min(1) DisplayParams.AxisMargin.Max(1)]);
    ylim([DisplayParams.AxisMargin.Min(2) DisplayParams.AxisMargin.Max(2)]);
    zlim([DisplayParams.AxisMargin.Min(3) DisplayParams.AxisMargin.Max(3)]);
    hold off
end

pause(0.05);
end