clear;s=tf('s');
close all;
%This file plots a theoretical bode diagram


fig=figure;grid on;


%jw array
r0=2;%radius (decades) and center of plots
wsp=1; %frequency (rad) for the center of the plot
N = 1000;%precission bigger better
Nm=round(N/2);
w=logspace(-r0+log10(wsp),r0+log10(wsp),(N));
jw = 1i*w;

exp=0.5;

cbode(jw.^exp,w);

saveas(fig,'TeoricoBode','epsc');



function y = cbode(cfresp,freq)
    
% Magnitude
m = 20 * log10(abs(cfresp));

% Phase
% phase = mod(angle(cfresp)*180/pi, -180);
phase = angle(cfresp)*180/pi;
%phase = atan2(imag(cfresp),real(cfresp))*180/(2*pi);

Nc = round(size(cfresp,2)/2);
% ycenter = mod(angle( cfresp(Nc) )*180/pi, -180);

% Plot
subplot(2,1,1)
semilogx(freq,m);
grid on
ylabel('Magnitude (dB)');

subplot(2,1,2)
semilogx(freq,phase);
grid on
ylabel('Phase (deg)');
xlabel('Frequency (rad/sec)');
% ylim([ycenter-90 ycenter+45])
%yticks([0 0.5 0.8 1])
y=0;

end