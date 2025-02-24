function [n_tercas,n_contraventamentos]=tercas_contraventamentos(n_divisoes_banzo_sup,xvar)

% DEFINIÇÃO DO NÚMERO DE TERÇAS
j=1;
n_tercas_matriz=zeros(5);
for i=2:24
    if mod(n_divisoes_banzo_sup,i)==0
        n_tercas_matriz(j)=i;
        j=j+1;
    end
end
for i=1:5
    if n_tercas_matriz(i)==0;
        n_tercas_matriz(i)=n_tercas_matriz(1);
    end
end

n_tercas=n_tercas_matriz(round(xvar(14)))*2+1;
j=1;
n_contraventamentos_matriz=zeros(8);
for i=2:48
    if mod(n_tercas,i)==0
        n_contraventamentos_matriz(j)=i;
        j=j+1;
    end
end
for i=1:8
    if n_contraventamentos_matriz(i)==0;
        n_contraventamentos_matriz(i)=n_contraventamentos_matriz(1);
    end
end
n_contraventamentos=n_contraventamentos_matriz(round(xvar(15)));