%This file plots the critical S-C curve for the transition from
%unstable state to stable state

%This file can be used to generate Fig. 4a
clear all
clc

hold on 


% random
seita=4;
C1=0.01:0.001:0.03;
C2=0.03:0.0025:0.1;
C3=0.1:0.005:0.15;
C4=0.1:0.01:0.25;
C=union(union(C1,C2),union(C3,C4));
S_r=seita^2./C;
h_r=plot(S_r,C,'d',"Color",[0 0.4470 0.7410],'Markersize',4,'LineWidth',1)

% +/-
seita=4;
C1=0.001:0.001:0.03;
C2=0.03:0.0025:0.1;
C3=0.1:0.005:0.15;
C4=0.1:0.01:0.25;
C=union(union(C1,C2),union(C3,C4));

S_e=seita^2./((1+2/pi)^2*C);
h_e=plot(S_e,C,'o',"Color",[0.8500 0.3250 0.0980],'Markersize',4,'LineWidth',1)


% -/-
seita=4;
C1=0.001:0.001:0.03;
C2=0.03:0.0025:0.1;
C3=0.1:0.005:0.15;
C4=0.1:0.01:0.25;
C=union(union(C1,C2),union(C3,C4));

S_c=1+seita./(sqrt(2/pi).*C);
h_c=plot(S_c,C,'s',"Color",[0.9290 0.6940 0.1250],'Markersize',5,'LineWidth',1)

% +/+
seita=4;
C1=0.001:0.001:0.03;
C2=0.03:0.0025:0.1;
C3=0.1:0.005:0.15;
C4=0.1:0.01:0.25;
C=union(union(C1,C2),union(C3,C4));

S_m=1+seita./(sqrt(2/pi).*C);
h_m=plot(S_m,C,'+',"Color",[0.4940 0.1840 0.5560],'Markersize',4,'LineWidth',1)

%
axis ([-50,1550,-0.01,0.265])
legend boxoff;

xlabel('$$S$$','Interpreter','latex','fontsize',9);
ylabel('$$C$$','Interpreter','latex','fontsize',9); 

legend([h_r h_e h_c h_m],{'Random', 'Exploitative','Competitive','Mutualistic'},'FontSize',8)
box on
