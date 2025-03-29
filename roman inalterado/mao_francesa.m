function [pp_mao_francesa,preco_mao_francesa,penalidade,peso_mao_francesa_sec,comprimento_mao_francesa]=mao_francesa(n_contraventamentos,esp_entre_banzos,perfil_mao_francesa)
%VERIFICAÇÃO DA FLAMBAGEM DA MÃO FRANCESA
%CONTRAVENTAMENTO DO BANZO INFERIOR DA TRELIÇA

A =[0.000148
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
    0.002329];

assignin('base','area_mao_francesa',A(perfil_mao_francesa));

rmin = [0.0048
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
    0.02510];%m

incl=45; %inclinação da mão francesa
comprimento_mao_francesa=esp_entre_banzos/cos(incl*pi/180);

penalidade=0;
coef_flambagem=comprimento_mao_francesa/rmin(perfil_mao_francesa);
if coef_flambagem>200
    penalidade=1e10;
end
pp_mao_francesa=77000*A(perfil_mao_francesa)*comprimento_mao_francesa/2;
peso_mao_francesa_sec=pp_mao_francesa/9.81*n_contraventamentos*4;

preco_unitario=3.20;
preco_mao_francesa=preco_unitario*peso_mao_francesa_sec;
end

