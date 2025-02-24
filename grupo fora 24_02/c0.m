%Função para o cálculo dos coeficients aerodinâmicos
%%Tabela 5 da NBR 6123/1988 em intervalos para o caso de h/b<=0.5%%

function C0 = c0 (incl,Cpi1,Cpi2)

 if (0<incl) && (incl<=5)
     alfa0EG = -0.8;
     alfa0FH = -0.4;
 end
    
 if (5<incl) && (incl<=10)
     alfa0EG = -0.8;
     alfa0FH = (-0.2*(incl-5)/5) -0.4;
 end
 
 if (10<incl) && (incl<=15)
     alfa0EG = -0.8;
     alfa0FH = -0.6;
 end
 
 if (15<incl) && (incl<=20)
     alfa0EG = (0.1*(incl-15)/5) -0.8;
     alfa0FH = -0.4;
 end
    
 if (20<incl) && (incl<=30)
     alfa0EG = -0.7;
     alfa0FH = -0.6;
 end
 
  if (30<incl) && (incl<=45)
     alfa0EG = -0.7;
     alfa0FH = -0.6;
  end
 
  if (45<incl) && (incl<=60)
     alfa0EG = -0.7;
     alfa0FH = -0.6;
  end
  
%Definição dos possíveis coeficientes de aerodinâmica  
 if (abs(alfa0EG)>=abs(alfa0FH))
     C00 = alfa0EG;
 else C00 = alfa0FH;
 end

C10 = -C00 + Cpi1;
C20 = -C00 + Cpi2;
if (abs(C10)> abs(C20))
     C0 = C10;
 else C0 = C20;
end

end
