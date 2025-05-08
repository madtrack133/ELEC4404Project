[nr1, fs1] = audioread('NoiseRef1.wav');
[nr2, fs2] = audioread('NoiseRef2.wav');
[ns, fss] = audioread('NoisySignal.wav');

L = 645504; %length of samples
f = fs1/L*(0:(L/2)); %x-axis

%noisy ref 1
nr1fft = fft(nr1);
y1 = abs(nr1fft/L);
P1 = y1(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%noisy ref 2
nr2fft = fft(nr2);
y2 = abs(nr2fft/L);
P2 = y2(1:L/2+1);
P2(2:end-1) = 2*P2(2:end-1);

%noisy signal
nsfft = fft(ns);
y3 = abs(nsfft/L);
P3 = y3(1:L/2+1);
P3(2:end-1) = 2*P3(2:end-1);

figure
plot(f, P1, f, P2, f, P3)
title("Single-Sided Amplitude Spectrums")
xlabel("f (Hz)")
ylabel("|fft(f)|")
legend('NoisyRef1', 'NoisyRef2', 'Noisy Signal')