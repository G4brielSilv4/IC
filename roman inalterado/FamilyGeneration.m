function [ FamilyLeader, FamilyGroup] = FamilyGeneration( FamilyLeader,SearchGroupSize,lSup,lInf,Alfa,Fobj,v,PlotFamily )


%This function generates a family with size defined in v for each member of the search group and
%chooses the best fit member as its leader for the next iteration.

Dim = length(lSup);
FamilyGroup(1).Min = FamilyLeader(1,2:Dim+1);
FamilyGroup(1).Max = FamilyLeader(1,2:Dim+1);
k = 1;
for i = 1:SearchGroupSize
    FamilySize = v(1,i);
    Family = zeros(FamilySize+1,Dim+1);
    xTemp = zeros(FamilySize,Dim);
    Family(1,:) = FamilyLeader(i,:); 
    xTemp(1:FamilySize,:)= repmat(FamilyLeader(i,2:Dim+1),FamilySize,1)+repmat(Alfa,FamilySize,1).*(rand(FamilySize,Dim)-0.5);        
    xTemp=max(xTemp,repmat(lInf,FamilySize,1));
    xTemp=min(xTemp,repmat(lSup,FamilySize,1));
    Family(2:(FamilySize+1),2:(Dim+1)) = xTemp(1:FamilySize,:);
    for j = 1:FamilySize
        Family(1+j,1) = Fobj(xTemp(j,:));
    end
    for j=1:FamilySize
        if Family(1+j,1) < FamilyLeader(i,1)
        FamilyLeader(i,:) = Family(1+j,:);
        if PlotFamily
            k = j;
        end
        end
    end
    if PlotFamily
        Family(1+k,:) = Family(1,:);
        Family(1,:) = FamilyLeader(i,:);
        FamilyGroup(i).Family = Family(2:FamilySize,:);
        FamilyGroup(i).Leader = FamilyLeader(i,:);
        FamilyGroup(1).Min = min(min(Family(:,2:Dim+1)),FamilyGroup(1).Min);
        FamilyGroup(1).Max = max(max(Family(:,2:Dim+1)),FamilyGroup(1).Max);
    end
end
end
