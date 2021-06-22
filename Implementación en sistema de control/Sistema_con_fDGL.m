clear;close all;
s=tf('s');
%Sample time
dts=0.01;
%Number of date
N=1000;
%Order Operator
alfa=[0.1 0.3 0.5 0.7 1];
%Time
t=dts*(1:N);
%Coefficient FIR
fD=[];
%Fout: save date of output 
Fout=zeros(5,N);
fd=[];
f=[];
for j=1:5 
    fD=[];
    for i=0:N-1
        bi=gamma(alfa(j)+1) / (gamma(i+1)*gamma(alfa(j)-i+1));
        fD=[ fD (-1)^(i)*bi ];
    end
    fD=fD/dts^alfa(j);
    fd=[fd;fD];
end
%Tranfer Function
Gs=1/((s+1)*s);
%Discretizacion of G(S)
Gz=c2d(Gs,dts);
%calculation for different alpha values
for j=1:5
%Denominator
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
fDerr=zeros(1,ord);

tgt=1;%input unit step
out=0;%current output in t

    %loop
    for i=1+ord:N
        %Error
        err=tgt-out;
        fD=fd(j,:);
        %Dinamica FILO
        errs(1)=[];
        errs = [errs err];
        fDerr=[fDerr errs*flip(fD,2)'];

        %Controller 
        %Time response computation at t(i) of transfer function Gz
        out=cIn*ins'+cOut*outs';
        Fout(j,i)=out;
        %update inputs
        in=err+10*fDerr(i);%last input in(t-1)
        ins(1)=[];
        ins=[ins in];
        %update outputs
        outs(1)=[];
        outs=[outs out];

    end
end
 plot(t,Fout);
 legend('α=0.1','α=0.3','α=0.5','α=0.7','α=1');
 title('Derivada Grünwald-Letnikov');grid minor;



