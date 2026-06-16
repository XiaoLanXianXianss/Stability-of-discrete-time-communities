% This file generates the influence of different variables of the cascade 
% food web and the niche food web on stability

%This file can be used to generate Fig. 6c and Fig. 6d

clear all
clc


%% 参数 （随机，+/-，+/+，-/-）
sigma=0.05;
S=200;  
C=0.1;
d=1;
n=100;
figure;
set(gcf, 'unit', 'centimeters', 'position', [10 5 20 6]); %设置 Figure 在整个电脑屏幕中的位置及大小
%% 级联食物网
J_cas=[];
for t=1:n
    M=zeros(S);
for i=1:S
    for j=1:S
        if i==j
            M(i,j)=1-d;
        elseif i<j
                p1=rand;
            if p1<=C
                    M(i,j)=-abs(normrnd(0,sigma,1,1));
                    M(j,i)=abs(normrnd(0,sigma,1,1));                
             end
        end
    end
end
J_cas(1,t)=-log(max(abs(eig(M))));
end
J_casmean=mean(J_cas);

%% 区间性级联食物网

subplot(1,4,1)
set(gca,'unit', 'centimeters', 'position', [1.5, 1, 3.5, 3]); %设置 Axis(坐标轴）在Figture中的左边界、下边界、宽度、高度
set(gca,'FontSize',8)

%先画出级联的红线
sample=1:n;
h_cas=plot(sample,J_casmean*ones(1,n),'-','Color',[0.8500 0.3250 0.0980],'LineWidth',1)
axis ([-5,105,-0.2,2.3]);
hold on

% 区间性级联食物网
J_case1=[];
for t=1:n
    L=[];
for i=1:S
    L(1,i)=fix(C*(i-1));%fix取整
end

    s=[];
for i=1:S
    s(1,i)=unidrnd(i-L(1,i));
end

    K=[];
for i=1:S
    for j=1:S
        if (j>=s(1,i) && j<=s(1,i)+L(1,i)-1)
            K(i,j)=1;%i捕食j
        else K(i,j)=0;
        end
    end
end

M=zeros(S);
for i=1:S
    for j=1:S
        if (K(i,j)==1 && K(j,i)==0)
                M(i,j)=abs(normrnd(0,sigma,1,1));
                M(j,i)=-abs(normrnd(0,sigma,1,1));
        end
    end
end
M(logical(eye(size(M))))=(1-d)*ones(S,1);
J_case1(1,t)=-log(max(abs(eig(M))));
end
sample=1:n;

h_interval=plot(sample,J_case1,'^','MarkerEdgeColor',[0 0.4470 0.7410],'MarkerFaceColor','none','Markersize',3)

J_1mean=mean(J_case1);    


legend([h_cas,h_interval],{'Cascade','Cascade+interval'},'FontSize',8);
legend boxoff;

%title('Cascade(interval)','FontSize',10);
ylabel('Stability','Fontsize',9);
title('Variant 1','FontSize',10)
%% 度分布 级联捕食-被捕食

subplot(1,4,2)
set(gca,'unit', 'centimeters', 'position', [6, 1, 3.5, 3]); %设置 Axis(坐标轴）在Figture中的左边界、下边界、宽度、高度
set(gca,'FontSize',8)


    
%先画出级联的红线
sample=1:n;
plot(sample,J_casmean*ones(1,n),'-','Color',[0.8500 0.3250 0.0980],'LineWidth',1)
axis ([-5,105,-0.2,2.3]);
hold on

J_case2=[];
for t=1:n
    
%给定每个物种的生态位 eta
eta=[];
for i=1:S
    eta(1,i)=unifrnd(0,1);
end
%给eta从小到大排序
eta=sort(eta);

%给每个物种的生态位半径 r
beta=[];
r=[];
for i=1:S
    beta(1,i)=betarnd(1,1/C-1);
    r(1,i)=eta(1,i)*beta(1,i);
end

%确定每个物种的猎物数量 L
L=[];
for i=1:S
    L(1,i)=binornd(i-1,r(1,i));
end

%确定每个物种的有效连接度 C_eff
C_eff=[];
C_eff(1,1)=0;
for i=2:S
    C_eff(1,i)=L(1,i)/(i-1);
end

%生成连接矩阵K
K=[];
for i=1:S
    for j=1:S
        if i<j
            p1=rand;
            if p1<C_eff(1,j)
                K(i,j)=1;%j捕食i
                K(j,i)=0;
            else K(i,j)=0;
                K(j,i)=0;
            end
        end
    end
end

%确定群落矩阵
M=zeros(S);
for i=1:S
    for j=1:S
        if (i<j && K(i,j)==1 && K(j,i)==0)
             M(i,j)=-abs(normrnd(0,sigma,1,1));
             M(j,i)=abs(normrnd(0,sigma,1,1)); 
        end
    end
end
M(logical(eye(size(M))))=(1-d)*ones(S,1);
J_case2(1,t)=-log(max(abs(eig(M))));
end
sample=1:n;
h_degree=plot(sample,J_case2,'o','MarkerEdgeColor',[0 0.4470 0.7410],'MarkerFaceColor','none','Markersize',3)


J_2mean=mean(J_case2);    

xlabel('Sample number','Fontsize',9);
legend([h_degree],{'Cascade+broad degree dist.'},'FontSize',8);
legend boxoff;

%title('Cascade(broad deg dist)','FontSize',10);
title('Variant 2','FontSize',10)
%% 区间性+度分布 级联捕食-被捕食

subplot(1,4,3)
set(gca,'unit', 'centimeters', 'position', [10.5, 1, 3.5, 3]); %设置 Axis(坐标轴）在Figture中的左边界、下边界、宽度、高度
set(gca,'FontSize',8)

%先画出级联的红线
sample=1:n;
plot(sample,J_casmean*ones(1,n),'-','Color',[0.8500 0.3250 0.0980],'LineWidth',1)
axis ([-5,105,-0.2,2.3]);
hold on

J_case3=[];
for t=1:n

%给定每个物种的生态位 eta
eta=[];
for i=1:S
    eta(1,i)=unifrnd(0,1);
end
%给eta从小到大排序
eta=sort(eta);

%给每个物种的生态位半径 r
beta=[];
r=[];
for i=1:S
    beta(1,i)=betarnd(1,1/C-1);
    r(1,i)=eta(1,i)*beta(1,i);
end

%确定每个物种的猎物数量 L
L=[];
for i=1:S
    L(1,i)=binornd(i-1,r(1,i));
end

%确定每个物种的猎物的起始点
s=[];
for i=1:S
    s(1,i)=unidrnd(i-L(1,i));
end

%确定连接矩阵K
K=[];
for i=1:S
    for j=1:S
        if (j>=s(1,i) && j<=s(1,i)+L(1,i)-1)
            K(i,j)=1;%i捕食j
        else K(i,j)=0;
        end
    end
end

%确定群落矩阵M
M=zeros(S);
for i=1:S
    for j=1:S
        if (K(i,j)==1 && K(j,i)==0)
                            M(i,j)=abs(normrnd(0,sigma,1,1));
                M(j,i)=-abs(normrnd(0,sigma,1,1));
                end
    end
end
%M的对角线元素取1-d
M(logical(eye(size(M))))=(1-d)*ones(S,1);
J_case3(1,t)=-log(max(abs(eig(M))));
end

sample=1:n;
h_3=plot(sample,J_case3,'d','MarkerEdgeColor',[0 0.4470 0.7410],'MarkerFaceColor','none','Markersize',3)


J_3mean=mean(J_case3);    

legend([h_3],{'Cascade+interval+broad degree dist.)'},'FontSize',8);
legend boxoff;

%title('Cascade(interval,broad deg dist)','FontSize',10)
title('Variant 3','FontSize',10)
%% 
subplot(1,4,4)
set(gca,'unit', 'centimeters', 'position', [15.5, 1, 3.5, 3]);


barh([abs(J_1mean-J_casmean),abs(J_2mean-J_casmean),abs(J_3mean-J_casmean)],0.5,'FaceColor',[0 0.4470 0.7410])
alpha(0.85);

axis([0 0.25 0.3 3.7]);
set(gca, 'xticklabel',{'0','-0.1','-0.2'});

ylabel('Variant number','FontSize',9); 

xlabel('$$\Delta$$','Interpreter','latex','fontsize',9);

box on