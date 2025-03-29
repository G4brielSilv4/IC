    
function [preco_total] = dadosdeentradav4(xvar)
format long

%VARIÁVEIS
% xvar(1) a xvar(4) --> perfil do elemento da treliça
% xvar(5) --> perfil da telha
% xvar(6) --> perfil da terça
% xvar(7) --> diâmetro do tirante Y
% xvar(8) --> diâmetro do tirante X
% xvar(9)--> espaçamento entre banzos da treliça
% xvar(10)--> altura da cobertura
% xvar(11)--> espaçamento entre porticos
% xvar(12) --> espaçamento entre nós (em função da telha)
% xvar(13) --> número de divisões do banzo inferior
% xvar(14) --> número de terças
% xvar(15) --> número de contraventamentos
% xvar(16) --> perfil da cantoneira da mão francesa
% xvar(17) --> perfil da escora comprimida no contraventamento das tercas
% xvar(18) --> espaçamento entre as escoras do contraventamento das tercas
% xvar(19) --> pefil da cantoneira dupla do banzo do contraventamento das terças

global b

for n=1:4
    xvar(n)=round(xvar(n));
end

perfil_telha=round(xvar(5));
perfil_terca=round(xvar(6));
perfil_tirante_y=round(xvar(7));
perfil_tirante_x=round(xvar(8));
esp_entre_banzos=xvar(9);
altura_cobertura=round(xvar(10)*100)/100;

espacamento=[48.00
		24.00
		16.00
		12.00
		9.60
		8.00 
		6.86 
		6.00 
		5.33 
		4.80 
		4.36 
		4.00 
		3.69 
		3.43 
		3.20
		3.00
		2.82 
		2.67 
		2.52 
		2.40 
		2.28 
		2.18 
		2.08 
		2.00 ];

espacamento_entre_porticos=espacamento(round(xvar(11)));

t_espacamento=round(xvar(12));
n_divisoes_banzo_inf=round(xvar(13));
perfil_mao_francesa=round(xvar(16));
perfil_contravent_tercas=round(xvar(17));

%DEFINIÇÕES
h=6; %pé direito do pórtico, sem contar a treliça, em m.

esp_divisao_banzo_inf=b/((n_divisoes_banzo_inf)*2);

%DEFINIÇÕES - VENTO
V = 43; %m/s - Vento de Florianópolis - Isopletas Figura 1 NBR 6123/1988
S1 = 1; %Item 5.2 a) Terreno plano - NBR 6123/1988
S3 = 0.95; %Grupo 3 Tabela 3 NBR 6123/1988

%Pressões Internas, ver NBR 6123/1988 item 6.2.5 a) = simplificado da
%mesma forma que o galpão da CBCA
Cpi1 = 0.2;
Cpi2 = -0.3;

%DEFINIÇÕES - CARGAS ATUANTES
telha = [0.43 39
    0.5 45.6
    0.65 60
    0.80 74.3
    0.95 88.6
    1.25 116.9]; %N/m² telha trapezoidal  40 Zn-Al com espessura = 0.43, 0.5, 0.65, 0.8, 0.95 e 1.25 mm

%distância máxima entre terças (m), carga admissível máxima na telha
%(N/m²) e peso (kg/m²)
cargaamdt = [1.75	2200	2550	3300	4040	4760	6190
    2.00	1690	1950	2530	3090	3650	4740
    2.25	1330	1540	2000	2440	2880	3750
    2.50	1020	1190	1530	1870	2210	2280
    2.75	770     890     1150	1410	1660	2160
    3.00	590     690     890     1080	1280	1660];

sc = 250; %N/m² item B.5.1 NBR 8800/2008 P 112

%DEFINIÇÕES - SOLDA
Ct= 0.8; %adotada solda com ct 0,8 (rocomendação do prof, se sobrar tempo voltar aqui)
%Ct=1-(ec/lc) entra 0,6 e 0,9 = solda longitudinal. Ver P39 NBR 8800/2008.


%% DADOS DAS CANTONEIRAS
%Áreas (m2)
Areas =[0.000148
    0.000193
    0.000232
    0.000271
    0.000310
    0.000458
    0.000580
    0.000703
    0.000929
    0.001090
    0.001251
    0.001548
    0.001573
    0.001950
    0.002329
    0.002810];

E = 200e9; %(N/m2)
G = 77e9; %(N/m2)
fy = 250e6; %N/m2
fu = 400e6;

%Características do perfil cantoneira simples
bw_ = [0.0254
    0.03175
    0.038100
    0.044450
    0.050800
    0.050800
    0.063500
    0.076200
    0.076200
    0.088900
    0.101600
    0.101600
    0.127000
    0.127000
    0.127000
    0.152400];%m

tw_ = [0.00318
    0.00318
    0.00318
    0.00318
    0.00318
    0.00476
    0.00476
    0.00476
    0.00635
    0.00635
    0.00635
    0.00794
    0.00635
    0.00794
    0.00952
    0.00952];%m

Ix_ = [0.0000000083
    0.0000000167
    0.0000000333
    0.0000000541
    0.0000000791
    0.0000001170
    0.0000002300
    0.0000004000
    0.0000005000
    0.0000008370
    0.0000012500
    0.0000015400
    0.0000025163
    0.0000030800
    0.0000036200
    0.0000064100];%m4

Iy_ = Ix_;%m4

rx_ = [0.0079
    0.0097
    0.01170
    0.01400
    0.01600
    0.01580
    0.01980
    0.02390
    0.02360
    0.02770
    0.03170
    0.03150
    0.04000
    0.03970
    0.03940
    0.04780];%m

ry_ = rx_;%m

rmin_ = [0.0048
    0.0064
    0.00760
    0.00890
    0.01020
    0.01020
    0.01240
    0.01500
    0.01500
    0.01760
    0.02000
    0.02000
    0.02530
    0.02530
    0.02510
    0.03020];%m

Xbarra_ = [0.0076
    0.0089
    0.01070
    0.01220
    0.01400
    0.01450
    0.01750
    0.02080
    0.02130
    0.02460
    0.02770
    0.02840
    0.03410
    0.03470
    0.03530
    0.04170];%m

%% DADOS DO PERFIL U

% Perfis U laminados Gerdau
AAreas_=1e-4*[7,78
    9,48
    10,10
    11,90
    15,50
    19,90
    21,68
    25,93
    29 ,00
    39,30
    37,90
    47,40
    ]; %m²

Ixx_=1e-8*[68,90
    77,20
    159,50
    174,40
    546,00
    632,00
    1344,30
    1490 ,00
    2800 ,00
    5370 ,00
    3290 ,00
    6010 ,00
    ];

Iyy_=1e-8*[8,20
    10,30
    13,10
    15,50
    28,80
    36,00
    54,10
    62,40
    95,00
    161,00
    117,00
    186,00
    ];

rxx_=1e-2*[2,98
    2,85
    3,97
    3,84
    5,94
    5,63
    7,87
    7,59
    9,84
    11,70
    9,31
    11,30
    ];

ryy_=1e-2*[1,03
    1,04
    1,14
    1,14
    1,36
    1,34
    1,42
    1,42
    1,81
    2,03
    1,76
    1,98
    ];

%bf é a dimensao total da mesa e tf a espessura da mesa
bff_=1e-3*[35,81
    35,05
    40 ,23
    41,83
    48,77
    51,66
    57,40
    59,51
    66,04
    74,00
    69,57
    77,00
    ];

tff_=1e-3*[6,93
    6,93
    7,52
    7,52
    8,71
    8,71
    9,50
    9,50
    11,10
    12,70
    11,10
    12,70
    ];

%bw é a altura da alma e tw a espessura da alma
bww_=1e-3*[62,34
    62,34
    86,56
    86,56
    134,98
    134,98
    184,2
    184,2
    231,8
    228,6
    282,8
    279,6
    ];

tww_=1e-3*[4,32
    6,55
    4,67
    6,27
    5,08
    7,98
    5,59
    7,70
    6,10
    7,20
    9,63
    9,80   
    ];

% X é a distancia entre o centro geometrico e a face externa da alma
XX_=1e-2*[1,11
    1,11
    1,16
    1,15
    1,30
    1,27
    1,47
    1,42
    1,61
    1,77
    1,54
    1,71
    ];

area_escora_comp=AAreas_(perfil_contravent_tercas);%m2
XX= XX_(perfil_contravent_tercas); %m
Iyy=Ixx_(perfil_contravent_tercas); % troca de eixos para que o eixo de simetria seja o eixo y
Ixx=Iyy_(perfil_contravent_tercas); %m4
bww=bww_(perfil_contravent_tercas); %m
tww=tww_(perfil_contravent_tercas); %m
bff=bff_(perfil_contravent_tercas); %m
tff=tff_(perfil_contravent_tercas); %m
ryy=rxx_(perfil_contravent_tercas); % troca de eixos para que o eixo de simetria seja o eixo y
rxx=ryy_(perfil_contravent_tercas); %m

assignin('base','area_terca',area_escora_comp);

%% DADOS DAS BARRAS REDONDAS TREFILADAS DOS TIRANTES DO CONTRAVENT DAS TERÇAS

% para o dimensionamento de barras redondas com extremidades rosqueadas  
% verifica-se a menor resistência entre o escoamento da seção bruta e a 
% ruptura da seção rosqueada.

% A recomendação de limitar o índice de esbeltez não precisa ser avaliada,  
% desde que as barras rosqueadas sejam colocadas com alguma pré-tensão.

d_=[0.012
    0.0127
    0.0133
    0.014
    0.01428
    0.01435
    0.0145
    0.015];

d_tir=d_(perfil_tirante_x); %t4 - diâmetro do tirante

%Área bruta
Ab_tir_x = 0.25*pi*(d_tir^2);

area_contraventamento=Ab_tir_x;
assignin('base','area_contraventamento',area_contraventamento);

%Área efetiva
Ae=0.75*Ab_tir_x;

%6.3.3.1 da ABNT NBR8800/2008

%força de tração resistente de cálculo
FtRdt_tir=Ae*fu/1.35;

%força de tração resistente para o escoamento da seção bruta
FtRde_tir=Ab_tir_x*fy/1.1;

if FtRdt_tir<FtRde_tir
    FtRd_tir=FtRdt_tir;
else
    FtRd_tir=FtRde_tir;
end
%% CALCULO DO NUMERO DE NOS E CONEXAO ENTRE ELEMENTOS  DO CONTRAVENTAMENTO

num_esc = round(b/3);%num total de escoras
num_nos_cv=num_esc*2; %cada escora tem dois nos que sao os nos de coneccao dos tirantes tbm
num_tirante=num_esc-1; %num de tirantes (apenas os tracionados, metade da quantidae real de tirantes)
n_el_cv=num_esc + num_tirante + (num_tirante*2);%numero de elementos do contraventamento, desconsiderando os tirantes comprimidos(escoras, tirantes e banzos do portico)

b_rebatido=sqrt((b/2)^2+(altura_cobertura^2));  %tamanho da treliça de contraventamento rebatida de uma agua
dist_entre_esc= (b_rebatido*2)/(num_esc-1); % distancia entre escoras no eixo x (plano da treliça de cv rebatida)
dist_z=(b/(num_esc-1));

assignin('base','dist',dist_entre_esc)

xx=zeros(num_nos_cv,1);
zz=zeros(num_nos_cv,1);%posicao dos nos em x no plano da linha do horizonte, sem rebatimento
yy=zeros(num_nos_cv,1);
% Coordenada x e y 

for i=1:num_nos_cv
    
    if i<=(num_nos_cv/2)
        yy(i)=0;
        xx(i)=dist_entre_esc*(i-1);  %distancia entre escoras * (i-1)
        zz(i)=dist_z*(i-1);
    else
        yy(i)= espacamento_entre_porticos;
        xx(i)=dist_entre_esc*(i-(1+num_nos_cv/2));
        zz(i)=dist_z*(i-(1+num_nos_cv/2));
    end
end

assignin('base','xx',xx);
assignin('base','yy',yy);
assignin('base','zz',zz);

dx=xx(2)-xx(1);
conec_esc=zeros(n_el_cv,5);% Conectividade: [n do elemento   area   nó_1    nó_2    comprimento L] - matriz para dizer quais nós pertencem a cada elemento
i=1;
for el_esc=1:n_el_cv
    conec_esc(el_esc,1)= el_esc;
    
    % ESCORAS COMPRIMIDAS, perfil tipo u
    
    if el_esc <=(num_nos_cv/2)
        conec_esc(el_esc,2) = area_escora_comp;           %área
        conec_esc(el_esc,3) = el_esc;                     %nó i
        conec_esc(el_esc,4) = el_esc + (num_nos_cv/2);    %nó j
        conec_esc(el_esc,5) = espacamento_entre_porticos; %comprimento do elemento
        
    % TIRANTES, lembrando que nao estao sendo considerados os tirantes comprimidos
        
    elseif el_esc <= ((num_tirante/2) + (num_nos_cv/2)) && el_esc >(num_nos_cv/2)
        conec_esc(el_esc,2) = area_contraventamento;                       % área BRUTA, tbm tem a Ae area efetiva
        conec_esc(el_esc,3) = el_esc;                                      % nó i
        conec_esc(el_esc,4) = 1+(el_esc-(num_nos_cv/2));                   % nó j
        conec_esc(el_esc,5) = sqrt((espacamento_entre_porticos^2)+(dx^2)); %comprimento do elemento
        
        
    elseif el_esc <= (num_nos_cv - 1) && el_esc > ((num_tirante/2) + (num_nos_cv/2))
        conec_esc(el_esc,2) = area_contraventamento;                       % área bruta
        conec_esc(el_esc,3) = el_esc + 1;                                  % nó i
        conec_esc(el_esc,4) = el_esc - (num_nos_cv/2);                     % no j
        conec_esc(el_esc,5) = sqrt((espacamento_entre_porticos^2)+(dx^2)); %comprimento do elemento
    
    
    % BANZOS
    
    elseif el_esc >= num_nos_cv && (el_esc + 2 - num_nos_cv) <= (num_nos_cv / 2)
        conec_esc(el_esc,2) = Areas(round(xvar(2))) * 2;    %área cantoneira dupla (banzo superior da treliça de cobertura)
        conec_esc(el_esc,3) = (el_esc + 1) - num_nos_cv;    %nó i
        conec_esc(el_esc,4) = (el_esc + 2) - num_nos_cv;    %nó j
        conec_esc(el_esc,5) = dx;                           %comprimento do elemento
    else
        conec_esc(el_esc,2) = Areas(round(xvar(2))) * 2; %área cantoneira dupla
        conec_esc(el_esc,3) = (num_nos_cv/2) + i;        %nó i
        conec_esc(el_esc,4) = (num_nos_cv/2) + i + 1;    %nó j
        conec_esc(el_esc,5) = dx;                        %comprimento do elemento
        i=i+1;
    end
   
end
assignin('base','conec_esc',conec_esc);
% APOIOS
n_rest_cv=2;  %número de nós restringidos - apoios

GDL_rest_cv=[1 1 1
    ((num_nos_cv)/2) 1 1];  %[nó   restringido_x   restringido_y] (1 para restringido, e 0 para livre)

n_forcas_cv=(num_nos_cv/2);
%% CALCULO DO NUMERO DE NOS E CONEXAO ENTRE ELEMENTOS DA TRELIÇA

% APOIOS
n_rest=2;  %número de nós restringidos - apoios

% APOIOS
GDL_rest=[1 1 1
    ((n_divisoes_banzo_inf+1)*2+1) 1 1];  %[nó   restringido_x   restringido_y] (1 para restringido, e 0 para livre)

% Número de nós e elementos
n_nos=(n_divisoes_banzo_inf+1)*4;
n_el=(n_divisoes_banzo_inf+1)*8-3;
n_divisoes_banzo_sup=n_divisoes_banzo_inf;

[n_tercas,n_contraventamentos]=tercas_contraventamentos(n_divisoes_banzo_inf,xvar);

esp_terca=sqrt((b/2)^2+altura_cobertura^2)/((n_tercas-1)/2);
terca_a_cada_divisao_banzo_sup=n_divisoes_banzo_sup/((n_tercas-1)/2);

esp_cv=sqrt((b/2)^2+altura_cobertura^2)/((n_contraventamentos-1)/2);
cv_a_cada_divisao_banzo_inf=n_tercas/n_contraventamentos;

% n_contraventamentos=n_contraventamentos-2;

x=zeros(n_nos,1);
y=zeros(n_nos,1);
% Coordenada x e y
for no=1:n_nos
    if no<=n_nos/4+1
        if no==1
            x(no)=0;
            y(no)=0;
        elseif no==n_nos/4+1
            x(no)=b/2;
            y(no)=altura_cobertura;
        else
            x(no)=esp_divisao_banzo_inf*(no-2)+esp_divisao_banzo_inf/2;
            y(no)=((no-1)*2-1)/(n_divisoes_banzo_inf*2)*altura_cobertura;
            y(n_nos/2+2-no)=y(no);
        end
    elseif no>n_nos/4+1 && no<=n_nos/2+1
        if no==n_nos/2+1
            x(no)=b;
            y(no)=0;
        else
            x(no)=esp_divisao_banzo_inf*(no-3)+esp_divisao_banzo_inf/2;
        end
    elseif no>n_nos/2+1 && no<=3*n_nos/4+1
        x(no)=esp_divisao_banzo_inf*(no-n_nos/2-2);
        y(no)=(no-n_nos/2-2)*altura_cobertura/n_divisoes_banzo_inf+4*esp_entre_banzos;
        y(n_nos-no+n_nos/2+2)=y(no);
    else
        x(no)=esp_divisao_banzo_inf*(no-n_nos/2-2);
    end
end

% Conectividade: [n do elemento   seção-item anterior-    nó_1    nó_2    simples=1 duplo=2] - matriz para dizer quais nós pertencem a cada elemento
num_banzos_inf=0;
num_banzos_sup=0;
num_montantes=0;
maior_tam_diag=0;

conec=zeros(n_el,5);
for el=1:n_el
    conec(el,1)=el;
    if el<=n_divisoes_banzo_inf*2+2 %banzo inferior
        conec(el,2)=xvar(1); %área
        conec(el,3)=el; %nó i
        conec(el,4)=el+1; %nó j
        conec(el,5)=2; %simples ou duplo
        num_banzos_inf=el;
    end
    
    if el>n_divisoes_banzo_inf*2+2 && el<=(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*2 %banzo superior
        conec(el,2)=xvar(2);
        conec(el,3)=el+1; %nó i
        conec(el,4)=el+2; %nó j
        conec(el,5)=2; %simples ou duplo
        num_banzos_sup=el-num_banzos_inf;
    end
    
    if el>(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*2 && el<=(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*2+3 %diagonais verticais
        if el==(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*2+1
            conec(el,3)=1; %nó i
            conec(el,4)=(n_divisoes_banzo_inf+1)*2+2; %nó j
        end
        if el==(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*2+2
            conec(el,3)=(n_divisoes_banzo_inf+1)+1; %nó i
            conec(el,4)=(n_divisoes_banzo_inf+1)*3+1; %nó j
        end
        if el==(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*2+3
            conec(el,3)=(n_divisoes_banzo_inf+1)*2+1; %nó i
            conec(el,4)=n_nos; %nó j
        end
        conec(el,2)=xvar(3);
        conec(el,5)=1; %simples ou duplo
        num_montantes= el - num_banzos_sup - num_banzos_inf;
    end
    
    if el>(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*2+3 && el<=(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*3+3 %demais diagonais da esquerda - esquerda
        conec(el,2)=xvar(4);
        conec(el,3)=el-((n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*2+2); %nó i
        conec(el,4)=el-((n_divisoes_banzo_inf+1)*2); %nó j
        conec(el,5)=1; %simples ou duplo
        tam=sqrt((x(conec(el,4)) - x(conec(el,3)))^2 + (y(conec(el,4)) - y(conec(el,3)))^2);
        if tam>maior_tam_diag
            maior_tam_diag=tam;
        end
    end
    if el>(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*3+3 && el<=(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*4+3 %demais diagonais da direita
        conec(el,2)=xvar(4);
        conec(el,3)=el-((n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*3)-2; %nó i
        conec(el,4)=el-((n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup)+1; %nó j
        conec(el,5)=1; %simples ou duplo
        tam=sqrt((x(conec(el,4)) - x(conec(el,3)))^2 + (y(conec(el,4)) - y(conec(el,3)))^2);
        if tam>maior_tam_diag
            maior_tam_diag=tam;
        end
    end
    if el>(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*4+3 && el<=(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*5+3 %demais diagonais da direita
        conec(el,2)=xvar(4);
        conec(el,3)=el-((n_divisoes_banzo_inf+1)*5)+2; %nó i
        conec(el,4)=el-((n_divisoes_banzo_inf+1)*3)+2; %nó j
        conec(el,5)=1; %simples ou duplo
        tam=sqrt((x(conec(el,4)) - x(conec(el,3)))^2 + (y(conec(el,4)) - y(conec(el,3)))^2);
        if tam>maior_tam_diag
            maior_tam_diag=tam;
        end
    end
    if el>(n_divisoes_banzo_inf+1)*2+n_divisoes_banzo_sup*5+3 && el<=n_el %demais diagonais da direita
        conec(el,2)=xvar(4);
        conec(el,3)=el-((n_divisoes_banzo_inf+1)*6)+3; %nó i
        conec(el,4)=el-((n_divisoes_banzo_inf+1)*4)+2; %nó j
        conec(el,5)=1; %simples ou duplo
        tam=sqrt((x(conec(el,4)) - x(conec(el,3)))^2 + (y(conec(el,4)) - y(conec(el,3)))^2);
        if tam>maior_tam_diag
            maior_tam_diag=tam;
        end
    end
end

num_diagonais=n_el - num_montantes - num_banzos_sup - num_banzos_inf;

assignin('base','espacamento_entre_porticos',espacamento_entre_porticos)
assignin('base','altura_cobertura',altura_cobertura);
assignin('base','esp_entre_banzos',esp_entre_banzos);
assignin('base','h',h)
assignin('base','b',b)
assignin('base','v',espacamento_entre_porticos)
assignin('base','n_tercas',n_tercas)
assignin('base','esp_terca',esp_terca)
assignin('base','n_contraventamentos',n_contraventamentos)
assignin('base','x',x)
assignin('base','y',y)
assignin('base','conec',conec)
assignin('base','n_divisoes_banzo_inf',n_divisoes_banzo_inf)
assignin('base','n_divisoes_banzo_sup',n_divisoes_banzo_sup)
assignin('base','n_el',n_el)
assignin('base','n_el_cv',n_el_cv)
assignin('base','n_nos',n_nos)

assignin('base','num_banzos_sup',num_banzos_sup)
assignin('base','num_banzos_inf',num_banzos_inf)
assignin('base','num_montantes',num_montantes)
assignin('base','num_diagonais',num_diagonais)
assignin('base','maior_tam_diag',maior_tam_diag)

assignin('base','perfil_banzo_inf',xvar(1))
assignin('base','perfil_banzo_sup',xvar(2))
assignin('base','perfil_montantes',xvar(3))
assignin('base','perfil_diagonais',xvar(4))

assignin('base','perfil_esc',round(xvar(17)))
assignin('base','esp_divisao_banzo_inf',esp_divisao_banzo_inf)

%% PESO FINAL COM PENALIDADE
[preco_total] = calculosv4(perfil_telha,perfil_terca,perfil_tirante_y,h,b,espacamento_entre_porticos,V,S1,S3,Cpi1,Cpi2,x,y,n_nos,n_el,E,G,fy,fu,Areas,bw_,tw_,Ix_,Iy_,rx_,ry_,rmin_,Xbarra_,conec,n_rest,GDL_rest,telha,cargaamdt,sc,Ct,t_espacamento,esp_terca,n_divisoes_banzo_inf,n_divisoes_banzo_sup,terca_a_cada_divisao_banzo_sup,altura_cobertura,n_contraventamentos,n_tercas,esp_cv,cv_a_cada_divisao_banzo_inf,esp_entre_banzos,perfil_mao_francesa,xx,yy,zz,conec_esc,num_nos_cv,n_el_cv,n_rest_cv,GDL_rest_cv,n_forcas_cv,area_escora_comp,Iyy,Ixx,bww,tww,bff,tff,ryy,rxx,FtRd_tir,XX,num_tirante,num_esc,d_tir,dist_entre_esc,Ab_tir_x);
end