% This file generates the theoretical stability of communities mixed with 
% different proportions of exploitative, competitive and mutualistic interactions

%This file can be used to generate Fig. 4d

clear all
clc
clf



%%
 flag=1;
 for pm=0:0.01:1
     
     for pc=0:0.01:1
         
         for pe=0:0.01:1
             
             if pm+pc+pe==1
                 
                 P_estiWang(flag,1)=pm;
                 P_estiWang(flag,2)=pc;
                 P_estiWang(flag,3)=pe;
                 
                 flag=flag+1;
                 
             end
             
         end
         
     end
     
 end
                 

%% 本文论文
syms z_lm z_rm z_um
sigma=0.05;
S=100;  
C=0.1;
d=1;
s=d-1;

for i=1:size(P_estiWang,1)
P_m=P_estiWang(i,1);
P_c=P_estiWang(i,2);
P_e=P_estiWang(i,3);
E=C*2*sigma/sqrt(2*pi)*(P_m-P_c);
V=C*sigma^2-E^2;
betabeta=sqrt(S*V);
rho=C*2*sigma^2/pi*(P_m+P_c-P_e);
r=(rho-E^2)/V;
a=betabeta*(1+r);
b=betabeta*(1-r);
c=-E-s;

lambda_out=-s+(S-1)*E;

if abs(E)<sqrt(V/S)
   x_leftmost=c-a;
   y_leftmost=0;
   x_rightmost=c+a;
   y_rightmost=0;
   x_uppermost=c;
   y_uppermost=b;   
else
   x_leftmost=min(c-a,lambda_out);
   y_leftmost=0;
   x_rightmost=max(c+a,lambda_out);
   y_rightmost=0;
   x_uppermost=c;
   y_uppermost=b;
end

abs_lm=sqrt(x_leftmost^2+y_leftmost^2);
abs_rm=sqrt(x_rightmost^2+y_rightmost^2);
abs_um=sqrt(x_uppermost^2+y_uppermost^2);


P_estiWang(i,4)=-log(max([abs_lm abs_rm abs_um]));
end

save("P_data_esti_Wang","P_estiWang");