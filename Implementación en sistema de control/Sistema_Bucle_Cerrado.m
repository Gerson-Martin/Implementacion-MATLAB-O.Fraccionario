clear;close all;
s=tf('s');

dts=0.01;
N=1000;
t=dts*(1:N);

Gs=1/((s+1)*s);
Gz=c2d(Gs,dts,'tustin');

cOut=Gz.Denominator{1};
cOut(1)=[];
cOut=-flip(cOut,2);
ord=size(cOut,2);
outs=zeros(1,ord);

cIn=Gz.Numerator{1};
cIn(1)=[];
cIn=flip(cIn,2);
% ord=size(cIn,2);
ins=zeros(1,ord);
errs=zeros(1,N);
fDerr=zeros(1,ord);
figure; hold on;

tgt=1;
out=0;

%loop
for i=1+ord:N
    %Error
    err=tgt-out;

    %Time response computation at t(i) of transfer function Gz
    out=cIn*ins'+cOut*outs';
    %update inputs
    in=err
    ins(1)=[];
    ins=[ins in];
    %update outputs
    outs(1)=[];
    outs=[outs out];
    
    plot(t(i),out,'b.'); 

end

title('Sistema en bucle cerrado');grid minor




