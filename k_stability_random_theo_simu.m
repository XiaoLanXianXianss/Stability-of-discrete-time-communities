% This file generates the theoretical and simulated stability changes of the 
% random community matriices as k varies

% This file can be used to generate Fig. 5b

d=1;
sigma=0.05;
S=100;  
C=0.2;
n=50;

val_kesti=0.1:0.1:3.1; 
val_ksimu=0.2:0.4:3;

%theo 
i=1;
for k=val_kesti
    x_lm=-(d-1)-sigma*sqrt(S*C); %最左边特征值的实部
    y_lm=0;   %最左边特征值的虚部
    x_rm=-(d-1)+sigma*sqrt(S*C); %最右边特征值的实部
    y_rm=0; %最右边特征值的虚部
    x_um=-(d-1); %最上边特征值的实部
    y_um=sigma*sqrt(S*C); %最上边特征值的虚部

    abs_lm=sqrt(x_lm^2+y_lm^2);%最左边特征值对应的绝对值
    abs_rm=sqrt(x_rm^2+y_rm^2);%最右边特征值对应的绝对值
    abs_um=sqrt(x_um^2+y_um^2);%最上边特征值对应的绝对值
    J_abs=[abs_lm,abs_rm,abs_um]; %为了用max 构造矩阵 详情见max用法 
    alpha_r(1,i)=-log(max(J_abs));
    i=i+1;
end

h_r=plot(val_kesti,alpha_r,'linestyle','-',"Color",'[0 0.4470 0.7410]','LineWidth',1)
hold on 

%simu
m=1;
for k=val_ksimu
a=k;
b=sigma*sqrt(1/(k^2+k));
J=zeros(1,n);
for t=1:n
    M=zeros(S);
for i=1:S
    for j=1:S
        if i==j
            M(i,j)=-(d-1);
        else 
             p1=rand;
            if p1<=C
                p2=rand;
                if p2<0.5
                    M(i,j)=gamrnd(a,b);
                else
                    M(i,j)=-gamrnd(a,b);
                end
           end
        end
    end
end
J(1,t)=-log(max(abs(eig(M))));
end
J_mean(1,m)=mean(J); %random占J_mean的第一行
m=m+1;
end
%
h_rr=plot(val_ksimu,J_mean(1,:),'d','Markersize',4,'MarkerEdgeColor',[0 0.4470 0.7410],'MarkerFaceColor',[0 0.4470 0.7410])


