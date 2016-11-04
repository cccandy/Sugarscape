function Viewermap=inf_view(viewer,MyAreaR,MyAreaC,mapsugar,Viewermap)
inRlow=((MyAreaR-viewer)<=0)*1+((MyAreaR-viewer)>0)*(MyAreaR-viewer);
inRhigh=((MyAreaR+viewer)>=50)*50+((MyAreaR+viewer)<50)*(MyAreaR+viewer);
inClow=((MyAreaC-viewer)<=0)*1+((MyAreaC-viewer)>0)*(MyAreaC-viewer);
inChigh=((MyAreaC+viewer)>=50)*50+((MyAreaC+viewer)<50)*(MyAreaC+viewer);
%use w=(a>=b)*c+(a<b)*d to  Substitute "if"
%make gene to vit
Viewermap((inRlow):(inRhigh),(inClow):(inChigh)) =mapsugar((inRlow):(inRhigh),(inClow):(inChigh));
end