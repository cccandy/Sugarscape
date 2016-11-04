function [mapkey,gene]=round_ac(mapkey,gene,mapsize)
a=0;
for ri=1:mapsize
    for ci=1:mapsize
       rowt1=find (gene(:,1)==ri & gene(:,2)==ci);
       peop_T=length(rowt1);
       mapkey(ri,ci,1)=peop_T;
       sugar=mapkey(ri,ci,2);
       a=a+peop_T;
       if sugar>=peop_T
           gene(rowt1,4)= gene(rowt1,4)+1;
           mapkey(ri,ci,2)=mapkey(ri,ci,2)-peop_T;
       else
           gene(rowt1,4)=gene(rowt1,4)+sugar/peop_T;
           mapkey(ri,ci,2)=0;
       end
       
    end
end
gene(:,4)=gene(:,4)-gene(:,5)*0.5;
dea_t=find(gene(:,4)<0);
gene(dea_t,5)=0;
gene(dea_t,1:2)=0;
%确认是否存活
end