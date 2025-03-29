function [conec_3D,n_el_3D]=conectividades_3D(coord,conec,v,n_el,n_nos,n_divisoes_banzo_inf,n_divisoes_banzo_sup,n_tercas)
n_trelica=48/v+1;
n_el_3D=(n_el+2)*n_trelica+(6+n_tercas+(n_divisoes_banzo_inf-1)*2)*(n_trelica-1);
n_el_sec=n_el+2+6+n_tercas+(n_divisoes_banzo_inf-1)*2;
n_nos_sec=n_nos+6;

conec_3D=zeros(n_el_3D,3);

for trelica=0:n_trelica-1
    for el=1:n_el_sec
        if el+n_el_sec*trelica<=n_el_3D
            conec_3D(el+n_el_sec*trelica,1)=el+n_el_sec*trelica;
        end
        %barras 1 a 15
        if el<=n_el
            conec_3D(el+n_el_sec*trelica,2)=conec(el,3)+trelica*n_nos_sec;
            conec_3D(el+n_el_sec*trelica,3)=conec(el,4)+trelica*n_nos_sec;
        end
        %pilar esquerda
        conec_3D(n_el_sec*trelica+n_el+1,2)=coord(n_nos_sec*trelica+1,1);
        conec_3D(n_el_sec*trelica+n_el+1,3)=coord(n_nos_sec*trelica+n_nos+1,1);
        %pilar - direita
        conec_3D(n_el_sec*trelica+n_el+2,2)=coord(n_nos_sec*trelica+n_tercas,1);
        conec_3D(n_el_sec*trelica+n_el+2,3)=coord(n_nos_sec*trelica+n_nos+2,1);
        if trelica~=n_trelica-1
            if el<=n_tercas
                %tercas
                if el==1 || el==n_divisoes_banzo_inf+1
                    conec_3D(n_el_sec*trelica+n_el+el+2,2)=coord(n_nos_sec*trelica+el,1);
                    conec_3D(n_el_sec*trelica+n_el+el+2,3)=coord(n_nos_sec*(trelica+1)+el,1);
                else
                    conec_3D(n_el_sec*trelica+n_el+el+2,2)=coord(n_nos_sec*trelica+el+n_divisoes_banzo_inf,1);
                    conec_3D(n_el_sec*trelica+n_el+el+2,3)=coord(n_nos_sec*(trelica+1)+el+n_divisoes_banzo_inf,1);
                end
            end
            if el>1 && el<=n_divisoes_banzo_inf
                conec_3D(n_el_sec*trelica+el+n_el+n_tercas+1,2)=coord(n_nos_sec*trelica+el,1);
                conec_3D(n_el_sec*trelica+el+n_el+n_tercas+1,3)=coord(n_nos_sec*(trelica+1)+el+n_divisoes_banzo_inf,1);
            end
            if el>1 && el<=n_divisoes_banzo_inf
                conec_3D(n_el_sec*trelica+el+n_el+n_tercas+n_divisoes_banzo_inf,2)=coord(n_nos_sec*trelica+el+n_divisoes_banzo_inf,1);
                conec_3D(n_el_sec*trelica+el+n_el+n_tercas+n_divisoes_banzo_inf,3)=coord(n_nos_sec*(trelica+1)+el,1);
            end
                        
            %barras de contraventamento Y 1
            conec_3D(n_el_sec*(trelica+1)-5,2)=coord(n_nos_sec*trelica+n_nos+3,1);
            conec_3D(n_el_sec*(trelica+1)-5,3)=coord(n_nos_sec*trelica+n_nos+4,1);
            %barras de contraventamento Y 2
            conec_3D(n_el_sec*(trelica+1)-4,2)=coord(n_nos_sec*trelica+n_nos+4,1);
            conec_3D(n_el_sec*(trelica+1)-4,3)=coord(n_nos_sec*trelica+(n_nos-n_divisoes_banzo_sup+1),1);
            %barras de contraventamento Y 3
            conec_3D(n_el_sec*(trelica+1)-3,2)=coord(n_nos_sec*trelica+n_nos+4,1);
            conec_3D(n_el_sec*(trelica+1)-3,3)=coord(n_nos_sec*(trelica+1)+(n_nos-n_divisoes_banzo_sup+1),1); %retirar da matriz (todos)
            %barras de contraventamento Y 4
            conec_3D(n_el_sec*(trelica+1)-2,2)=coord(n_nos_sec*trelica+n_nos+5,1);
            conec_3D(n_el_sec*(trelica+1)-2,3)=coord(n_nos_sec*trelica+(n_nos-n_divisoes_banzo_sup+1),1);
            %barras de contraventamento Y 5
            conec_3D(n_el_sec*(trelica+1)-1,2)=coord(n_nos_sec*trelica+n_nos+5,1);
            conec_3D(n_el_sec*(trelica+1)-1,3)=coord(n_nos_sec*(trelica+1)+(n_nos-n_divisoes_banzo_sup+1),1);
            %barras de contraventamento Y 6
            conec_3D(n_el_sec*(trelica+1),2)=coord(n_nos_sec*trelica+n_nos+5,1);
            conec_3D(n_el_sec*(trelica+1),3)=coord(n_nos_sec*trelica+n_nos+6,1);
        end
    end
end