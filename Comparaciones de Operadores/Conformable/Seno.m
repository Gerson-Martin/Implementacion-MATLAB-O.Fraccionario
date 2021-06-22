%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%OPERATOR%%%CONFORMABLE%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close all;
%Sample time
dts=0.01;
%Number of date
N=1000;
%Order fractional operator 
alfa=[0.1 0.3 0.5 0.7 1];
%Time
t=dts*(1:N);
%Function:t^(1-alpha)
ft=[];
for i=1:5
ft=[ft , (t.^(1-alfa(i)))'];
end
%reserve memory 
fDf=zeros(N,5);
fIf=zeros(N,5);
%Base Function
funcion_base=f1(t); 
%Calculating the Fractional Derivative Operator
for j=1:5
    for i=1:N
        fDf(i,j)=f1(t(i)+dts*ft(i,j))-f1(t(i));
    end
end
fDf=fDf/dts;
%Calculating the Fractional Integral Operator
for j=1:5
    for i=2:N
        fIf(i,j)=fIf(i-1,j)+dts*(fDf(i,j)/ft(i,j));
    end
end
%Grafics
%Base Function
subplot(3,1,1);
plot(t,funcion_base);
title('Función Base');grid minor;
legend('f(t)=sin(2t)','Location','northwest');
%Derivative Confomable
subplot(3,1,2);
plot(t,fDf);
legend('α=0.1','α=0.3','α=0.5','α=0.7','α=1','Location','northwest');
title('Derivada Conformable');grid minor;
%Integral Confomable
subplot(3,1,3);
plot(t,fIf);
legend('α=0.1','α=0.3','α=0.5','α=0.7','α=1','Location','northwest');
title('Integral conformable');grid minor;
%Base Function
function ret=f1(param1)
ret=sin(2*param1);
end
