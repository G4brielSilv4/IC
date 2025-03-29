%Contraventamento no plano da cobertura para resistir as cargas de vento

function [pptirante,preco_tirante,penalidade,peso_tirante_x_sec] = tirante_x (perfil_tirante_x,fu,fy,incl,Cpi2,p,espacamento_entre_porticos,altura_cobertura,esp_terca,h,n_tercas)

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

d=d_(perfil_tirante_x); %t4 - diâmetro do tirante

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
Fdiag = 1.4*p*Cpei*esp_terca*(altura_cobertura+h)/2; %horizontal 
%força paralela ao cabo
Fsd= Fdiag*sqrt(espacamento_entre_porticos^2+esp_terca^2)/espacamento_entre_porticos;

penalidade=0;
if Fsd>FtRd %para dispensar a verificação da flambagem (desde que barras pré-tracionadas - outro critério - ver 5.2.8.1 e .3 NBR 8800
    penalidade=1e10;
end

diametro_tirante_x=d;

pptirante= pp; %(N/m)
peso_tirante_x_sec= pptirante/9.81*sqrt(espacamento_entre_porticos^2+esp_terca^2)*(n_tercas-1)*2; %kg/m
preco_unitario=4.01;
preco_tirante=preco_unitario*peso_tirante_x_sec;
assignin('base','diametro_tirante_x',diametro_tirante_x)
end