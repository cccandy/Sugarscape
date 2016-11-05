
ne=100; %总回合数

mapsize=50;%地图规模
mapval=2; %资源参数

pe_num=250;%初始人数
pe_selfppt=5;%个人属性
pe_max= 500; %预计最大人口规模

infkind=2;%情报类型
relas=1;%关系种类



%初始化数据
%初始化自然地图库-3d
mapkey=zeros(mapsize,mapsize,mapval);
%初始化个人属性-2d
gene=zeros(pe_max,pe_selfppt);
%开启个人情报地图-4d
selfinf=zeros(mapsize,mapsize,infkind,pe_max);
%人物情感-3d boolean
%横列为人物id，纵列为对某人物的关系，z列为关系种类
emotion=zeros(pe_max,pe_max,relas);



%定义个人属性-2d --gene
%1,2地理位置R/C 3,视野 4，财富 5，存在
gene(1:pe_num,1:2)=round(1+rand(pe_num,2)*49);
gene(1:pe_num,3)=round(1+rand*3);
gene(1:pe_num,4)=20;
gene(1:pe_num,5)=1;
% 开启资源地图
mapkey(30:45,5:20,2)=50;
mapkey(35:40,10:15,2)=100;
mapkey(:,:,2)=mapkey(:,:,2)+mapkey(:,:,2)';
% 初始化位置

%设置日志文件
%地图日志 -4d
log_mapkey=zeros(mapsize,mapsize,mapval,ne);
%个人属性日志-3d
log_gene=zeros(pe_max,pe_selfppt,ne);
%个人情报日志-5d
%性能不足建议关闭
%log_selfinf=zeros(mapsize,mapsize,infkind,pe_max,ne);
%人物情感日志-4d 
log_emotion=zeros(pe_max,pe_max,relas,ne);

%第一回合记录
log_mapkey(:,:,:,1)=mapkey;
log_gene(:,:,1)=gene;
log_selfinf(:,:,:,:,1)=selfinf;
log_emotion(:,:,:,1)=emotion;

%开始模块
for nn=2:ne
for i=1:250
    %校验人物是否死亡
    if gene(i,5)==0
        continue
    end
    
selfinf(:,:,2,i)=inf_view(gene(i,3),gene(i,1),gene(i,2),mapkey(:,:,2),selfinf(:,:,2,i));
%更新selfinf 数据
[lastgoalR,lastgoalC,xt] = searchmap( selfinf(:,:,2,i),gene(i,1),gene(i,2));
%lastgoal-set
moving = T_move(i,nn,gene(i,1),gene(i,2),lastgoalR,lastgoalC);
%移动方式
gene(i,1:2)=moving;
end
   %回合末尾统一结算
[mapkey,gene]=round_ac(mapkey,gene,mapsize);

%日志系统
log_mapkey(:,:,:,nn)=mapkey;
log_gene(:,:,nn)=gene;
%log_selfinf(:,:,:,:,nn)=selfinf;
log_emotion(:,:,:,nn)=emotion;
%回合增益
mapkey(30:45,5:20,2)=mapkey(30:45,5:20,2)+1;
mapkey(35:40,10:15,2)=mapkey(35:40,10:15,2)+2;
end
%清理无关变量




