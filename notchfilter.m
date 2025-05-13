info = audioinfo("NoisySignal.wav");
[x, Fs] = audioread("NoisySignal.wav");

f0 = 800;
Q = 35;

wo = f0/(Fs/2);
bw = wo/Q;
[b,a] = iirnotch(wo,bw);

x_clean = filtfilt(b,a,x);
spectrogram(x_clean,512,256,512,Fs,'yaxis');
colorbar;
colormap gray;
