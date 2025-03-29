function desenho(x,y,n_el,conec)

G=zeros(n_el,4);
for el=1:n_el
    G(el,1)=x(conec(el,3));
    G(el,2)=y(conec(el,3));
    G(el,3)=x(conec(el,4));
    G(el,4)=y(conec(el,4));
end
xgraf=[G(:,1) G(:,3)];
ygraf=[G(:,2) G(:,4)];

figure
plot(xgraf',ygraf');


end
