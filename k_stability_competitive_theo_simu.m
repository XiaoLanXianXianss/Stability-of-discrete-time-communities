% This file generates the theoretical and simulated stability changes of the 
% competitive community matriices as k varies


% This file can be used to generate Fig. 5b

d=1;
sigma=0.05;
S=100;  
C=0.2;
n=50;

val_kesti=0.1:0.1:3.1; 
val_ksimu=0.2:0.4:3;

% theo
i=1;
for k=val_kesti
    
E_abs=sigma*sqrt(k/(k+1));
x_lm=-(d-1)-(S-1)*C*E_abs; 
y_lm=0;
x_rm=-(d-1)+C*E_abs+sqrt(S*C*(sigma^2-C*E_abs^2))*(sigma^2+(1-2*C)*E_abs^2)/(sigma^2-C*E_abs^2);
y_rm=0;
x_um=-(d-1)+C*E_abs;
y_um=sqrt(S*C*(sigma^2-C*E_abs^2))*(sigma^2-E_abs^2)/(sigma^2-C*E_abs^2);

abs_lm=sqrt(x_lm^2+y_lm^2);
abs_rm=sqrt(x_rm^2+y_rm^2);
abs_um=sqrt(x_um^2+y_um^2);

J_abs=[abs_lm,abs_rm,abs_um];
alpha_c(1,i)=-log(max(J_abs));
i=i+1;
end
h_c=plot(val_kesti,alpha_c,'linestyle','-',"Color",[0.9290 0.6940 0.1250],'LineWidth',1)

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
            M(i,j)=1-d;
        elseif i>j
                p=rand;
            if p<=C
                    M(i,j)=-gamrnd(a,b);
                    M(j,i)=-gamrnd(a,b);
            end
        end
    end
end
J(1,t)=-log(max(abs(eig(M))));
end
J_mean(3,m)=mean(J);
m=m+1;
end
%
h_cc=plot(val_ksimu,J_mean(3,:),'s','Markersize',5,'MarkerEdgeColor',[0.9290 0.6940 0.1250],'MarkerFaceColor',[0.9290 0.6940 0.1250])




