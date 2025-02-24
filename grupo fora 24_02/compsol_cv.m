%%MATRIZ COM AS COMPARAÇÕES ELU%%

function comparacao_cv = compsol_cv (n_el_cv,NtRde_cv_banzo,NtRdr_cv_banzo,NcRd_esc_u,NcRd_cv_banzo,fn_cv_u,fn_cv_banzo)

comparacao_cv= zeros(n_el_cv,2); %primeira coluna as escoras perfil u segunda coluna os banzos cantoneira dupla
for el=1:n_el_cv

    if NtRde_cv_banzo(el)< NtRdr_cv_banzo(el)
       NtRd(el)= NtRde_cv_banzo(el);
    else NtRd(el)= NtRdr_cv_banzo(el);
    end
    
    if fn_cv_u(el)<0
        comparacao_cv(el,1)= fn_cv_u(el)/NcRd_esc_u; %COMPRESSAO DO PERFIL U
    end
    
    if fn_cv_banzo(el)>0
        comparacao_cv(el,2)= fn_cv_banzo(el)/NtRd(el); %COMPARAÇÃO DE TRAÇÃO
    elseif fn_cv_banzo(el)<0
        comparacao_cv(el,2)= fn_cv_banzo(el)/NcRd_cv_banzo;    
    end
end

end