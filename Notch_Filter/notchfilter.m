info = audioinfo("NoisySignal.wav");
[x, Fs] = audioread("NoisySignal.wav");
disp(Fs);
f0 = 800;
Q = 35;

wo = f0/(Fs/2);
bw = wo/Q;
[b,a] = iirnotch(wo,bw);

x_clean = filtfilt(b,a,x);
spectrogram(x_clean,512,256,512,Fs,'yaxis');

audiowrite('x_clean_notch.wav', x_clean, Fs);
colorbar;
colormap gray;
