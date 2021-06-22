clear;close all;
%sample time
dts=0.01;
%Number of date
N=1024;
%order operator
alfa=[0.1 0.3 0.5 0.7 0.9999999999999999999999];
%Time
t=(1:N);
%reserve memory
fD=zeros(N-1,5);
%Calculation of coefficient FIR
for j=1:5
    for i=0:N-1
        bi=gamma(alfa(j)+1)/(gamma(sym(i+1))*gamma(sym(alfa(j)-i+1)));
        fD(i+1,j)=(-1)^(i)*bi/dts^alfa(j);
    end
end
%Grafic of Operator
plot(t,fD);title('Derivative Grünwald-Letnikov-Filtro FIR')
legend('α=0.1','α=0.3','α=0.5','α=0.7','α=1','Location','northwest');grid minor;
%Saving data
xlswrite('FIR_ coefficient_Derivative',fD)
csvwrite('FIR_ coefficient_Derivative',fD)
