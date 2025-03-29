%Função para o cálculo dos coeficients aerodinâmicos
%%Tabela 5 da NBR 6123/1988 em intervalos para o caso de h/b<=0.5%%

function C90d = c90d (incl,Cpi1,Cpi2)

 if (0<incl) && (incl<=5)
     alfa90GH = -0.4;
 end
    
 if (5<incl) && (incl<=10)
     alfa90GH = -0.4;
 end
 
 if (10<incl) && (incl<=15)
     alfa90GH = -0.4;
 end
 
 if (15<incl) && (incl<=20)
     alfa90GH = -0.4;
 end
    
 if (20<incl) && (incl<=30)
     alfa90GH = -0.4;
 end
 
  if (30<incl) && (incl<=45)
     alfa90GH = (-0.1*(incl-30)/15) -0.4; %interpolação
  end
 
  if (45<incl) && (incl<=60) 
     alfa90GH = (-0.1*(incl-45)/15) -0.5; %interpolação
  end
  
%Definição dos possíveis coeficientes de aerodinâmica  
 C090d = alfa90GH;
 C190d = -C090d + Cpi1;
 C290d = -C090d + Cpi2;  
if (abs(C190d)>= abs(C290d))
     C90d = C190d;
 else C90d = C290d;
end

end
