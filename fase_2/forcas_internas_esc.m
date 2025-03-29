%Função que calcula as forças atuantes nas barras em função dos
%carregamentos

function fn_cv = forcas_internas_esc (xx,yy,num_nos_cv,n_el_cv,E,conec_esc,n_rest_cv,GDL_rest_cv,n_forcas_cv,forcas)
           
%CALCULO DA ESTRUTURA
GDL=2*num_nos_cv;  %graus de liberdade da estrutura
K=zeros(GDL,GDL); %matriz rigidez global - zeros é a matriz com os elementos das linhas e colunas iguais a zero

% Cálculo da matriz de cada elemento
for el=1:n_el_cv
    %calculo do comprimento do elemento el

    no1=conec_esc(el,3);
    no2=conec_esc(el,4);
    %L=abs(x(no2)-x(no1));
    L = conec_esc(el,5);
    %Cossenos diretores a partir das coordenadas dos nós do elemento
    cs = (xx(no2) - xx(no1))/L;	%cosseno
    sn = (yy(no2) - yy(no1))/L;	%seno
    % Matriz de rigidez do elemento "el"
    k=(E*conec_esc(el,2))/L;
    ke=[k  -k
        -k   k];
    T=[cs  sn   0   0
        0   0  cs  sn];
    kg=T'*ke*T; % T' é matriz transposta
    %Inserção na matriz de rigidez global
    
    for i=1:2						% superposição da sub-matriz (1-2,1-2) da matriz elementar
        ig = (no1-1)*2+i;
        for j=1:2
            jg = (no1-1)*2+j;
            K(ig,jg)=K(ig,jg)+kg(i,j);
        end
    end
    
    for i=1:2				%superposição da sub-matriz (3-4,3-4) da matriz elementar
        ig = (no2-1)*2+i;
        for j=1:2
            jg = (no2-1)*2+j;
            K(ig,jg)=K(ig,jg)+kg(i+2,j+2);
        end
    end
    
    for i=1:2				%superposição das sub-matrizes (1-2,3-4) e ((3-4,1-2) da matriz elementar
        ig = (no1-1)*2+i;
        for j=1:2
            jg = (no2-1)*2+j;
            K(ig,jg)=K(ig,jg)+kg(i,j+2);
            K(jg,ig)=K(jg,ig)+kg(j+2,i);
        end
    end
    
end

% Vetor de forças Global
F=zeros(GDL,1);
for i=1:n_forcas_cv
    F(2*forcas(i,1)-1)=forcas(i,2);
    F(2*forcas(i,1))=forcas(i,3);
end
% guardamos os originais de K e F
Kg=K;
Fg=F;
% Aplicar Restrições (condições de contorno)
for k=1:n_rest_cv
    % Verifica se há restrição na direção x
    if GDL_rest_cv(k,2)==1
        j=2*GDL_rest_cv(k,1)-1;
        %Modificar Matriz de Rigidez
        for i=1:GDL
            Kg(j,i)=0;   %zera linha
            Kg(i,j)=0;   %zera coluna
        end
        Kg(j,j)=1;       %valor unitário na dianogal principal
        Fg(j)=0;
    end
    % Verifica se há restrição na direção y
    if GDL_rest_cv(k,3)==1
        j=2*GDL_rest_cv(k,1);
        %Modificar Matriz de Rigidez
        for i=1:GDL
            Kg(j,i)=0;   %zera linha
            Kg(i,j)=0;   %zera coluna
        end
        Kg(j,j)=1;       %valor unitário na dianogal principal
        Fg(j)=0;
    end
end

%Mostrando K e F na tela:
%Matriz de rigidez global: disp(K)
%Vetor de forças globais: disp(F)

%Calculo dos deslocamentos
desloc=Kg\Fg;

%Reações
%reacoes=K*desloc; %desligado para diminuir tempo computacional


%Esforçoes nos elementos
fn_cv=zeros(1,n_el_cv);
for el=1:n_el_cv
    %calculo do comprimento do elemento "el
    no1=conec_esc(el,3);
    no2=conec_esc(el,4);
    L = sqrt((xx(no2) - xx(no1))^2 + (yy(no2) - yy(no1))^2);
    %Cossenos diretores a partir das coordenadas dos nós do elemento
    cs = (xx(no2) - xx(no1))/L;	% cosseno
    sn = (yy(no2) - yy(no1))/L;	% seno
    %pega os valores dos deslocamentos dos nós do elemento "el"
    u1 = desloc(no1*2-1);
    u2 = desloc(no2*2-1);
    v1 = desloc(no1*2);
    v2 = desloc(no2*2);
    %constante de rigidez do elemento "el"
    k=E*conec_esc(el,2)/L;
    
    %força e tensão atuante no elemento "el"
    fn_cv(el) = k*(-(u1-u2)*cs - (v1-v2)*sn);		%cálculo da força normal no elemento
    
    %ten(el) = fn(el)/An(el);		%cálculo da tensão normal no elemento %desligado para diminuir tempo computacional
end
assignin('base','fn_cv',fn_cv);
end