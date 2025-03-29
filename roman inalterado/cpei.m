%Função para o cálculo dos coeficients de pressão externa +interna
%favorável a sucção
%%Tabela 5 da NBR 6123/1988 em intervalos para o caso de h/b<=0.5%%

function CpeCpi = cpei (incl,Cpi2)

 if (0<incl) && (incl<=5)
     CpeCpi = ((-0.6*incl/5) +2)+Cpi2;
 end
    
 if (5<incl) && (incl<=10)
     CpeCpi = 1.4+Cpi2;
 end
 
 if (10<incl) && (incl<=15)
     CpeCpi = 1.4+Cpi2;
 end
 
 if (15<incl) && (incl<=20)
    CpeCpi = ((-0.2*(incl-15)/5) +1.4)+Cpi2;
 end
    
 if (20<incl) && (incl<=30)
     CpeCpi = ((-0.1*(incl-20)/10) +1.2)+Cpi2;
 end
 
  if (30<incl) && (incl<=45)
     CpeCpi = 1.1+Cpi2;
  end
 
  if (45<incl) && (incl<=60)
     CpeCpi = 1.1+Cpi2;
  end

end
