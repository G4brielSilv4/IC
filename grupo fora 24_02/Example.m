close all
clear all
clc
rand('state',0)
format long
tic

global OFEs
global b
global preco_final
preco_final=1e12;
OFEs=0;
Fobj = 'F1';
%% SGA Parameters
AlfaMin=0.1;    % minimum value that alpha may assume in Eq.(6): see section 3.4 ------ era 0.1
AlfaInitial=2;       % initial value of alpha: Eq.(6) --------------------------------- era 2
NIterations=1000;         % maximum number of iterations (it_max)
GlobalIterationsRatio = 0.3; % percentage of itmax dedicated to global phase selection scheme: see section 3.5
PopulationSize = 100;      % population size: npop of Eq.(4)
SearchGroupRatio=0.2;          % percentage of npop that forms the search group (0.2 = 20% of 100)
NPerturbed = 3;     % number of mutated individuals of the search group: see Eq.(5) in section 3.3
PlotFamily = false;     % define if plot the value of families
b=20;
n_iteracoes=1;

for largura=1:1
    for rodada=1:n_iteracoes
        %% Call SGA
        [fopt,xopt] = SGA(Fobj,AlfaInitial,AlfaMin,PopulationSize,SearchGroupRatio,NIterations,GlobalIterationsRatio,NPerturbed,PlotFamily);
        xopt;  % minimum found
        fopt;  % objective function value at the minimum
        99;
        
        area_banzo_inf=An(1);
        area_banzo_sup=An((n_divisoes_banzo_inf+1)*2+1);
        area_barra_vert=An((n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_inf*2+1);
        area_barra_inc=An((n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_inf*2+4);
        Tempo=toc;

        disp('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*')
        
        disp(['Largura do galpão: ',num2str(b)])
        
        disp(' ')
        disp(['Rodada: ',num2str(rodada)])
        
        disp(' ')
        disp(['A massa de uma treliça é ',num2str(peso_trelica_sec),' kg'])
        
        disp(' ')
        disp(['A massa da cobertura é ',num2str(peso_trelica_total),' kg'])
        
        disp(' ')
        disp(['O preço total da cobertura é ',num2str(custo_total),' reais'])
        
        disp('----------------------------------------------------------------------')
        disp(['Área das barras do banzo inferior: ',num2str(area_banzo_inf*10000),' cm²'])
        
        disp(' ')
        disp(['Área das barras do banzo superior: ',num2str(area_banzo_sup*10000),' cm²'])
        
        disp(' ')
        disp(['Área da barra vertical: ',num2str(area_barra_vert*10000),' cm²'])
        
        disp(' ')
        disp(['Área da barra inclinada: ',num2str(area_barra_inc*10000),' cm²'])
        
        disp(' ')
        disp(['Número de divisões do banzo inferior: ',num2str(n_divisoes_banzo_inf)])
        
        disp(' ')
        disp(['A espessura da telha: ',num2str(espessura_telha),' mm'])
        
        disp(' ')
        disp(['Número de terças: ',num2str(n_tercas)])
        
        disp(' ')
        disp(['O espaçamento máximo entre terças: ',num2str(espmax),' m'])
        
        disp(' ')
        disp(['Espaçamento efetivo entre terças: ',num2str(esp_terca),' m'])
        
        disp(' ')
        disp(['Área das terças com perfil U: ',num2str(area_terca*10000),' cm²'])
        
        disp(' ')
        disp(['O diâmetro do tirante Y: ',num2str(diametro_tirante_y*100),' cm'])
        
        disp(' ')
        disp(['Área da mão francesa: ',num2str(area_mao_francesa*10000),' cm²'])
        
        disp(' ')
        disp(['Número de contraventamentos (mão francesa): ',num2str(n_contraventamentos)])
        
        disp(' ')
        disp(['A altura da treliça: ',num2str(altura_cobertura),' m'])
        
        disp(' ')
        disp(['Espaçamento entre banzos: ',num2str(esp_entre_banzos),' m'])
        
        disp(' ')
        disp(['O espaçamento entre treliças: ',num2str(espacamento_entre_porticos),' m'])
        
        disp('----------------------------------------------------------------------')
        disp(['Massa total da telha trapezoidal 40: ',num2str(peso_telha_total),' kg'])
        
        disp(' ')
        disp(['Massa total do perfil U (terças): ',num2str(peso_terca_total),' kg'])
        
        disp(' ')
        disp(['Massa total das barras redondas trefiladas (tirantes em Y): ',num2str(peso_tirante_y_total),' kg'])
        
        disp(' ')
        disp(['Massa total dos perfis cantoneira (mão francesa): ',num2str(peso_mao_francesa_total),' kg'])
        
        disp(' ')
        disp(['Massa total dos perfis cantoneira (treliças): ',num2str(peso_trelica_total),' kg'])
        
        disp('----------------------------------------------------------------------')
        disp(['Custo total da telha trapezoidal 40: ',num2str(preco_telha_total),' reais'])
        
        disp(' ')
        disp(['Custo total do perfil U (terças): ',num2str(preco_terca_total),' reais'])
        
        disp(' ')
        disp(['Custo total das barras redondas trefiladas (tirantes em Y): ',num2str(preco_tirante_y_total),' reais'])
        
        disp(' ')
        disp(['Custo total das barras redondas trefiladas (tirantes em X): ',num2str(preco_tirante_x_total),' reais'])
        
        disp(' ')
        disp(['Custo total dos perfis cantoneira (mão francesa): ',num2str(preco_mao_francesa_total),' reais'])
        
        disp(' ')
        disp(['Custo total dos perfis cantoneira (treliças): ',num2str(preco_trelica_total),' reais'])
        
        disp('----------------------------------------------------------------------')
        disp(['Tempo de execução do código: ',num2str(Tempo/3600),' h'])
        
        disp('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*')
        
        desenho(x,y,n_el,conec)

        
    end
end


