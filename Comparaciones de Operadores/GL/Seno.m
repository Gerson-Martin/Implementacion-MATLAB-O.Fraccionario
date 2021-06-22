clear;close all;
%time step
dts=0.01;
%date number
N=1024;
% order operator
alfa=[0.1 0.3 0.5 0.7 0.9999999999999999999999];
fDf=[];
fIf=[];
%time
t=dts*(1:N);
%coefficient Derivative FIR
fD=load('fD.mat').fD;
%coefficient Integral FIR
fI=load('fI.mat').fI;
w=2;
%Base Function
funcion_base=sin(w*t);
%Convolution
for j=1:5
    fDf=[fDf ,conv(funcion_base,fD(:,j))];
end
for j=1:5
    fIf=[fIf ,conv(fDf(:,j),fI(:,j))];
    
end
%Grafics
%Function Base
subplot(3,1,1);
plot(t,funcion_base);xlim([0 10.24]);
legend('f(t)=sin(2t)','Location','northwest');
title('Funcion Base');grid minor;
%Derivative Function 
subplot(3,1,2);
plot(t,fDf(1:N,:));xlim([0 10.24]);
legend('α=0.1','α=0.3','α=0.5','α=0.7','α=1','Location','northwest');grid minor;
title('Derivada Grünwald- Letnikov');
%Integral Function
subplot(3,1,3);
plot(t,fIf(1:N,:));
xlim([0 10.24]);
legend('α=0.1','α=0.3','α=0.5','α=0.7','α=1','Location','northwest');grid minor;
title('Integral Grünwald- Letnikov')
%Integral FIR 
figure;
subplot(2,1,1);
plot(fI);xlim([0.01 120]);ylim([-0.01 0.06]);title('Integral Grünwald-Letnikov-Filtro FIR');
legend('α=0.1','α=0.3','α=0.5','α=0.7','α=1','Location','northeast');grid minor;
%Derivative FIR 
subplot(2,1,2);
plot(fD);xlim([0.01 120]);ylim([-0.30 0.06]);title('Derivative Grünwald-Letnikov-Filtro FIR');
legend('α=0.1','α=0.3','α=0.5','α=0.7','α=1','Location','northeast');grid minor;

