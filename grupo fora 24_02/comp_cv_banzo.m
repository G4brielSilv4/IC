% Compressão máxima que o perfil contoneira dupla pode resistir pela
% NBR8800/2008.

function [pen_banzo,NcRd_cv_banzo] = comp_cv_banzo (num_esc,conec_esc,E,fy,G,Iy,Ix,bw,tw,rx,Xbarra,dist_entre_esc)
%CANTONEIRA DUPLA

pen_banzo=0;
el=num_esc+1;


bw_tw2 = bw(el)/tw(el);
bw_tw2lim = 0.56*sqrt(E/fy);
bw_tw2sup = 1.03*sqrt(E/fy);

if (bw_tw2 <= bw_tw2lim) %Anexo F NBR 8800/2008 - P127
    Q = 1;
elseif (bw_tw2lim < bw_tw2) && (bw_tw2 <= bw_tw2sup)
    Q = 1.415-(0.74*bw_tw2*sqrt(fy/E));
else
    Q = 0.69*E/(fy*(bw_tw2^2));
end

J=2*((2*bw(el)-tw(el))*tw(el)^3)/3;

%calculo do comprimento do elemento el
area=conec_esc(el,2);
L = conec_esc(el,5);
Ixd = 2*Ix(el);
Iyd = 2*(Iy(el) + (area/2)*Xbarra(el)^2);
rxd = rx(el);
ryd =sqrt(Iyd/area);
cg =(2*bw(el)*tw(el)^2/2 + 2*tw(el)*((bw(el)-tw(el))^2)/2)/area;
x0 = 0;
y0 = cg - tw(el)/2;
r0 = sqrt(rxd^2+ryd^2+x0^2+y0^2);

Nexd =pi^2*E*Ixd/(L^2); %Considerando Kx = 1 e Lx=L %flambagem por flexão em relação ao eixo central de inércia x da seção transversal
Neyd =pi^2*E*Iyd/(dist_entre_esc^2); %Considerando Ky = 1 e Ly=espaçamento entre contraventamentos %flambagem por flexão em relação ao eixo central de inércia y da seção transversal
Nezd =G*J/(r0^2); %flambagem por torção em relação ao eixo longitudinal z
Neyzd = ((Neyd+Nezd)/(2*(1-(y0/r0)^2)))*(1-sqrt(1-(4*Neyd*Nezd*(1-(y0/r0)^2))/((Neyd+Nezd)^2)));

if (Nexd< Neyzd)
    Ned = Nexd;
else
    Ned = Neyzd;
end

lamb0 = sqrt(Q*area*fy/Ned);

if (lamb0 <= 1.5) % NBR 8800/2008 item 5.3.3 p44
    X = 0.658^(lamb0^2);
else
    X = 0.877/(lamb0^2);
end

NcRd_cv_banzo = Q*X*area*fy/1.1;

%%
%%VERIFICAÇÃO DA ESBELTEZ

indice_esbeltez=L/rxd;

if indice_esbeltez>200
    pen_banzo=pen_banzo+1e10;
end


end