function [ PerturbedIndices ] = Tournament( PopulationSize,FamilyLeader,TournamentSize )

%% Tournament code

PerturbedIndices = zeros(FamilyLeader,1); 
c = zeros(TournamentSize,1);
SearchGroupIndices= transpose(2:1:PopulationSize);

for i=1:FamilyLeader
    for j = 1:TournamentSize
        c(j)=PopulationSize - ceil((PopulationSize-i)*rand(1));
    end
    e = SearchGroupIndices(min(c));
    SearchGroupIndices(min(c))=0;
    SearchGroupIndices=sortrows(SearchGroupIndices);
    PerturbedIndices(i,1) = e;
end
end
