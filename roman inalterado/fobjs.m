function [lb,ub,fobj,dim] = fobjs(F)

global b

switch F

    case 'F1'
        fobj = @F1; % objective function to be minimized
        dim=16; % dimension of the problem
        
        %perfil do elemento da treliça
        lb1=1;
        ub1=9;
        
        lb(1,1)=lb1;  %lower bounds: column vector
        ub(1,1)=ub1;  %upper bounds: column vector
        
        %perfil do elemento da treliça
        lb2=1;
        ub2=9;
        
        lb(1,2)=lb2;  %lower bounds: column vector
        ub(1,2)=ub2;  %upper bounds: column vector
        
        %perfil do elemento da treliça
        lb3=1;
        ub3=9;
        
        lb(1,3)=lb3;  %lower bounds: column vector
        ub(1,3)=ub3;  %upper bounds: column vector
        
        %perfil do elemento da treliça
        lb4=1;
        ub4=9;
        
        lb(1,4)=lb4;  %lower bounds: column vector
        ub(1,4)=ub4;  %upper bounds: column vector
        
        %perfil da telha
        lb5=1;
        ub5=2;
        
        lb(1,5)=lb5;  %lower bounds: column vector
        ub(1,5)=ub5;  %upper bounds: column vector
        
        %perfil da terça
        lb6=1;
        ub6=9;
        
        lb(1,6)=lb6;  %lower bounds: column vector
        ub(1,6)=ub6;  %upper bounds: column vector
        
        %diâmetro do tirante Y
        lb7=1;
        ub7=6;
        
        lb(1,7)=lb7;  %lower bounds: column vector
        ub(1,7)=ub7;  %upper bounds: column vector
        
        %diâmetro do tirante X
        lb8=1;
        ub8=6;
        
        lb(1,8)=lb8;  %lower bounds: column vector
        ub(1,8)=ub8;  %upper bounds: column vector
        
        %espaçamento entre banzos da treliça
        lb9=0.3;
        ub9=0.9;
        
        lb(1,9)=lb9;  %lower bounds: column vector
        ub(1,9)=ub9;  %upper bounds: column vector
        
        %altura da cobertura
        lb10=(b/2)*0.05;
        ub10=(b/2)*0.45;
        
        lb(1,10)=lb10;  %lower bounds: column vector
        ub(1,10)=ub10;  %upper bounds: column vector
        
        %espaçamento entre porticos
        lb11=10;
        ub11=22;
        
        lb(1,11)=lb11;  %lower bounds: column vector
        ub(1,11)=ub11;  %upper bounds: column vector
        
        %espaçamento entre nós (em função da telha)
        lb12=1;
        ub12=6;
        
        lb(1,12)=lb12;  %lower bounds: column vector
        ub(1,12)=ub12;  %upper bounds: column vector
        
        %número de divisões do banzo inferior
        lb13=6;
        ub13=24;
        
        lb(1,13)=lb13;  %lower bounds: column vector
        ub(1,13)=ub13;  %upper bounds: column vector
        
        %número de terças
        lb14=1;
        ub14=5;
        
        lb(1,14)=lb14;  %lower bounds: column vector
        ub(1,14)=ub14;  %upper bounds: column vector
        
        %número de contraventamentos
        lb15=1;
        ub15=8;
        
        lb(1,15)=lb15;  %lower bounds: column vector
        ub(1,15)=ub15;  %upper bounds: column vector
        
        %perfil da cantoneira da mão francesa
        lb16=1;
        ub16=1;
        
        lb(1,16)=lb16;  %lower bounds: column vector
        ub(1,16)=ub16;  %upper bounds: column vector
end

    function o = F1(xvar)
     o=dadosdeentradav4(xvar);
   
    end
end
