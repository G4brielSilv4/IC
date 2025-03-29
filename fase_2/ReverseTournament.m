function [ PerturbedIndices ] = ReverseTournament( TournamentSize,NPerturbed,SearchGroupSize )

%% "Inverse" Tournament code
% It is called here inverse because the "winners" are the worst designs

PerturbedIndices = zeros(NPerturbed,1); 
c = zeros(TournamentSize,1);
SearchGroupIndices= transpose(2:1:SearchGroupSize);

for i=1:NPerturbed
    for j = 1:TournamentSize
        c(j)=SearchGroupSize - ceil((SearchGroupSize-i)*rand(1));
    end
    e = SearchGroupIndices(max(c));
    SearchGroupIndices(max(c))=0;
    SearchGroupIndices=sortrows(SearchGroupIndices);
    PerturbedIndices(i,1) = e;
end
end
