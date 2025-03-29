function [ppterca,preco_terca_sec,penalidade,peso_terca_sec,area_terca] = tercav2 (perfil_terca,carga_telha,tirantey,sc,esp_terca,p,incl,Cpi2,espacamento_entre_porticos,E,fy,n_tercas,pp_mao_francesa,comprimento_mao_francesa)
%Considerações 
% - por economia, adota-se perfil dobrado a         frio, com seção do tipo U; 
% - a norma brasileira NBR 8800não cobre o dimensionamento de perfis metálicos  - logo  foi utilizado o método das tensões admissíveis de chapa fina dobrados a frio;
%usado as cnsiderações p 27 cbca


% %de um modo geral as terças 
% são escolhidas de forma que a altura da 
% seção varie de 1/40 a 1/60 do vão;

Areas_=1e-4*[3.65
4.35
4.60
5.49
5.55
6.63
7.70
8.75
9.80
10.83
11.85
13.39
16.02
17.02
22.59]; %cm²

Wx_=1e-6*[11.6
13.7
19.9
23.6
29.9
35.4
40.9
46.2
51.4
56.4
61.3
68.6
90.5
100.0
152.8];

Wy_=1e-6*[2.52
3.00
2.66
3.17
2.74
3.26
3.78
4.29
4.79
5.29
5.77
6.51
13.20
17.11
18.36];

Ix_=1e-8*[58.1
68.5
149.9
177.4
299.3
354.9
409.3
462.4
514.1
564.5
613.6
686.2
905.6
1000.7
1910.7];  

Wx=Wx_(perfil_terca); %m3
Wy=Wy_(perfil_terca); %m3
Ix=Ix_(perfil_terca); %m4
area_terca=Areas_(perfil_terca);

assignin('base','area_terca',area_terca);

%Maior valor de Coeficiente de pressão externa + coeficiente de pressão
%interna (favorável a sucção) - Tabela 5 NBR8800 p15
Cpei = cpei (incl,Cpi2);

ppU= 77000*area_terca; %(N/m)
PPU= ppU + carga_telha*esp_terca + tirantey; %N/m 
scU= sc*esp_terca; %N/m 
q_suc = p*Cpei*esp_terca; %N/m

%COMBINAÇÃO DE AÇÕES ELU - HIPÓTESES 

UHIP1x= 1.25*PPU*cos(incl*2*pi/360) + 1.5*scU*cos(incl*2*pi/360);
UHIP1y= 1.25*PPU*sin(incl*2*pi/360) + 1.5*scU*sin(incl*2*pi/360);

CHIP1x=1.25*max(pp_mao_francesa)*cos(incl*2*pi/360); %carga concentrada
CHIP1y=1.25*max(pp_mao_francesa)*sin(incl*2*pi/360); %carga concentrada

UHIP2x= 1.0*PPU*cos(incl*2*pi/360) + 1.4*q_suc;
UHIP2y= 1.0*PPU*sin(incl*2*pi/360);

CHIP2x=1.0*max(pp_mao_francesa)*cos(incl*2*pi/360); %carga concentrada
CHIP2y=1.0*max(pp_mao_francesa)*sin(incl*2*pi/360); %carga concentrada

M1x = UHIP1x*(espacamento_entre_porticos^2)/8 + CHIP1x*max(comprimento_mao_francesa)*cos(45*pi/180); %Carga distribuida +concentrada
M1y = UHIP1y*((espacamento_entre_porticos/2)^2)/8 + CHIP1y*max(comprimento_mao_francesa)*cos(45*pi/180); %TIRANTE Y NO MEIO DO VÃO %Carga distribuida +concentrada

M2x = UHIP2x*(espacamento_entre_porticos^2)/8+CHIP2x*max(comprimento_mao_francesa)*cos(45*pi/180); %Carga distribuida +concentrada
M2y = UHIP2y*((espacamento_entre_porticos/2)^2)/8+CHIP2y*max(comprimento_mao_francesa)*cos(45*pi/180); %Carga distribuida +concentrada


%%%%%%VERIFICAÇÕES
%Manual CBCA -  considera-se ainda que as fixações das 
% telhas sobre as terças evitarão problemas 
% de flambagem lateral e torção. 

fb1x= M1x/Wx;
fb1y=M1y/Wy;

fb2x= M2x/Wx;
fb2y=M2y/Wy;

%MAIOR INÉRCIA = MAIOR CARGA
q= PPU*cos(incl*2*pi/360) + 0.6*scU*cos(incl*2*pi/360);
p=max(pp_mao_francesa)*cos(incl*2*pi/360);

flecha=5*q*(espacamento_entre_porticos^4)/(384*E*Ix)+p/(24*E*Ix)*(3*espacamento_entre_porticos^2-4*max(comprimento_mao_francesa)^2);
flechalim= espacamento_entre_porticos/180;

%Vento de sucção com valor característico
flecha_suc=5*q_suc*(espacamento_entre_porticos^4)/(384*E*Ix);
flechalim_suc= espacamento_entre_porticos/120;

penalidade=0;
if (fb1x+fb1y)>(0.6*fy) ||(fb2x+fb2y)>(1.33*0.6*fy) || flecha>flechalim || flecha_suc>flechalim_suc
    penalidade=1e10;
end

ppterca= ppU; %(N/m)
peso_terca_sec=ppterca/9.81*espacamento_entre_porticos*(n_tercas+1); %a terça de cumeeira tem dois perfis %kg/m
preco_unitario=3.55;
preco_terca_sec=preco_unitario*peso_terca_sec;
end