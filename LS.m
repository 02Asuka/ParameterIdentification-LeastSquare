%最小二乘参数辨识LS
clear all;
clc

a=[1 -1.2 0.8]'; b=[1 0.6]'; %参数
d=3; 
na=length(a)-1; nb=length(b)-1; %na、nb分别为A、B阶次

L=100; %数据长度
uk=zeros(d+nb,1); %输入初值
yk=zeros(na,1); %输出初值
x1=1; x2=1; x3=1; x4=0; %移位寄存器初值
S=1; %方波初值
xi=sqrt(1)*randn(L,1); %白噪声序列

theta=[a(2:na+1);b]; %对象参数真值
for k=1:L
    phi(k,:)=[-yk;uk(d:d+nb)]';
    y(k)=phi(k,:)*theta+xi(k); %采集输出数据
    
    M=xor(x3,x4); %产生M序列
    IM=xor(M,S);  %产生逆M序列
    if IM==0
        u(k)=-1;
    else
        u(k)=1;
    end
    S=not(S); %产生方波
    
    %更新数据
    x4=x3; x3=x2; x2=x1; x1=M; 
    
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=na:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
end
thetae=inv(phi'*phi)*phi'*y' ;%计算参数估计值
disp('参数估计值:');
disp(thetae);