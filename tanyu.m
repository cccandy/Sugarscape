ne=1000;
mapkey=zeros(50,50);
mapT1=zeros(50,50);
%Map initialization
gene=round(1+rand(250,3)*3);
gene(:,2)=20;
gene(:,3)=1;
%1,视野 2，财富 3，存在
mapT1(30:45,5:20)=50;
mapT1(35:40,10:15)=100;
mapT1=mapT1+mapT1';
% 开启资源地图
AreaT=round(1+rand(250,2)*49);
% make area
log_area=zeros(250,ne*2);
log_area(:,1:2)=AreaT;
log_money=zeros(250,ne);
log_money(:,1)=gene(:,2);
%make log
%begin
for nn=2:ne
for i=1:250
    if gene(i,3)==0
        continue
    end
viewer=gene(i,1);
MyAreaR=AreaT(i,1);
MyAreaC=AreaT(i,2);
inRlow=((MyAreaR-viewer)<=0)*1+((MyAreaR-viewer)>0)*(MyAreaR-viewer);
inRhigh=((MyAreaR+viewer)>=50)*50+((MyAreaR+viewer)<50)*(MyAreaR+viewer);
inClow=((MyAreaC-viewer)<=0)*1+((MyAreaC-viewer)>0)*(MyAreaC-viewer);
inChigh=((MyAreaC+viewer)>=50)*50+((MyAreaC+viewer)<50)*(MyAreaC+viewer);

%use w=(a>=b)*c+(a<b)*d to  Substitute "if"
%make gene to vit
Viewermap =mapT1((inRlow):(inRhigh),(inClow):(inChigh));
%clearhere inRlow inRhigh inClow inChigh
[rowV,colV] = find(Viewermap==max(max(Viewermap)));
%make viewer map
xt=abs(rowV-(viewer+1))+abs(colV-(viewer+1));
mark_best=find(xt==min(xt));
if length(mark_best)==1
    goal=mark_best(1);
    lastgoalR=rowV(goal)+MyAreaR-(viewer+1);
    lastgoalC=colV(goal)+MyAreaC-(viewer+1) ;
elseif ~length(mark_best)
    lastgoalR=MyAreaR;
    lastgoalC=MyAreaC;
else 
    markt=ceil((length(mark_best))*rand);
    goal=mark_best(markt);
    lastgoalR=rowV(goal)+MyAreaR-(viewer+1);
    lastgoalC=colV(goal)+MyAreaC-(viewer+1) ;
end
%lastgoal-set
%clearhere colV rowV mark_best markt Viewermap xt

f_mod=mod((i+nn),2);
inmoveR=lastgoalR-MyAreaR;
inmoveC=lastgoalC-MyAreaC;
if inmoveC>=0 && inmoveR>0
   if inmoveC==0
       MyAreaR=MyAreaR+1;
   else
            if f_mod
                    MyAreaR=MyAreaR+1;
            else 
                    MyAreaC=MyAreaC+1;
             end
   end
elseif  inmoveC<0 && inmoveR>=0 
    if inmoveR==0
       MyAreaC=MyAreaC-1;
   else
            if f_mod
                    MyAreaR=MyAreaR+1;
            else 
                    MyAreaC=MyAreaC-1;
             end
   end
elseif inmoveC<=0 && inmoveR<0 
     if inmoveC==0
       MyAreaR=MyAreaR-1;
     else
                if f_mod
                    MyAreaR=MyAreaR-1;
            else 
                    MyAreaC=MyAreaC-1;
                end
      end
elseif inmoveC>0 && inmoveR<=0 
   if inmoveR==0
       MyAreaC=MyAreaC+1;
   else
            if f_mod
                    MyAreaR=MyAreaR-1;
            else 
                    MyAreaC=MyAreaC+1;
             end
   end
else 
    rway=ceil(rand*4);
    if rway==1
        MyAreaR=MyAreaR+1;
    elseif rway==2
        MyAreaR=MyAreaR-1;
    elseif rway==3
        MyAreaC=MyAreaC-1;
     elseif rway==4
        MyAreaC=MyAreaC+1;
    end
end
AreaT(i,1:2)=[MyAreaR,MyAreaC];
%clearhere goal inmoveC inmoveR  
end
   %回合末尾统一结算
   %clearhere  lastgoalC lastgoalR MyAreaC MyAreaR 
for ri=1:50
    for ci=1:50
       rowt1=find (AreaT(:,1)==ri & AreaT(:,2)==ci);
       peop_T=length(rowt1);
       mapkey(ri,ci)=peop_T;
       sugar=mapT1(ri,ci);
       if sugar>=peop_T
           gene(rowt1,2)= gene(rowt1,2)+1;
           mapT1(ri,ci)=mapT1(ri,ci)-peop_T;
       else
           gene(rowt1,2)=gene(rowt1,2)+sugar/peop_T;
           mapT1(ri,ci)=0;
       end
       
    end
end
gene(:,2)=gene(:,2)-0.5;
dea_t=find(gene(:,2)<0);
gene(dea_t,3)=0;
clear dea_t
%live or death
log_area(:,(nn*2-1):nn*2)=AreaT;
%log_area
log_money(:,nn)=gene(:,2);
mapT1(30:45,5:20)=mapT1(30:45,5:20)+1;
mapT1(35:40,10:15)=mapT1(35:40,10:15)+2;
end
%清理无关变量
clear inRlow inRhigh inClow inChigh
clear colV rowV mark_best markt Viewermap xt
clear goal inmoveC inmoveR rway
clear  lastgoalC lastgoalR MyAreaC MyAreaR peop_T sugar peop_T rowt1 f_mod nn



