name='eric.wav';
[y,Fs]=audioread(name);
Y=abs(fftshift(y));
plot(Y)
xlabel('Frequency(Hz)');
ylabel('Vm(f)');

Yfiltered=IdealLPF(Y);
Yfiltered=abs(Yfiltered);
figure
plot(Yfiltered)
xlabel('Frequency(Hz)   Filtered Signal');
ylabel('Vm(f)');
yfiltered=ifftshift(Yfiltered);
figure
plot(yfiltered)
xlabel('Time(s)   Filtered Signal');
ylabel('Vm(t)');
audiowrite('filteredaudio.wav',yfiltered,Fs);
[y,Fs]=audioread('filteredaudio.wav');
sound(y,Fs)
Fc=100000;
Fs=5*Fc;
Ymodulated=abs(ammod(Yfiltered,Fc,Fs));
figure
plot(Ymodulated)
xlabel('Frequency(Hz)  Modulated Signal');
ylabel('Vm(f)');

Ymodnoise1 = abs(awgn(Ymodulated,0));
Ydemodulated1=abs(amdemod(Ymodnoise1,Fc,Fs));
figure
plot(Ydemodulated1)
ylabel('Vm(f)');
xlabel('Frequency (Hz) Demodulated Signal    SNR=0');
%sound(Ydemodulated1,Fs/5)
Ydemodulated1=ifftshift(Ydemodulated1);
figure
plot(Ydemodulated1)
ylabel('Vm(t)');
xlabel('t(s)     SNR=0');

Ymodnoise2 = abs(awgn(Ymodulated,10));
Ydemodulated2=abs(amdemod(Ymodnoise2,Fc,Fs));
figure
plot(Ydemodulated2)
ylabel('Vm(f)');
xlabel('Frequency (Hz)     SNR=10');
%sound(Ydemodulated2,Fs/5)
Ydemodulated2=ifftshift(Ydemodulated2);
figure
plot(Ydemodulated2)
ylabel('Vm(t)');
xlabel('t(s)     SNR=10');

Ymodnoise3 = abs(awgn(Ymodulated,30));
Ydemodulated3=abs(amdemod(Ymodnoise3,Fc,Fs));
figure
plot(Ydemodulated3)
ylabel('Vm(f)');
xlabel('Frequency (Hz)     SNR=30');
%sound(Ydemodulated3,Fs/5)
Ydemodulated3=ifftshift(Ydemodulated3);
figure
plot(Ydemodulated3)
ylabel('Vm(t)');
xlabel('t(s)     SNR=30');


Ymoderror=abs(awgn(Ymodulated,10));
Ydemoderror=abs(amdemod(Ymoderror,100100,Fs));
figure
plot(Ydemoderror)
ylabel('Vm(f)');
xlabel('Frequency (Hz)    Fc=100.1KHz');
%sound(Ydemoderror,Fs/5)
Ydemoderror=ifftshift(Ydemoderror);
figure
plot(Ydemoderror)
ylabel('Vm(t)');
xlabel('t(s)     Fc=100.1KHz');

Ymodphaseerror = abs(awgn(Ymodulated,10));
Ydemodperror=abs(amdemod(Ymodphaseerror,Fc,Fs,20));
figure
plot(Ydemodperror)
ylabel('Vm(f)');
xlabel('Frequency (Hz)     SNR=10');
%sound(Ydemodperror,Fs/5)
Ydemodperror=ifftshift(Ydemodperror);
figure
plot(Ydemodulated2)
ylabel('Vm(t)');
xlabel('t(s)     SNR=10');
