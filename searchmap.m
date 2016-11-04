function  [lastgoalR,lastgoalC,xt] = searchmap(Viewermap,ArR,ArC)
[rowV,colV] = find( Viewermap == max(max(Viewermap)));
%make viewer map
xt=abs(rowV-ArR)+abs(colV-ArC);
mark_best=find(xt==min(xt));
if length(mark_best)==1
    goal=mark_best(1);
    lastgoalR=rowV(goal);
    lastgoalC=colV(goal);
elseif ~length(mark_best)
    lastgoalR=rowV;
    lastgoalC=colV;
else 
    markt=ceil((length(mark_best))*rand);
    goal=mark_best(markt);
    lastgoalR=rowV(goal);
    lastgoalC=colV(goal);
end
end