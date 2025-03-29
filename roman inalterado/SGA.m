function [ MinValue,Solution] = SGA(Fobj,AlfaInitial,AlfaMin,PopulationSize,SearchGroupRatio,NIterations,GlobalIterationsRatio,NPerturbed,PlotFamily)

%% Search Group Algorithm: metaheuristic optimization algorithm   %%%
%  Developed in: MATLAB R2010a(7.10.0)                              %
%                                                                   %
%                 Author: Matheus Silva Gonçalves                   %
%         e-Mail: matheusgoncalves.contato@gmail.com                %
%                 rafael.holdorf@ufsc.br                            %
%                 leandro.miguel@ufsc.br                            %
%                                                                   %
%        Paper: M. S. Gonçalves, R. H. Lopez, L. F. F. Miguel       %
%               Search Group Algorithm: A new metaheuristic method  %
%      for the optimization of truss structures                     % 
%                                    Computers and Structures       %
%               Volume 153, Março 2015, Pages. 165 - 184,           %
%               http://dx.doi.org/10.1016/j.compstruc.2015.03.003   %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
format long
global OFEs OFELim Plot
Plot=0;OFEs=0;
DisplayParams.PlotFamily = PlotFamily;
SearchGroupSize=round(SearchGroupRatio*PopulationSize);
if SearchGroupSize==0
   disp('Error - Search group is empty -> Redefine SearchGroupSize');
   return 
end
% Create a v vector with size of the family
w=(0:1/(SearchGroupSize):1).^2*(PopulationSize - SearchGroupSize);
v = zeros(1,SearchGroupSize);
for i=1:(SearchGroupSize - 1)
    v(SearchGroupSize+1-i)=round(w(i+1)-w(i));
end
nRemainder = PopulationSize - SearchGroupSize - sum(v);
v(1) = nRemainder;
% Evaluate the number of global iterations
NIterationsGlobal = floor(GlobalIterationsRatio*NIterations);
% Calls fobjs.m to get the problem "F" data;
[lInf,lSup,fobj,dim] = fobjs(Fobj);
% Ellitism: number of individuals that are kept due to their fitness value
elite = 1;
% Percentage of local phase search
NIterationsLocal = NIterations - NIterationsGlobal;
% percentage of alpha_min used to generate new members
SmallValue = 0.0025;
% Defines the reduction of alpha at each iteration: parameter b of Eq.(7)
AlfaCorrectionMatrix = [1 -4/(NIterationsGlobal);0.25 -1/(4*NIterationsGlobal);0 0];
% Number of individuals used in each tournament of the algorithm
TournamentSize = 4;
% Parametrizes alpha in the design domain
Alfa = (AlfaInitial+AlfaMin)*(lSup-lInf);
% Check for error in the dimention of the bounds
if length(lSup) ~= length(lInf)
    disp('Simple bounds/limits are improper');
else
    %% Generates the initial population 
    x = zeros(PopulationSize,dim);
    for i = 1:PopulationSize
        x(i,:) = lInf + (lSup - lInf).*rand(1,dim);
    end
    %% Evaluates the fitness value of all the individuals
    fertility = zeros(PopulationSize,1);
    for i = 1:PopulationSize
        fertility(i,1) = fobj(x(i,:));
    end  
    Database = [fertility x];
    Database = sortrows(Database,1);
    %% Selection of the first Search group
    Indices = transpose(1:1:SearchGroupSize);
    TournamentIndices = Tournament(PopulationSize,SearchGroupSize-elite,TournamentSize);
    IterationData=  zeros(NIterations,dim+1);
    TournamentIndices = sort(TournamentIndices);
    Indices(elite+1:SearchGroupSize) = TournamentIndices(:,1);
    FamilyLeader = zeros(SearchGroupSize,dim+1);
    for i = 1:SearchGroupSize
        Local = Indices(i);
        FamilyLeader(i,:) = Database(Local,:);
    end
    %% Plot of families - global phase
    if DisplayParams.PlotFamily
        PlotTitle = 'Plot of Families - Global Phase';
        [DisplayParams] = ConfigureDisplayParams(PlotFamily,PlotTitle,lInf,lSup);
    end
    
    %% Iterative process of the SGA:
    %%GLOBAL PHASE
    for k = 1:NIterationsGlobal
        %% Mutation Eq.(5) of section 3.3
        % Using tournament, select the individuals to be mutated
        PerturbedIndices = ReverseTournament(TournamentSize,NPerturbed,SearchGroupSize);
        % Mutation:         
        for t = 1:NPerturbed
            FamilyLeader(PerturbedIndices(t,1),2:dim+1) = mean(FamilyLeader(:,2:dim+1)) + t*std(FamilyLeader(:,2:dim+1)).*(rand(1,dim)-0.5);
            FamilyLeader(PerturbedIndices(t,1),2:dim+1) = max(FamilyLeader(PerturbedIndices(t,1),2:dim+1),lInf);
            FamilyLeader(PerturbedIndices(t,1),2:dim+1) = min(FamilyLeader(PerturbedIndices(t,1),2:dim+1),lSup);
            FamilyLeader(PerturbedIndices(t,1),1) = fobj(FamilyLeader(PerturbedIndices(t,1),2:dim+1));
        end
        %% Construction of the Search Group and Generation of the families
        [FamilyLeader, FamilyGroup]= FamilyGeneration(FamilyLeader,SearchGroupSize,lSup,lInf,Alfa,fobj,v,PlotFamily);
        DisplayFamilies(FamilyGroup,SearchGroupSize,PopulationSize,dim,DisplayParams);
        FamilyLeader = sortrows(FamilyLeader,1);
        IterationData(k,:) = FamilyLeader(1,:);
        %% Update the value of alpha
        AlfaCorrection = max(AlfaCorrectionMatrix(:,1)+AlfaCorrectionMatrix(:,2)*k);
        Alfa = (AlfaInitial*AlfaCorrection+AlfaMin)*(lSup-lInf);
        if OFEs>OFELim
            break
        end
    end
    %% Plot of families - local phase
    if DisplayParams.PlotFamily
        PlotTitle = 'Plot of Families - Local Phase';
        delta=(FamilyGroup(1).Max - FamilyGroup(1).Min)/10000;
        LB = FamilyGroup(1).Min - delta;
        UB = FamilyGroup(1).Max + delta;
        [DisplayParams] = ConfigureDisplayParams(PlotFamily,PlotTitle,LB,UB);
    end
    %% LOCAL PHASE
    for k = 1:NIterationsLocal
        PerturbedIndices = ReverseTournament(TournamentSize,NPerturbed,SearchGroupSize);
        for t = 1:NPerturbed
            FamilyLeader(PerturbedIndices(t,1),2:dim+1) = mean(FamilyLeader(:,2:dim+1)) + t*std(FamilyLeader(:,2:dim+1)).*(rand(1,dim)-0.5);
            FamilyLeader(PerturbedIndices(t,1),2:dim+1) = max(FamilyLeader(PerturbedIndices(t,1),2:dim+1),lInf);
            FamilyLeader(PerturbedIndices(t,1),2:dim+1) = min(FamilyLeader(PerturbedIndices(t,1),2:dim+1),lSup);
            FamilyLeader(PerturbedIndices(t,1),1) = fobj(FamilyLeader(PerturbedIndices(t,1),2:dim+1));
        end
        [ Database, FamilyGroup ] = LocalFamilyGeneration(FamilyLeader,PopulationSize,SearchGroupSize,lSup,lInf,Alfa,fobj,v,PlotFamily);
        DisplayFamilies(FamilyGroup,SearchGroupSize,PopulationSize,dim,DisplayParams);
        Alfa = (((NIterationsLocal-k)/(NIterationsLocal))*AlfaMin+SmallValue*AlfaMin)*(lSup-lInf);
        Database = sortrows(Database,1);
        IterationData(NIterationsGlobal+k,:) = Database(1,:);
        FamilyLeader = zeros(SearchGroupSize,dim+1);
        Indices = transpose(1:1:SearchGroupSize);
        TournamentIndices = Tournament(PopulationSize,(SearchGroupSize-elite),TournamentSize);
        TournamentIndices = sort(TournamentIndices);
        Indices(elite+1:SearchGroupSize) = TournamentIndices(:,1);
        for i = 1:SearchGroupSize
            Local = Indices(i);
            FamilyLeader(i,:) = Database(Local,:);
        end
        if OFEs>OFELim
            break
        end
    end
    % Saves the best design found
    Solution(1,:) = IterationData(NIterations,2:dim+1);
    % Evaluates the objective function of the best design
    MinValue = fobj(Solution);
    %% FINISH the iterative process of SGA
end
end
