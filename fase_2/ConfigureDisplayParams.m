function [DisplayParams] = ConfigureDisplayParams(PlotFamily,PlotTitle,LB,UB)

DisplayParams.PlotFamily = PlotFamily;
if ~PlotFamily
    return
end
DisplayParams.FamiliesFigureHandle = figure('Name',PlotTitle,'NumberTitle','off');
DisplayParams.FamiliesAxisHandle = axes;

ColorMatrix = [1   0   0  ; 0 1   0    ; 0   0 1    ; 1   1   0  ; 1   0 1    ; 0 1   1    ; 1 1 1       ;
               0.5 0.5 0.5; 0 0.5 0.5  ; 0.5 0 0.5  ; 0.5 0.5 0  ; 0.5 0 0    ; 0 0.5 0    ; 0 0 0.5     ;
               1   0.5 1  ; 0.1*[1 1 1]; 0.2*[1 1 1]; 0.3*[1 1 1]; 0.4*[1 1 1]; 0.5*[1 1 1]; 0.6*[1 1 1]];
DisplayParams.ColorMatrix = [ColorMatrix ; sqrt(ColorMatrix)];

DisplayParams.AxisMargin.Min = LB;
DisplayParams.AxisMargin.Max = UB;

end
