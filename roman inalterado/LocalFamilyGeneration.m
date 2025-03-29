function [ Database, FamilyGroup ] = LocalFamilyGeneration(FamilyLeader,PopulationSize,SearchGroupSize,lSup,lInf,Alfa,Fobj,v,PlotFamily)

%% Family generation code: local phase %%
% It receives the current search group and returns their families
Dim = length(lSup);
Database = zeros(PopulationSize,Dim+1);
counter = 0;
xTemp = zeros(PopulationSize,Dim);
FamilyValue = zeros(PopulationSize,1);
FamilyGroup.PlotFamily = PlotFamily;
for i = 1:SearchGroupSize
    FamilySize = v(1,i);
    xTemp(counter+1,:) = FamilyLeader(i,2:Dim+1);
    Database(counter+1,:) = FamilyLeader(i,:);
    xTemp(counter+2:counter+FamilySize+1,:)= repmat(xTemp(counter+1,:),FamilySize,1)+repmat(Alfa,FamilySize,1).*(rand(FamilySize,Dim)-0.5);        
    xTemp(counter+1:counter+FamilySize+1,:)=max(xTemp(counter+1:counter+FamilySize+1,:),repmat(lInf,FamilySize+1,1));
    xTemp(counter+1:counter+FamilySize+1,:)=min(xTemp(counter+1:counter+FamilySize+1,:),repmat(lSup,FamilySize+1,1));
    Database(counter+1:counter+FamilySize+1,2:Dim+1) = xTemp(counter+1:counter+FamilySize+1,:);
    for j = 1:FamilySize
        FamilyValue(counter+1+j,1) = Fobj(xTemp(counter+1+j,:));
    end
    Database(counter+2:counter+FamilySize+1,1) = FamilyValue(counter+2:counter+FamilySize+1,1);
    if PlotFamily
        FamilyGroup(i).Family = [FamilyValue(counter+2:counter+FamilySize+1,1) xTemp(counter+2:counter+FamilySize+1,:)];
        FamilyGroup(i).Leader = FamilyLeader(i,:);
    end
    counter = counter+FamilySize+1;    
end
end

