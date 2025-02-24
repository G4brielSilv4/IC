function [ppesc_u,preco_por_esc_u,pen_esc_u,NcRd_esc_u] = comp_perfil_u (espacamento_entre_porticos,E,fy,G,area_escora_comp,Iyy,Ixx,bww,tww,bff,tff,ryy,rxx,XX)

% Contraventamento das terças utilizando a sugestçao do manual da CBCA 2004, perfis U comprimidos na direção das terças e
% tirantes tracionados na diagonal formando a estrutura "treliçada"

L = espacamento_entre_porticos; %comprimento de flambagem das escoras
d = (bww+(2*tff)); % altura externa total da peça
%% CALCULOS PRELIMINARES
Q1 = 1; % fator Q com valor 1 apenas para o calculo do Q do elemento AA, apos tal calculo o novo valor de Q será calculado
e = (3*tff*((bff-(tww/2))^2))/((tww*(bww+tff))+(6*(bff-(tww/2))*tff)); % posicao do centro de cisalhamento {(3*tf*(b^2))/(h*tw + b*tf)} h e b pela linha media
x0 = 0;
y0 = e+XX;

r0 = sqrt(rxx^2+ryy^2+x0^2+y0^2);
J = ((2*bff-tww)*(tff^3) + (bww+tff)*(tww^3))/3;
cw = (((tff*(bff-0.5*tww)^3)*((d-tff)^2))/12)*((3*tff*(bff-0.5*tww))+2*tww*(d-tff))/((6*tff*(bff-0.5*tww))+tww*(d-tff));

Nex =pi^2*E*Ixx/(L^2); %Considerando Kx = 1 e flambagem por flexão em relação ao eixo central de inércia x da seção transversal
Ney =pi^2*E*Iyy/(L^2); %Considerando Ky = 1 e flambagem por flexão em relação ao eixo central de inércia y da seção transversal
Nez = (G*J + (pi^2*E*cw)/(L^2))/(r0^2); %flambagem por torção em relação ao eixo longitudinal z
Neyz = ((Ney + Nez)/2*(1-(y0/r0)^2))*(1-(sqrt(1-((4*Ney*Nez*(1-(y0/r0)^2))/(Ney+Nez)^2)))); %flambagem por flexo-torção

if (Nex < Neyz)
    Ned = Nex;
else 
    Ned = Neyz;
end

lamb0 = sqrt(Q1*area_escora_comp*fy/Ned);

if (lamb0 <= 1.5) % NBR 8800/2008 item 5.3.3 p44
    chi = 0.658^(lamb0^2);
else
    chi = 0.877/(lamb0^2);
end

%% CALCULOS DO Q
% elemento AL

bf_tf = bff/tff;
bf_tf_lim = 0.56*sqrt(E/fy);
bf_tf_sup = 1.03*sqrt(E/fy);

if (bf_tf <= bf_tf_lim) %Anexo F NBR 8800/2008 - P127
    Qs = 1;
else
    if (bf_tf_lim < bf_tf) && (bf_tf <= bf_tf_sup)
        Qs = 1.415-(0.74*bf_tf*sqrt(fy/E));
    else
        Qs = 0.69*E/(fy*(bf_tf^2));
    end
end

%elemento AA

bw_tw = bww/tww;
bw_tw_lim = 1.49*sqrt(E/fy);
Qa = 1;

if (bw_tw > bw_tw_lim)
    sigma=chi*fy;
    bef=1.92*tww*sqrt(E/sigma)*(1-(0.34*sqrt(E/sigma)/bw_tw));
    
    Ag = bww*tww;
    Aef = Ag-(tww*(bww-bef));
    
    Qa = Aef/Ag;
end

Q = Qs*Qa;

%% CALCULO DO CHI

lamb0 = sqrt(Q*area_escora_comp*fy/Ned);

if (lamb0 <= 1.5) % NBR 8800/2008 item 5.3.3 p44
    chi = 0.658^(lamb0^2);
else
    chi = 0.877/(lamb0^2);
end

%% VERIFICAÇÃO DA ESBELTEZ

indice_esbeltez=L/ryy;
pen_esc_u=0;
if indice_esbeltez>200
    pen_esc_u=1e10;
end

%% RESULTADOS

NcRd_esc_u = Q*chi*area_escora_comp*fy/1.1;
ppesc_u= 7850*area_escora_comp; %kg/m
preco_unitario=3.55;
preco_por_esc_u=preco_unitario*ppesc_u;
end