
ne=100; %�ܻغ���

mapsize=50;%��ͼ��ģ
mapval=2; %��Դ����

pe_num=250;%��ʼ����
pe_selfppt=5;%��������
pe_max= 500; %Ԥ������˿ڹ�ģ

infkind=2;%�鱨����
relas=1;%��ϵ����



%��ʼ������
%��ʼ����Ȼ��ͼ��-3d
mapkey=zeros(mapsize,mapsize,mapval);
%��ʼ����������-2d
gene=zeros(pe_max,pe_selfppt);
%���������鱨��ͼ-4d
selfinf=zeros(mapsize,mapsize,infkind,pe_max);
%�������-3d boolean
%����Ϊ����id������Ϊ��ĳ����Ĺ�ϵ��z��Ϊ��ϵ����
emotion=zeros(pe_max,pe_max,relas);



%�����������-2d --gene
%1,2����λ��R/C 3,��Ұ 4���Ƹ� 5������
gene(1:pe_num,1:2)=round(1+rand(pe_num,2)*49);
gene(1:pe_num,3)=round(1+rand*3);
gene(1:pe_num,4)=20;
gene(1:pe_num,5)=1;
% ������Դ��ͼ
mapkey(30:45,5:20,2)=50;
mapkey(35:40,10:15,2)=100;
mapkey(:,:,2)=mapkey(:,:,2)+mapkey(:,:,2)';
% ��ʼ��λ��

%������־�ļ�
%��ͼ��־ -4d
log_mapkey=zeros(mapsize,mapsize,mapval,ne);
%����������־-3d
log_gene=zeros(pe_max,pe_selfppt,ne);
%�����鱨��־-5d
%���ܲ��㽨��ر�
log_selfinf=zeros(mapsize,mapsize,infkind,pe_max,ne);
%���������־-4d 
log_emotion=zeros(pe_max,pe_max,relas,ne);

%��һ�غϼ�¼
log_mapkey(:,:,:,1)=mapkey;
log_gene(:,:,1)=gene;
log_selfinf(:,:,:,:,1)=selfinf;
log_emotion(:,:,:,1)=emotion;

%��ʼģ��
for nn=2:ne
for i=1:250
    %У�������Ƿ�����
    if gene(i,5)==0
        continue
    end
    
selfinf(:,:,2,i)=inf_view(gene(i,3),gene(i,1),gene(i,2),mapkey(:,:,2),selfinf(:,:,2,i));
%����selfinf ����
[lastgoalR,lastgoalC,xt] = searchmap( selfinf(:,:,2,i),gene(i,1),gene(i,2));
%lastgoal-set
moving = T_move(i,nn,gene(i,1),gene(i,2),lastgoalR,lastgoalC);
%�ƶ���ʽ
gene(i,1:2)=moving;
end
   %�غ�ĩβͳһ����
[mapkey,gene]=round_ac(mapkey,gene,mapsize);

%��־ϵͳ
log_mapkey(:,:,:,nn)=mapkey;
log_gene(:,:,nn)=gene;
log_selfinf(:,:,:,:,nn)=selfinf;
log_emotion(:,:,:,nn)=emotion;
%�غ�����
mapkey(30:45,5:20,2)=mapkey(30:45,5:20,2)+1;
mapkey(35:40,10:15,2)=mapkey(35:40,10:15,2)+2;
end
%�����޹ر���




