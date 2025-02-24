function coord=coordenadas_3D(x, y, n_nos,h,b,altura_trelica,v,n_tercas)
n_trelica=48/v+1;

n_nos_tot=(n_nos+6)*n_trelica-4;
x1=zeros(n_nos_tot,1);
y1=zeros(n_nos_tot,1);
z1=zeros(n_nos_tot,1);
n_nos_sec=n_nos+6; %numero de nós de uma seçao
for trelica=0:n_trelica-1
    for no=1:n_nos_sec
        if no<=n_nos
            x1(n_nos_sec*(trelica)+no,1)=x(1,no);
        end
        x1(n_nos_sec*(trelica+1)-5)=0; %pilar esquerda
        x1(n_nos_sec*(trelica+1)-4)=b; %pilar direita
        
        if trelica~=n_trelica-1
            x1(n_nos_sec*(trelica+1)-3)=0;
            x1(n_nos_sec*(trelica+1)-2)=((n_tercas-1)/2-1)/((n_tercas-1)/2)*(b/2);
            x1(n_nos_sec*(trelica+1)-1)=((n_tercas-1)/2+1)/(n_tercas-1)*b;
            x1(n_nos_sec*(trelica+1))=b;
        end
        if no<=n_nos
            y1(n_nos_sec*(trelica)+no,1)=y(1,no);
        end
        y1(n_nos_sec*(trelica+1)-5)=-h; %pilar direita
        y1(n_nos_sec*(trelica+1)-4)=-h; %pilar direita
        
        if trelica~=n_trelica-1
            y1(n_nos_sec*(trelica+1)-3)=0;
            y1(n_nos_sec*(trelica+1)-2)=((n_tercas-1)/2-1)/((n_tercas-1)/2)*altura_trelica;
            y1(n_nos_sec*(trelica+1)-1)=((n_tercas-1)/2-1)/((n_tercas-1)/2)*altura_trelica;
            y1(n_nos_sec*(trelica+1))=0;
        end
        if no<=n_nos_sec-4
            z1(n_nos_sec*(trelica)+no)=v*trelica;
        end
        if trelica~=n_trelica-1
            if no>n_nos_sec-4
                z1(n_nos_sec*(trelica)+no)=v*trelica+v/2;
            end
        end
    end
end
for no=1:n_nos_tot
   coord(no,1)=no;
end
 
coord(:,2)=x1;
coord(:,3)=y1;
coord(:,4)=z1;
 
end


