%Contraventamento vertical entre treliçaa para contraventar o banzo inferior

%considera-se um sistema de treliçado e só se dimensiona a diagonal de contraventamento a tração.

function [pptirante,preco_tirante,penalidade,pptirantekg] = contvertv2 (t4,fu,fy,incl,Cpi2,p,v,h2,b,n_divisoes_banzo_inf,esp_terca,h)

% para o dimensionamento de barras redondas com extremidadesrosqueadas  
% verifica-se a menorresistência entre o escoamento da seção bruta e a 
% ruptura da seção rosqueada.

% A recomendação de limitar o índice de esbeltez não precisa ser avaliada,  
% desde que as barras rosqueadas sejam colocadas com alguma pré-tensão.

%BARRA REDONDA TREFILADA GERDAU

d_=[0.012
    0.0127
    0.0133
    0.014
    0.01428
    0.01435
    0.0145
    0.015];

d=d_(t4); %t4 - diâmetro do tirante
%Área bruta
Ab = 0.25*pi*(d^2);

area_contraventamento=Ab;
assignin('base','area_contraventamento',area_contraventamento);

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

pp=77000*Ab; %(N/m)

Cpei = cpei (incl,Cpi2);
Fdiag = 1.4*p*Cpei*esp_terca*(h2+h)/2; %horizontal 
%força paralela ao cabo
Fsd= Fdiag*sqrt(v^2+esp_terca^2)/v; %h2 - altura da treliça em m

penalidade=0;
if Fsd>FtRd %para dispensar a verificação da flambagem (desde que barras pré-tracionadas - outro critério - ver 5.2.8.1 e .3 NBR 8800
    penalidade=1e10;
end

perfilcv=d;

pptirante= pp; %(N/m)
pptirantekg= pptirante/9.81*sqrt(v^2+esp_terca^2)*(n_tercas-1)*2; %kg/m
preco_unitario=4.18;
preco_tirante=preco_unitario*pptirantekg;
assignin('base','perfilcv',perfilcv)
end