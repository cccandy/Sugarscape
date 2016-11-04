function moving = T_move(i,nn,MyAreaR,MyAreaC,lastgoalR,lastgoalC)
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
    if MyAreaR<=0
        MyAreaR=MyAreaR+2;
    end
     if MyAreaC<=0
        MyAreaC=MyAreaC+2;
     end
        if MyAreaR>=50
        MyAreaR=MyAreaR-2;
    end
     if MyAreaC>=50
        MyAreaC=MyAreaC-2;
    end
end

moving=[MyAreaR,MyAreaC];
end