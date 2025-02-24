%%MATRIZ COM AS COMPARAÇÕES ELU%%

function comparacao = compsol_restv2 (n_el,conec,NtRde,NtRdr,NcRds,NcRdd,fn_HIP_1,fn_HIP_2,fn_HIP_3,fn_HIP_4)

comparacao= zeros(n_el,4); 
for el=1:n_el
 
    if NtRde(el)<NtRdr(el)
       NtRd(el)= NtRde(el);
    else NtRd(el)= NtRdr(el);
    end
    if fn_HIP_1(el)>0
        comparacao(el,1)= fn_HIP_1(el)/NtRd(el); %CAMPARAÇÃO DE TRAÇÃO
    else
        if conec(el,5)== 1
         comparacao(el,1)= fn_HIP_1(el)/NcRds(el); %CAMPARAÇÃO DE COMPRESSÃO CANT SIMPLES
        end
        if conec(el,5)== 2
         comparacao(el,1)= fn_HIP_1(el)/NcRdd(el); %CAMPARAÇÃO DE COMPRESSÃO CANT DUPLA
        end
    end
    if fn_HIP_2(el)>0
        comparacao(el,2)= fn_HIP_2(el)/NtRd(el); %CAMPARAÇÃO DE TRAÇÃO
    else
        if conec(el,5)== 1
         comparacao(el,2)= fn_HIP_2(el)/NcRds(el); %CAMPARAÇÃO DE COMPRESSÃO CANT SIMPLES
        end
        if conec(el,5)== 2
         comparacao(el,2)= fn_HIP_2(el)/NcRdd(el); %CAMPARAÇÃO DE COMPRESSÃO CANT DUPLA
        end
    end
    if fn_HIP_3(el)>0
        comparacao(el,3)=fn_HIP_3(el)/ NtRd(el); %CAMPARAÇÃO DE TRAÇÃO
    else
        if conec(el,5)== 1
         comparacao(el,3)= fn_HIP_3(el)/NcRds(el); %CAMPARAÇÃO DE COMPRESSÃO CANT SIMPLES
        end
        if conec(el,5)== 2
         comparacao(el,3)= fn_HIP_3(el)/NcRdd(el); %CAMPARAÇÃO DE COMPRESSÃO CANT DUPLA
        end
    end
    if fn_HIP_4(el)>0
        comparacao(el,4)= fn_HIP_4(el)/NtRd(el); %CAMPARAÇÃO DE TRAÇÃO
    else
        if conec(el,5)== 1
         comparacao(el,4)= fn_HIP_4(el)/NcRds(el); %CAMPARAÇÃO DE COMPRESSÃO CANT SIMPLES
        end
        if conec(el,5)== 2
         comparacao(el,4)= fn_HIP_4(el)/NcRdd(el); %CAMPARAÇÃO DE COMPRESSÃO CANT DUPLA
        end
    end
end

end