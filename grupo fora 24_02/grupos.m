function [NRs] = grupos (E,G,fy,fu,Areas,bw_,tw_,Ix_,Iy_,rx_,rmin_,Xbarra_,tamanho,esp_cv)

NRs=zeros(3,9);%linha 1 esforcos de tracao, linha 2 esf de comp simples, linha 3 compressao dupla
for n=1:9
    area=Areas(n);
    bw=bw_(n);
    tw=tw_(n);
    Ix=Ix_(n);
    Iy=Iy_(n);
    rx=rx_(n);
    rmin=rmin_(n);
    Xbarra=Xbarra_(n);
    
    %% VERIFICAÇÃO DE TRAÇÃO
    %CONSIDERANDO AÇO MR250
    %ELU Escoamento da seção bruta
    tr_sb = area*fy/1.1; %N     NtRd = Ag*fy/alfaa1
    
    %ELU Ruptura da seção líquida efetiva
    Ct= 0.8; %adotada solda com ct 0,8 (rocomendação do prof, se sobrar tempo voltar aqui)
    %Ct=1-(ec/lc) entra 0,6 e 0,9 = solda longitudinal. Ver P39 NBR 8800/2008.
    tr_sl = Ct*area*fu/1.35; %N    NtRd = Ae*fu/alfaa2
    if (tr_sb>=tr_sl)
        NRs(1,n)=tr_sb;
    else
        NRs(1,n)=tr_sl;
    end    
    
    %% COMPRESSÃO SIMPLES
    
    bw_tw1 = bw/tw;
    bw_tw1lim = 0.45*sqrt(E/fy);
    bw_tw1sup = 0.91*sqrt(E/fy);
    if (bw_tw1 <= bw_tw1lim) %Anexo F NBR 8800/2008 - P126
        Q = 1;
    else if (bw_tw1lim < bw_tw1) && (bw_tw1 <= bw_tw1sup)
            Q = 1.340-(0.76*bw_tw1*sqrt(fy/E));
        else Q = 0.53*E/(fy*(bw_tw1^2));
        end
    end
    
    L = tamanho;
    
    Imin = 2*area*(rmin^2);
    Imax = Ix+Iy-Imin;
    Ixs = Imin;
    Iys = Imax;
    rxs = sqrt(Ixs/2*area);
    rys = sqrt(Iys/2*area);
    x0 =0;
    y0 = (Xbarra - tw/2)*sqrt(2);
    r0 =sqrt(rxs^2+rys^2+x0^2+y0^2);
    J =(2/3)*(bw*tw^3);
    
    Nexs =(pi^2)*E*Ixs/(L^2); %Considerando Kx = 1 e Lx=L
    Neys =(pi^2)*E*Iys/(L^2); %Considerando Ky = 1 e Ly=L = VER TRAVAMENTOS
    Nezs =G*J/(r0^2);
    Neyzs = ((Neys+Nezs)/(2*(1-(y0/r0)^2)))*(1-sqrt(1-(4*Neys*Nezs*(1-(y0/r0)^2))/((Neys+Nezs)^2)));
    
    if (Nexs < Neyzs)
        Nes = Nexs;
    else Nes = Neyzs;
    end
    
    lamb0 = sqrt(Q*2*area*fy/Nes);
    
    if (lamb0 <= 1.5) % NBR 8800/2008 item 5.3.3 p44
        X = 0.658^(lamb0^2);
    else X = 0.877/(lamb0^2);
    end
    
    NRs(2,n) = Q*X*2*area*fy/1.1;
    
    %VERIFICAÇÃO DA ESBELTEZ
    indice_esbeltez=L/rmin;
    if indice_esbeltez>200
        NRs(2,n)=0;
    end
    
    %% COMPRESSÃO DUPLA
    bw_tw2 = bw/tw;
    bw_tw2lim = 0.56*sqrt(E/fy);
    bw_tw2sup = 1.03*sqrt(E/fy);
    if (bw_tw2 <= bw_tw2lim) %Anexo F NBR 8800/2008 - P127
        Q = 1;
    else if (bw_tw2lim < bw_tw2) && (bw_tw2 <= bw_tw2sup)
            Q = 1.415-(0.74*bw_tw2*sqrt(fy/E));
        else Q = 0.69*E/(fy*(bw_tw2^2));
        end
    end
    
    J=2*((2*bw-tw)*tw^3)/3;
    
    L = tamanho;
    Ixd = 2*Ix;
    Iyd = 2*(Iy + (2*area/2)*Xbarra^2);
    rxd = rx;
    ryd =sqrt(Iyd/2*area);
    cg =(2*bw*tw^2/2 + 2*tw*((bw-tw)^2)/2)/2*area;
    x0 = 0;
    y0 = cg - tw/2;
    r0 = sqrt(rxd^2+ryd^2+x0^2+y0^2);
    
    Nexd =pi^2*E*Ixd/(L^2); %Considerando Kx = 1 e Lx=L %flambagem por flexão em relação ao eixo central de inércia x da seção transversal
    Neyd =pi^2*E*Iyd/(esp_cv^2); %Considerando Ky = 1 e Ly=espaçamento entre contraventamentos %flambagem por flexão em relação ao eixo central de inércia y da seção transversal
    Nezd =G*J/(r0^2); %flambagem por torção em relação ao eixo longitudinal z
    Neyzd = ((Neyd+Nezd)/(2*(1-(y0/r0)^2)))*(1-sqrt(1-(4*Neyd*Nezd*(1-(y0/r0)^2))/((Neyd+Nezd)^2)));
    
    if (Nexd< Neyzd)
        Ned = Nexd;
    else
        Ned = Neyzd;
    end
    
    lamb0 = sqrt(Q*2*area*fy/Ned);
    
    if (lamb0 <= 1.5) % NBR 8800/2008 item 5.3.3 p44
        X = 0.658^(lamb0^2);
    else
        X = 0.877/(lamb0^2);
    end
    
    NRs(3,n) = Q*X*2*area*fy/1.1;
    
    %VERIFICAÇÃO DA ESBELTEZ
    indice_esbeltez=L/rxd;
    if indice_esbeltez>200
        NRs(3,n)=0;
    end

end



end
