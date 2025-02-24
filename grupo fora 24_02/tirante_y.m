function [pptirante, preco_tirante,penalidade,pptirantekg] = tirante_y (perfil_tirante_y,fu,fy,carga_telha,sc,incl,espacamento_entre_porticos,esp_terca,n_tercas)

% para o dimensionamento de barras redondas com extremidadesrosqueadas verifica-se a menor 
% resistência entre o escoamento da seção bruta e a ruptura da seção rosqueada.

% A recomendação de limitar o índice de 
% esbeltez não precisa ser avaliada, desde que 
% as barras rosqueadas sejam colocadas com 
% alguma pré-tensão.

%BARRA REDONDA TREFILADA GERDAU

d_=[0.012
    0.0127
    0.0133
    0.014
    0.01428
    0.01435
    0.0145
    0.015]; %m

    
d=d_(perfil_tirante_y);

%Área bruta
Ab = 0.25*pi*(d^2);

area_tirante=Ab;
assignin('base','area_tirante',area_tirante);
%Área efetiva
Ae=0.75*Ab;

%6.3.3.1 da ABNT NBR8800/2008

%força de tração resistente de cálculo
FtRdt=Ae*fu/1.35;

%força de tração resistente para o escoamento da seção bruta
FtRde=Ab*fy/1.1;

if FtRdt<FtRde
    FtRd=FtRdt;
else FtRd=FtRde;
end

%Carregamentos

ppb=77000*Ab; %(N/m)
pp= ppb+carga_telha*(espacamento_entre_porticos/2); %N/m
scb= sc*(espacamento_entre_porticos/2); %N/m 

Fdy= 1.25*pp*sin(incl*2*pi/360) + 1.5*scb*sin(incl*2*pi/360); %N/m

%Tirante 1 perpendicular a 3 das 4 terças = 2*esp_terca
Fd1 = Fdy*(esp_terca*(n_tercas-1)/2-1); %N (carga concentrada)

%Tirante 2 = pitágora entre v/2 e esp_terca - 2 tirantes inclinados no
%espaço entre terças superior = carga total / entre os 2 / sen da
%inclinação do tirante (angulo entre a diag e v/2)

T2=sqrt((espacamento_entre_porticos/2)^2 + esp_terca^2);

Fd2 = ((espacamento_entre_porticos/2)*esp_terca*Fdy/2)*(T2/esp_terca);

if Fd2>Fd1
    Fd=Fd2;
else Fd=Fd1;
end

penalidade=0;
if Fd>(FtRd) %para dispensar a verificação da flambagem (desde que barras pré-tracionadas - outro critério - ver 5.2.8.1 e .3 NBR 8800
    penalidade=1e10;
end

diametro_tirante_y=d;
pptirante= pp + penalidade; %(N/m)
pptirantekg=ppb/9.81*(esp_terca*((n_tercas-1)/2-1)+T2*2)*2; %kg/m Verificar com pórtico
preco_unitario=4.01;
preco_tirante=preco_unitario*pptirantekg;

assignin('base','diametro_tirante_y',diametro_tirante_y)
end