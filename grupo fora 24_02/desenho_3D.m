function desenho_3D(coord,n_el,conec)
 

   G=zeros(n_el,4);
   for el=1:n_el
       G(el,1)=coord(conec(el,2),2);
       G(el,2)=coord(conec(el,2),3);
       G(el,3)=coord(conec(el,2),4);
       G(el,4)=coord(conec(el,3),2);
       G(el,5)=coord(conec(el,3),3);
       G(el,6)=coord(conec(el,3),4);

   end
   xgraf=[G(:,1) G(:,4)];
   ygraf=[G(:,2) G(:,5)];
   zgraf=[G(:,3) G(:,6)];

%    es=zeros(length(u),1);
%    for n=1:length(u)
%        u(n)=u(n)*1.7;
%        es(n)=roundn(((u(n)/40)*5),0);
%        if es(n)<=0
%            es(n)=2;
%        end
%    end
 %figure1 = figure('Color',[1 1 1])
 figure
  plot1 = plot3(zgraf',xgraf',ygraf');
  axis equal

  for n=1:n_el    
  set(plot1(n),'linewidth',1,'Color',[0 0 0]);
  end
 
end