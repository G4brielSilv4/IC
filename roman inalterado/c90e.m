%Função para o cálculo dos coeficients aerodinâmicos
%%Tabela 5 da NBR 6123/1988 em intervalos para o caso de h/b<=0.5%%

function C90e = c90e (incl,Cpi1,Cpi2)

 if (0<incl) && (incl<=5)
     alfa90EF = (-0.1*incl/5) -0.8;
 end
    
 if (5<incl) && (incl<=10)
     alfa90EF = (-0.3*(incl-5)/5) -0.9;
 end
 
 if (10<incl) && (incl<=15)
     alfa90EF = (0.2*(incl-10)/5) -1.2;
 end
 
 if (15<incl) && (incl<=20)
     alfa90EF = (0.6*(incl-15)/5) -1.0;
 end
    
 if (20<incl) && (incl<=30)
     alfa90EF = (0.4*(incl-20)/10) -0.4;
 end
 
  if (30<incl) && (incl<=45)
     alfa90EF = (0.3*(incl-30)/15);
  end
 
  if (45<incl) && (incl<=60)
     alfa90EF = (0.4*(incl-45)/15) +0.3;
  end
  
%Definição dos possíveis coeficientes de aerodinâmica  
C090e = alfa90EF;
C190e = -C090e + Cpi1;
C290e = -C090e + Cpi2;  
if (abs(C190e)>= abs(C290e))
     C90e = C190e;
 else C90e = C290e;
end

end
