
% This file generates the eigenvalue distributions of community matrices 
% with different types of interactions 

% This file can be used to generate Fig. 5c

clear all
clc

%
figure
set(gcf, 'unit', 'centimeters', 'position', [10 5 20 12]); %设置 Figure 在整个电脑屏幕中的位置及大小

d=1;
sigma=0.05;
S=100;  
C=0.2;
n=50;
val_kesti=0.1:0.1:3.2; 
val_ksimu=0.1:0.4:2.9;
%% 随机的特征值分布

subplot(2,4,1)
set(gca,'unit', 'centimeters', 'position', [1.5,6.5,3.5,3.5]); %左竖直轴距离窗口左边界 下水平轴距离窗口下边界
set(gca,'FontSize',8);

%画不稳定的区域
point1=[-1.1 1.1 1.1 -1.1];
point2=[-1.1 -1.1 1.1 1.1];
Color=[0.75 0.75 0.75];
a=patch(point1,point2,Color) ;
alpha(0.6);
set(a,'edgecolor','none');
hold on ;

axis equal;

%画圆内表示稳定性的渐变图
r=(0:0.01:1)';
theta=pi*(-1:0.01:1);
x_circle=r*cos(theta);
y_circle=r*sin(theta);

circle=x_circle.^2+y_circle.^2;
p_circle=pcolor(x_circle,y_circle,4.5*(1-circle));


% 自定义 colormap 
start_color = [253,174,107]/255; % 开始颜色
end_color = [255,245,235]/255;    % 结束颜色
n_colors = 256;                      % 颜色数量
custom_colormap = [linspace(start_color(1), end_color(1), n_colors)', ... % 红色分量
                   linspace(start_color(2), end_color(2), n_colors)', ... % 绿色分量
                   linspace(start_color(3), end_color(3), n_colors)'];    % 蓝色分量

%应用自定义 colormap
colormap(custom_colormap);


set(p_circle,'LineStyle','none');%去除网格线
%colorbar 
axis ([-1.1,1.1,-1.1,1.1]);
box on;
title('Random','FontSize',10)

k=3;
a=k;
b=sigma*sqrt(1/(k^2+k));

n=5;
J=cell(n,1);
for t=1:n;
    M=[];
for i=1:S;
    for j=1:S;
        if i==j;
            M(i,j)=1-d;
        else 
             p1=rand;
            if p1<=C;
                p2=rand;
                if p2<0.5;
                    M(i,j)=gamrnd(a,b);
                else
                    M(i,j)=-gamrnd(a,b);
                end
            else
                    M(i,j)=0;
            end
        end
    end
end
J{t,1}=M;
end
hold on 

ylabel('Imaginary','FontSize',9);  


J11=cell2mat(J(1,1));
J11_lam=eig(J11);
h11=plot(real(J11_lam),imag(J11_lam),'.',"MarkerEdgeColor",[166,189,219]/255)%[0.8500 0.3250 0.0980])

J21=cell2mat(J(2,1));
J21_lam=eig(J21);
h21=plot(real(J21_lam),imag(J21_lam),'.',"MarkerEdgeColor",[116,169,207]/255)%[0.9290 0.6940 0.1250])

J31=cell2mat(J(3,1));
J31_lam=eig(J31);
h31=plot(real(J31_lam),imag(J31_lam),'.',"MarkerEdgeColor",[54,144,192]/255)%[0.4940 0.1840 0.5560])

J41=cell2mat(J(4,1));
J41_lam=eig(J41);
h41=plot(real(J41_lam),imag(J41_lam),'.',"MarkerEdgeColor",[5,112,176]/255)%[1 0.5 0])

J51=cell2mat(J(5,1));
J51_lam=eig(J51);
h51=plot(real(J51_lam),imag(J51_lam),'.',"MarkerEdgeColor",[4,90,141]/255)%[0.6350 0.0780 0.1840])

ylabel('$$k=0.7$$','Interpreter','latex','fontsize',9);

%% 随机的特征值分布
subplot(2,4,5)
set(gca,'unit', 'centimeters', 'position', [1.5,1,3.5,3.5]);
set(gca,'FontSize',8);

%画不稳定的区域
point1=[-1.1 1.1 1.1 -1.1];
point2=[-1.1 -1.1 1.1 1.1];
Color=[0.75 0.75 0.75];
a=patch(point1,point2,Color) ;
alpha(0.6);
set(a,'edgecolor','none');
hold on ;


%画圆内表示稳定性的渐变图
r=(0:0.01:1)';
theta=pi*(-1:0.01:1);
x_circle=r*cos(theta);
y_circle=r*sin(theta);

circle=x_circle.^2+y_circle.^2;
p_circle=pcolor(x_circle,y_circle,4.5*(1-circle));


% 自定义 colormap 
start_color = [253,174,107]/255; % 开始颜色
end_color = [255,245,235]/255;    % 结束颜色
n_colors = 256;                      % 颜色数量
custom_colormap = [linspace(start_color(1), end_color(1), n_colors)', ... % 红色分量
                   linspace(start_color(2), end_color(2), n_colors)', ... % 绿色分量
                   linspace(start_color(3), end_color(3), n_colors)'];    % 蓝色分量

%应用自定义 colormap
colormap(custom_colormap);

set(p_circle,'LineStyle','none');%去除网格线
%colorbar 
axis ([-1.1,1.1,-1.1,1.1]);
box on;


k=3;
a=k;
b=sigma*sqrt(1/(k^2+k));

n=5;
J=cell(n,1);
for t=1:n;
    M=[];
for i=1:S;
    for j=1:S;
        if i==j;
            M(i,j)=1-d;
        else 
             p1=rand;
            if p1<=C;
                p2=rand;
                if p2<0.5;
                    M(i,j)=gamrnd(a,b);
                else
                    M(i,j)=-gamrnd(a,b);
                end
            else
                    M(i,j)=0;
            end
        end
    end
end
J{t,1}=M;
end
hold on 
xlabel('Real','FontSize',9);
%ylabel('Imaginary','FontSize',9);  


J11=cell2mat(J(1,1));
J11_lam=eig(J11);
h11=plot(real(J11_lam),imag(J11_lam),'.',"MarkerEdgeColor",[166,189,219]/255)%[0.8500 0.3250 0.0980])

J21=cell2mat(J(2,1));
J21_lam=eig(J21);
h21=plot(real(J21_lam),imag(J21_lam),'.',"MarkerEdgeColor",[116,169,207]/255)%[0.9290 0.6940 0.1250])

J31=cell2mat(J(3,1));
J31_lam=eig(J31);
h31=plot(real(J31_lam),imag(J31_lam),'.',"MarkerEdgeColor",[54,144,192]/255)%[0.4940 0.1840 0.5560])

J41=cell2mat(J(4,1));
J41_lam=eig(J41);
h41=plot(real(J41_lam),imag(J41_lam),'.',"MarkerEdgeColor",[5,112,176]/255)%[1 0.5 0])

J51=cell2mat(J(5,1));
J51_lam=eig(J51);
h51=plot(real(J51_lam),imag(J51_lam),'.',"MarkerEdgeColor",[4,90,141]/255)%[0.6350 0.0780 0.1840])

ylabel('$$k=3$$','Interpreter','latex','fontsize',9);

%% 捕食-被捕食 k=0.7
subplot(2,4,2)
set(gca,'unit', 'centimeters', 'position', [6, 6.5, 3.5, 3.5]);
set(gca,'FontSize',8);

%画不稳定的区域
point1=[-1.1 1.1 1.1 -1.1];
point2=[-1.1 -1.1 1.1 1.1];
Color=[0.75 0.75 0.75];
a=patch(point1,point2,Color) ;
alpha(0.6);
set(a,'edgecolor','none');
hold on ;


%画圆内表示稳定性的渐变图
r=(0:0.01:1)';
theta=pi*(-1:0.01:1);
x_circle=r*cos(theta);
y_circle=r*sin(theta);

circle=x_circle.^2+y_circle.^2;
p_circle=pcolor(x_circle,y_circle,4.5*(1-circle));


% 自定义 colormap 
start_color = [253,174,107]/255; % 开始颜色
end_color = [255,245,235]/255;    % 结束颜色
n_colors = 256;                      % 颜色数量
custom_colormap = [linspace(start_color(1), end_color(1), n_colors)', ... % 红色分量
                   linspace(start_color(2), end_color(2), n_colors)', ... % 绿色分量
                   linspace(start_color(3), end_color(3), n_colors)'];    % 蓝色分量

%应用自定义 colormap
colormap(custom_colormap);


set(p_circle,'LineStyle','none');%去除网格线
%colorbar 
axis ([-1.1,1.1,-1.1,1.1]);
box on;


k=0.7;
a=k;
b=sigma*sqrt(1/(k^2+k));

J=cell(n,1);
for t=1:n;
    M=[];
for i=1:S;
    for j=1:S;
        if i==j;
            M(i,j)=1-d;
        else if i<j;
                p1=rand;
            if p1<=C;
                p2=rand;
                if p2<=0.5;
                    M(i,j)=gamrnd(a,b);
                    M(j,i)=-gamrnd(a,b);
                else 
                    M(i,j)=-gamrnd(a,b);
                    M(j,i)=gamrnd(a,b);
                end
                else
                    M(j,i)=0;
                    M(i,j)=0;
            end
            end
        end
    end
end
J{t,1}=M;
end


J11=cell2mat(J(1,1));
J11_lam=eig(J11);
h11=plot(real(J11_lam),imag(J11_lam),'.',"MarkerEdgeColor",[166,189,219]/255)%[0.8500 0.3250 0.0980])

J21=cell2mat(J(2,1));
J21_lam=eig(J21);
h21=plot(real(J21_lam),imag(J21_lam),'.',"MarkerEdgeColor",[116,169,207]/255)%[0.9290 0.6940 0.1250])

J31=cell2mat(J(3,1));
J31_lam=eig(J31);
h31=plot(real(J31_lam),imag(J31_lam),'.',"MarkerEdgeColor",[54,144,192]/255)%[0.4940 0.1840 0.5560])

J41=cell2mat(J(4,1));
J41_lam=eig(J41);
h41=plot(real(J41_lam),imag(J41_lam),'.',"MarkerEdgeColor",[5,112,176]/255)%[1 0.5 0])

J51=cell2mat(J(5,1));
J51_lam=eig(J51);
h51=plot(real(J51_lam),imag(J51_lam),'.',"MarkerEdgeColor",[4,90,141]/255)%[0.6350 0.0780 0.1840])

title('Exploitative','FontSize',10);

%% 捕食-被捕食 k=3
subplot(2,4,6)
set(gca,'unit', 'centimeters', 'position', [6, 1, 3.5, 3.5]);
set(gca,'FontSize',8);

%画不稳定的区域
point1=[-1.1 1.1 1.1 -1.1];
point2=[-1.1 -1.1 1.1 1.1];
Color=[0.75 0.75 0.75];
a=patch(point1,point2,Color) ;
alpha(0.6);
set(a,'edgecolor','none');
hold on ;


%画圆内表示稳定性的渐变图
r=(0:0.01:1)';
theta=pi*(-1:0.01:1);
x_circle=r*cos(theta);
y_circle=r*sin(theta);

circle=x_circle.^2+y_circle.^2;
p_circle=pcolor(x_circle,y_circle,4.5*(1-circle));


% 自定义 colormap 
start_color = [253,174,107]/255; % 开始颜色
end_color = [255,245,235]/255;    % 结束颜色
n_colors = 256;                      % 颜色数量
custom_colormap = [linspace(start_color(1), end_color(1), n_colors)', ... % 红色分量
                   linspace(start_color(2), end_color(2), n_colors)', ... % 绿色分量
                   linspace(start_color(3), end_color(3), n_colors)'];    % 蓝色分量

%应用自定义 colormap
colormap(custom_colormap);


set(p_circle,'LineStyle','none');%去除网格线
%colorbar 
axis ([-1.1,1.1,-1.1,1.1]);
box on;

k=3;
a=k;
b=sigma*sqrt(1/(k^2+k));

J=cell(n,1);
for t=1:n;
    M=[];
for i=1:S;
    for j=1:S;
        if i==j;
            M(i,j)=1-d;
        else if i<j;
                p1=rand;
            if p1<=C;
                p2=rand;
                if p2<=0.5;
                    M(i,j)=gamrnd(a,b);
                    M(j,i)=-gamrnd(a,b);
                else 
                    M(i,j)=-gamrnd(a,b);
                    M(j,i)=gamrnd(a,b);
                end
                else
                    M(j,i)=0;
                    M(i,j)=0;
            end
            end
        end
    end
end
J{t,1}=M;
end
 

J11=cell2mat(J(1,1));
J11_lam=eig(J11);
h11=plot(real(J11_lam),imag(J11_lam),'.',"MarkerEdgeColor",[166,189,219]/255)%[0.8500 0.3250 0.0980])

J21=cell2mat(J(2,1));
J21_lam=eig(J21);
h21=plot(real(J21_lam),imag(J21_lam),'.',"MarkerEdgeColor",[116,169,207]/255)%[0.9290 0.6940 0.1250])

J31=cell2mat(J(3,1));
J31_lam=eig(J31);
h31=plot(real(J31_lam),imag(J31_lam),'.',"MarkerEdgeColor",[54,144,192]/255)%[0.4940 0.1840 0.5560])

J41=cell2mat(J(4,1));
J41_lam=eig(J41);
h41=plot(real(J41_lam),imag(J41_lam),'.',"MarkerEdgeColor",[5,112,176]/255)%[1 0.5 0])

J51=cell2mat(J(5,1));
J51_lam=eig(J51);
h51=plot(real(J51_lam),imag(J51_lam),'.',"MarkerEdgeColor",[4,90,141]/255)%[0.6350 0.0780 0.1840])

%ylabel('$$k=3$$','Interpreter','latex','fontsize',9);

%%  竞争 k=0.7
subplot(2,4,3)
set(gca,'unit', 'centimeters', 'position', [10.5, 6.5, 3.5, 3.5]);
set(gca,'FontSize',8);

%画不稳定的区域
point1=[-1.1 1.1 1.1 -1.1];
point2=[-1.1 -1.1 1.1 1.1];
Color=[0.75 0.75 0.75];
a=patch(point1,point2,Color) ;
alpha(0.6);
set(a,'edgecolor','none');
hold on ;


%画圆内表示稳定性的渐变图
r=(0:0.01:1)';
theta=pi*(-1:0.01:1);
x_circle=r*cos(theta);
y_circle=r*sin(theta);

circle=x_circle.^2+y_circle.^2;
p_circle=pcolor(x_circle,y_circle,4.5*(1-circle));


% 自定义 colormap 
start_color = [253,174,107]/255; % 开始颜色
end_color = [255,245,235]/255;    % 结束颜色
n_colors = 256;                      % 颜色数量
custom_colormap = [linspace(start_color(1), end_color(1), n_colors)', ... % 红色分量
                   linspace(start_color(2), end_color(2), n_colors)', ... % 绿色分量
                   linspace(start_color(3), end_color(3), n_colors)'];    % 蓝色分量

%应用自定义 colormap
colormap(custom_colormap);

set(p_circle,'LineStyle','none');%去除网格线
%colorbar 
axis ([-1.1,1.1,-1.1,1.1]);
box on;


k=0.7;
a=k;
b=sigma*sqrt(1/(k^2+k));

J=cell(n,1);
for t=1:n;
    M=[];
for i=1:S;
    for j=1:S;
        if i==j;
            M(i,j)=1-d;
        else if i>j;
                p=rand;
                if p<=C;
                    M(i,j)=-gamrnd(a,b);
                    M(j,i)=-gamrnd(a,b); 
                else 
                     M(i,j)=0;
                     M(j,i)=0;
                end
            end
        end
    end
end
J{t,1}=M;
end
 

J11=cell2mat(J(1,1));
J11_lam=eig(J11);
h11=plot(real(J11_lam),imag(J11_lam),'.',"MarkerEdgeColor",[166,189,219]/255)%[0.8500 0.3250 0.0980])

J21=cell2mat(J(2,1));
J21_lam=eig(J21);
h21=plot(real(J21_lam),imag(J21_lam),'.',"MarkerEdgeColor",[116,169,207]/255)%[0.9290 0.6940 0.1250])

J31=cell2mat(J(3,1));
J31_lam=eig(J31);
h31=plot(real(J31_lam),imag(J31_lam),'.',"MarkerEdgeColor",[54,144,192]/255)%[0.4940 0.1840 0.5560])

J41=cell2mat(J(4,1));
J41_lam=eig(J41);
h41=plot(real(J41_lam),imag(J41_lam),'.',"MarkerEdgeColor",[5,112,176]/255)%[1 0.5 0])

J51=cell2mat(J(5,1));
J51_lam=eig(J51);
h51=plot(real(J51_lam),imag(J51_lam),'.',"MarkerEdgeColor",[4,90,141]/255)%[0.6350 0.0780 0.1840])

title('Competitive','FontSize',10);
%%  竞争 k=3
subplot(2,4,7)
set(gca,'unit', 'centimeters', 'position', [10.5, 1, 3.5, 3.5]);
set(gca,'FontSize',8);

%画不稳定的区域
point1=[-1.1 1.1 1.1 -1.1];
point2=[-1.1 -1.1 1.1 1.1];
Color=[0.75 0.75 0.75];
a=patch(point1,point2,Color) ;
alpha(0.6);
set(a,'edgecolor','none');
hold on ;


%画圆内表示稳定性的渐变图
r=(0:0.01:1)';
theta=pi*(-1:0.01:1);
x_circle=r*cos(theta);
y_circle=r*sin(theta);

circle=x_circle.^2+y_circle.^2;
p_circle=pcolor(x_circle,y_circle,4.5*(1-circle));


% 自定义 colormap 
start_color = [253,174,107]/255; % 开始颜色
end_color = [255,245,235]/255;    % 结束颜色
n_colors = 256;                      % 颜色数量
custom_colormap = [linspace(start_color(1), end_color(1), n_colors)', ... % 红色分量
                   linspace(start_color(2), end_color(2), n_colors)', ... % 绿色分量
                   linspace(start_color(3), end_color(3), n_colors)'];    % 蓝色分量

%应用自定义 colormap
colormap(custom_colormap);

set(p_circle,'LineStyle','none');%去除网格线
%colorbar 
axis ([-1.1,1.1,-1.1,1.1]);
box on;

k=3;
a=k;
b=sigma*sqrt(1/(k^2+k));

J=cell(n,1);
for t=1:n;
    M=[];
for i=1:S;
    for j=1:S;
        if i==j;
            M(i,j)=1-d;
        else if i>j;
                p=rand;
                if p<=C;
                    M(i,j)=-gamrnd(a,b);
                    M(j,i)=-gamrnd(a,b); 
                else 
                     M(i,j)=0;
                     M(j,i)=0;
                end
            end
        end
    end
end
J{t,1}=M;
end


J11=cell2mat(J(1,1));
J11_lam=eig(J11);
h11=plot(real(J11_lam),imag(J11_lam),'.',"MarkerEdgeColor",[166,189,219]/255)%[0.8500 0.3250 0.0980])

J21=cell2mat(J(2,1));
J21_lam=eig(J21);
h21=plot(real(J21_lam),imag(J21_lam),'.',"MarkerEdgeColor",[116,169,207]/255)%[0.9290 0.6940 0.1250])

J31=cell2mat(J(3,1));
J31_lam=eig(J31);
h31=plot(real(J31_lam),imag(J31_lam),'.',"MarkerEdgeColor",[54,144,192]/255)%[0.4940 0.1840 0.5560])

J41=cell2mat(J(4,1));
J41_lam=eig(J41);
h41=plot(real(J41_lam),imag(J41_lam),'.',"MarkerEdgeColor",[5,112,176]/255)%[1 0.5 0])

J51=cell2mat(J(5,1));
J51_lam=eig(J51);
h51=plot(real(J51_lam),imag(J51_lam),'.',"MarkerEdgeColor",[4,90,141]/255)%[0.6350 0.0780 0.1840])

%%  互惠 k=0.7
subplot(2,4,4)
set(gca,'unit', 'centimeters', 'position', [15, 6.5, 3.5, 3.5]);
set(gca,'FontSize',8);

%画不稳定的区域
point1=[-1.1 1.1 1.1 -1.1];
point2=[-1.1 -1.1 1.1 1.1];
Color=[0.75 0.75 0.75];
a=patch(point1,point2,Color) ;
alpha(0.6);
set(a,'edgecolor','none');
hold on ;

%画圆内表示稳定性的渐变图
r=(0:0.01:1)';
theta=pi*(-1:0.01:1);
x_circle=r*cos(theta);
y_circle=r*sin(theta);

circle=x_circle.^2+y_circle.^2;
p_circle=pcolor(x_circle,y_circle,4.5*(1-circle));


% 自定义 colormap 
start_color = [253,174,107]/255; % 开始颜色
end_color = [255,245,235]/255;    % 结束颜色
n_colors = 256;                      % 颜色数量
custom_colormap = [linspace(start_color(1), end_color(1), n_colors)', ... % 红色分量
                   linspace(start_color(2), end_color(2), n_colors)', ... % 绿色分量
                   linspace(start_color(3), end_color(3), n_colors)'];    % 蓝色分量

%应用自定义 colormap
colormap(custom_colormap);


set(p_circle,'LineStyle','none');%去除网格线


axis ([-1.1,1.1,-1.1,1.1]);
box on;
title('Mutualistic','FontSize',10)

k=0.7;
a=k;
b=sigma*sqrt(1/(k^2+k));

J=cell(n,1);
for t=1:n;
    M=[];
for i=1:S;
    for j=1:S;
        if i==j;
            M(i,j)=1-d;
        else if i>j;
                p=rand;
                if p<=C;
                    M(i,j)=gamrnd(a,b);
                    M(j,i)=gamrnd(a,b); 
                else 
                     M(i,j)=0;
                     M(j,i)=0;
                end
            end
        end
    end
end
J{t,1}=M;
end


J11=cell2mat(J(1,1));
J11_lam=eig(J11);
h11=plot(real(J11_lam),imag(J11_lam),'.',"MarkerEdgeColor",[166,189,219]/255)%[0.8500 0.3250 0.0980])

J21=cell2mat(J(2,1));
J21_lam=eig(J21);
h21=plot(real(J21_lam),imag(J21_lam),'.',"MarkerEdgeColor",[116,169,207]/255)%[0.9290 0.6940 0.1250])

J31=cell2mat(J(3,1));
J31_lam=eig(J31);
h31=plot(real(J31_lam),imag(J31_lam),'.',"MarkerEdgeColor",[54,144,192]/255)%[0.4940 0.1840 0.5560])

J41=cell2mat(J(4,1));
J41_lam=eig(J41);
h41=plot(real(J41_lam),imag(J41_lam),'.',"MarkerEdgeColor",[5,112,176]/255)%[1 0.5 0])

J51=cell2mat(J(5,1));
J51_lam=eig(J51);
h51=plot(real(J51_lam),imag(J51_lam),'.',"MarkerEdgeColor",[4,90,141]/255)%[0.6350 0.0780 0.1840])

%%  互惠 k=3
subplot(2,4,8)
set(gca,'unit', 'centimeters', 'position', [15, 1, 3.5, 3.5]);
set(gca,'FontSize',8);

%画不稳定的区域
point1=[-1.1 1.1 1.1 -1.1];
point2=[-1.1 -1.1 1.1 1.1];
Color=[0.75 0.75 0.75];
a=patch(point1,point2,Color) ;
alpha(0.6);
set(a,'edgecolor','none');
hold on ;

%画圆内表示稳定性的渐变图
r=(0:0.01:1)';
theta=pi*(-1:0.01:1);
x_circle=r*cos(theta);
y_circle=r*sin(theta);

circle=x_circle.^2+y_circle.^2;
p_circle=pcolor(x_circle,y_circle,4.5*(1-circle));


% 自定义 colormap 
start_color = [253,174,107]/255; % 开始颜色
end_color = [255,245,235]/255;    % 结束颜色
n_colors = 256;                      % 颜色数量
custom_colormap = [linspace(start_color(1), end_color(1), n_colors)', ... % 红色分量
                   linspace(start_color(2), end_color(2), n_colors)', ... % 绿色分量
                   linspace(start_color(3), end_color(3), n_colors)'];    % 蓝色分量

%应用自定义 colormap
colormap(custom_colormap);

set(p_circle,'LineStyle','none');%去除网格线
c=colorbar;
set(c,'position', [.94 .08 .01 .6]) %左右位置 上下位置 宽度 高度

axis ([-1.1,1.1,-1.1,1.1]);
box on;

k=3;
a=k;
b=sigma*sqrt(1/(k^2+k));

J=cell(n,1);
for t=1:n;
    M=[];
for i=1:S;
    for j=1:S;
        if i==j;
            M(i,j)=1-d;
        else if i>j;
                p=rand;
                if p<=C;
                    M(i,j)=gamrnd(a,b);
                    M(j,i)=gamrnd(a,b); 
                else 
                     M(i,j)=0;
                     M(j,i)=0;
                end
            end
        end
    end
end
J{t,1}=M;
end


J11=cell2mat(J(1,1));
J11_lam=eig(J11);
h11=plot(real(J11_lam),imag(J11_lam),'.',"MarkerEdgeColor",[166,189,219]/255)%[0.8500 0.3250 0.0980])

J21=cell2mat(J(2,1));
J21_lam=eig(J21);
h21=plot(real(J21_lam),imag(J21_lam),'.',"MarkerEdgeColor",[116,169,207]/255)%[0.9290 0.6940 0.1250])

J31=cell2mat(J(3,1));
J31_lam=eig(J31);
h31=plot(real(J31_lam),imag(J31_lam),'.',"MarkerEdgeColor",[54,144,192]/255)%[0.4940 0.1840 0.5560])

J41=cell2mat(J(4,1));
J41_lam=eig(J41);
h41=plot(real(J41_lam),imag(J41_lam),'.',"MarkerEdgeColor",[5,112,176]/255)%[1 0.5 0])

J51=cell2mat(J(5,1));
J51_lam=eig(J51);
h51=plot(real(J51_lam),imag(J51_lam),'.',"MarkerEdgeColor",[4,90,141]/255)%[0.6350 0.0780 0.1840])