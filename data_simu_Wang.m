% This file generates the simulated  stability of communities mixed with 
% different proportions of exploitative, competitive and mutualistic interactions

%This file can be used to generate Fig. 4d

clc
clear all
clf

%%

sigma=0.05;
S=100;  
C=0.1;
d=1;

%% Éú³ÉP¾ØÕó
 flag=1;
 for pm=0:0.1:1     
     for pc=0:0.1:1         
        for pe=0:0.1:1             
             if pm+pc+pe==1                 
                 P_simuWang(flag,1)=pm;
                 P_simuWang(flag,2)=pc;
                 P_simuWang(flag,3)=pe;                 
                 flag=flag+1;                 
             end             
        end         
     end     
 end
%%

for n=1:size(P_simuWang,1)
    P_m=P_simuWang(n,1);
    P_c=P_simuWang(n,2);
    P_e=P_simuWang(n,3);
 
for t=1:30;
for i=1:S;
    for j=1:S;
        if i==j;
            M(i,j)=1-d;
        else if i<j;
                p1=rand;
            if p1<=C;
                p2=rand;
                if p2<=P_m;
                    M(i,j)=abs(normrnd(0,sigma,1,1));
                    M(j,i)=abs(normrnd(0,sigma,1,1));
                else if P_m<p2 && p2<=(P_c+P_m);
                    M(i,j)=-abs(normrnd(0,sigma,1,1));
                    M(j,i)=-abs(normrnd(0,sigma,1,1)); 
                    else if (P_c+P_m)<p2
                            p3=rand;
                            if p3<0.5;
                            M(i,j)=-abs(normrnd(0,sigma,1,1));
                            M(j,i)=abs(normrnd(0,sigma,1,1));  
                            else
                                M(i,j)=abs(normrnd(0,sigma,1,1));
                                M(j,i)=-abs(normrnd(0,sigma,1,1)); 
                            end
                        end
                    end
                end
            else 
                    M(i,j)=0;
                    M(j,i)=0;    
            end
            end
        end
    end
end
J(t,1)=-log(max(abs(eig(M))));
end
P_simuWang(n,4)=mean(J);
end

save("P_data_simu_Wang","P_simuWang");






