%This file generates visualizations of the theoretical and simulated 
%stability of communities composed of different proportions of interaction types

%This file can be used to generate Fig. 4d

clear all
clc


%% 
figure;
set(gcf, 'unit', 'centimeters', 'position', [10 1 10 5]); 

%% 理论估计

subplot(1,2,1)
set(gca,'unit', 'centimeters', 'position', [1,1,3,3]);

%读取数据
P=cell2mat(struct2cell(load('P_data_esti_Wang.mat')));


[hg,htick,hcb]=tersurf(P(:,1),P(:,2),P(:,3),P(:,4)); %矩阵A的前三列

%关掉色阶
colorbar('off');
% Add the labels
hlabels_esti=terlabel('P_m','P_c','P_e');

%确定alpha的最大最小值
alpha_min=min(P(:,4));
alpha_max=max(P(:,4));


shading interp;

%--  Modify the labels
set(hlabels_esti,'fontsize',9);

set(hlabels_esti(2),'color','k','String',{'$$P_{+/+}$$'},'Interpreter','latex')
set(hlabels_esti(1),'color','k','String',{'$$P_{-/-}$$'},'Interpreter','latex')
set(hlabels_esti(3),'color','k','String',{'$$P_{+/-}$$'},'Interpreter','latex')

%--  Modify the tick labels
set(htick(:,1),'color','k','linewidth',3);
set(htick(:,2),'color','k','linewidth',3);
set(htick(:,3),'color','k','linewidth',3);


title('Theoretical estimation','fontsize',10);
%% 数值仿真
%读取数据
P=cell2mat(struct2cell(load('P_data_simu_Wang.mat')));


subplot(3,2,2)
set(gca,'unit', 'centimeters', 'position', [5,1,3,3])


% Plot the data
% First set the colormap (can't be done afterwards)
colormap(jet)
[hg,htick,hcb]=tersurf(P(:,1),P(:,2),P(:,3),P(:,4)); %矩阵A的前三列

% Add the labels
hlabels_simu=terlabel('P_m','P_c','P_e');

% 数值仿真利用理论估计的colobar的最大值最小值
caxis([alpha_min alpha_max])

%确定colorbar位置
color_bar=colorbar;
set(color_bar,'position', [.90 .25 .02 .55]) %左右位置 上下位置 宽度 高度

%--  Change the color of the grid lines
%去掉图像中的网格
shading interp;

%--  Modify the labels
set(hlabels_simu,'fontsize',9)
set(hlabels_simu(2),'color','k','String',{'$$P_{+/+}$$'},'Interpreter','latex')
set(hlabels_simu(1),'color','k','String',{'$$P_{-/-}$$'},'Interpreter','latex')
set(hlabels_simu(3),'color','k','String',{'$$P_{+/-}$$'},'Interpreter','latex')

%--  Modify the tick labels
set(htick(:,1),'color','k','linewidth',3)
set(htick(:,2),'color','k','linewidth',3)
set(htick(:,3),'color','k','linewidth',3)


title('Numerical simulation','fontsize',10);