function [hg,htick,hcb]=tersurf(c1,c2,c3,d)
%FUNCTION [HG,HTICK,HCB]=TERSURF(C1,C2,C3,D) plots the values in the vector d 
% as a pseudo color plot in a ternary diagram.
% The three vectors c1,c2,c3 define the position of a data value within the
% ternary diagram.
% The ternary axis system is created within the function.
% Axis label can be added using the terlabel function.
% The function returns three handels: hg can be used to modify the grid lines,
% htick must be used to access the tick label properties, and hcb is the handle
% for the colorbar.
%
% Uli Theune, Geophysics, University of Alberta
% 2002 - ...
%

if nargin < 4
    error('Error: Not enough input arguments.');
    return
end
if (length(c1)+length(c2)+length(c3))/length(c1) ~=3
    error('Error: all arrays must be of equal length.');
    return
end

% Check if the data need to be normalized
if max(c1+c2+c3)>1
    for i=1:length(c1)
        c1(i)=c1(i)/(c1(i)+c2(i)+c3(i));
        c2(i)=c2(i)/(c1(i)+c2(i)+c3(i));
        c3(i)=c3(i)/(c1(i)+c2(i)+c3(i));
    end
end

hold on
% Calculate the position of the data points in the ternary diagram
% 计算三元图中数据点的位置
x=0.5-c1*cos(pi/3)+c2/2;
y=0.866-c1*sin(pi/3)-c2*cot(pi/6)/2;

% Create short vectors for the griding
%为网格创建短向量
tri=delaunay(x,y);%delaunay(x,y) 基于向量 x 和 y 中的点创建二维 Delaunay 三角剖分
trisurf(tri,x,y,d);%绘制delaunay的输出
%trisurf(T,x,y,z) 绘制由向量 x、y 和 z 中的点以及三角连接矩阵 T 定义的三维三角曲面。
shading interp %通过在每个线条或面中对颜色图索引或真彩色值进行插值来改变该线条或面中的颜色

% Add the axis system now
%添加轴系统 
%三角形内部的边
d1=cos(pi/3);
d2=sin(pi/3);
l=linspace(0,1,6);
zmax=max(d);
for i=2:length(l)-1
   hg(i-1,3)=plot3([l(i)*d1 1-l(i)*d1],[l(i)*d2 l(i)*d2],[zmax zmax]*1.1,':k','linewidth',0.25);
   hg(i-1,1)=plot3([l(i) l(i)+(1-l(i))*d1],[0 (1-l(i))*d2],[zmax zmax]*1.1,':k','linewidth',0.25);
   hg(i-1,2)=plot3([(1-l(i))*d1 1-l(i)],[(1-l(i))*d2 0],[zmax zmax]*1.1,':k','linewidth',0.25);
end
plot([0 1 0.5 0],[0 0 sqrt(3)/2 0],'k','linewidth',1) %三角形的边

% Make x-tick labels
for i=1:length(l)
    htick(i,1)=text(l(i),-0.025,num2str(l(i)));
    htick(i,3)=text(1-l(i)*cos(pi/3)+0.025,l(i)*sin(pi/3)+0.025,num2str(l(i)));
    htick(i,2)=text(0.5-l(i)*cos(pi/3)-0.06,sin(pi/3)*(1-l(i)),num2str(l(i)));
end
hold off
axis image
axis off
caxis([min(d) max(d)])%设置当前坐标区的颜色范围
view(2)
hcb=colorbar;