clear;close all;
s=tf('s');
%Sample time
dts=0.01;
%Number of date
N=1000;
%Order Operator
alfa=[0.1 0.3 0.5 0.7 1];
%Fout: save date of output 
Fout=zeros(5,N);
%ft: t^(1-alpha)
ft=zeros(5,N);
%Time
t=dts*(1:N);
%calculation for different alpha values
for j=1:5
ft(j,:)=t.^(1-alfa(j));
%Tranfer Function
Gs=1/((s+1)*s);
%Discretizacion of G(S)
%Denominator
Gz=c2d(Gs,dts);
cOut=Gz.Denominator{1};
cOut(1)=[];
cOut=-flip(cOut,2);
ord=size(cOut,2);
outs=zeros(1,ord);
%Numeator
cIn=Gz.Numerator{1};
cIn(1)=[];
cIn=flip(cIn,2);
ins=zeros(1,ord);
errs=zeros(1,N);
fDerr=zeros(1,N);

tgt=1;%input unit step
out=0;%current output in t
    %loop
    for i=1+ord:N
        %Error
        err=tgt-out;
        %First Imput First Output 
        errs(1)=[];
        errs = [errs err];
        %we calculate the confomible derivative
        fDerr(1)=[];
        fDerr=[fDerr (errs(N-i+2)-errs(N-i+3))*(dts*ft(j,N-i+2))];
        %Time response computation at t(i) of transfer function Gz
        out=cIn*ins'+cOut*outs';
        Fout(j,i)=out;
        %update inputs
        in=err+10*fDerr(N-i+2);%last input in(t-1)
        ins(1)=[];
        ins=[ins in];
        %update outputs
        outs(1)=[];
        outs=[outs out];
    end
end
 plot(t,Fout);
 legend('α=0.1','α=0.3','α=0.5','α=0.7','α=1');
 title('Derivada Confomable');grid minor;




