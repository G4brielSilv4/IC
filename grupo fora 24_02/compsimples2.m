%Compressão máxima que o perfil contoneira simples pode resistir pela
%NBR8800/2008.

function [NcRds,pen_trelica] = compsimples2 (n_el,conec,bw,tw,E,G,fy,x,y,rmin,Ix,Iy,An,Xbarra)
%CANTONEIRA SIMPLES
NcRds=zeros(n_el,1);
for el=1:n_el
    if conec(el,5)== 1
        bw_tw1 = bw(el)/tw(el);
        bw_tw1lim = 0.45*sqrt(E/fy);
        bw_tw1sup = 0.91*sqrt(E/fy);
        if (bw_tw1 <= bw_tw1lim) %Anexo F NBR 8800/2008 - P126
            Q = 1;
        else if (bw_tw1lim < bw_tw1) && (bw_tw1 <= bw_tw1sup)
                Q = 1.340-(0.76*bw_tw1*sqrt(fy/E));
            else Q = 0.53*E/(fy*(bw_tw1^2));
            end
        end
        
        %calculo do comprimento do elemento el
        no1=conec(el,3);
        no2=conec(el,4);
        L = sqrt((x(no2) - x(no1))^2 + (y(no2) - y(no1))^2);
        
        Imin = An(el)*(rmin(el)^2);
        Imax = Ix(el)+Iy(el)-Imin;
        Ixs = Imin;
        Iys = Imax;
        rxs = sqrt(Ixs/An(el));
        rys = sqrt(Iys/An(el));
        x0 =0;
        y0 = (Xbarra(el) - tw(el)/2)*sqrt(2);
        r0 =sqrt(rxs^2+rys^2+x0^2+y0^2);
        J =(2/3)*(bw(el)*tw(el)^3);
        
        Nexs =(pi^2)*E*Ixs/(L^2); %Considerando Kx = 1 e Lx=L
        Neys =(pi^2)*E*Iys/(L^2); %Considerando Ky = 1 e Ly=L = VER TRAVAMENTOS
        Nezs =G*J/(r0^2);
        Neyzs = ((Neys+Nezs)/(2*(1-(y0/r0)^2)))*(1-sqrt(1-(4*Neys*Nezs*(1-(y0/r0)^2))/((Neys+Nezs)^2)));
        
        if (Nexs < Neyzs)
            Nes = Nexs;
        else Nes = Neyzs;
        end
        
        lamb0 = sqrt(Q*An(el)*fy/Nes);
        
        if (lamb0 <= 1.5) % NBR 8800/2008 item 5.3.3 p44
            X = 0.658^(lamb0^2);
        else X = 0.877/(lamb0^2);
        end
        
        NcRds(el) = Q*X*An(el)*fy/1.1;
        
        %%
        %%VERIFICAÇÃO DA ESBELTEZ
        
        indice_esbeltez=L/rmin;
        pen_trelica=0;
        if indice_esbeltez>200
            pen_trelica=1e10;
        end
        
    end
end

end
