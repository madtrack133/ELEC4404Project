%Stage 1 Notch filter
info = audioinfo("../NoisySignal.wav");
[x, Fs] = audioread("../NoisySignal.wav");
%target frequency and quality factor
f0 = 800;
Q = 35;

wo = f0/(Fs/2); %normalised freq
bw = wo/Q; %normalised bandwidth
[b,a] = iirnotch(wo,bw);

x_clean = filtfilt(b,a,x); %Notch filter call
spectrogram(x_clean,512,256,512,Fs,'yaxis'); %post_notch spectogram

audiowrite('x_clean_notch.wav', x_clean, Fs);
colorbar;
colormap gray;
%Stage 2, adaptive filters
[nr1 , fs1 ] = audioread('../NoiseRef1.wav');
[nr2 , fs2 ] = audioread('../NoiseRef2.wav');
[ns  , fss ] = audioread('../Notch_Filter/x_clean_notch.wav');

filterLen = 300; %Found to be best while minimising compute. takes 2-3 minutes on 6 core cpu. Do not change
lambda    = 0.9999; %Close, but not growing memory.
delta     = 1;        
%2 instances of RLS created
rls1 = dsp.RLSFilter('Length',filterLen, 'ForgettingFactor',lambda,'InitialInverseCovariance', delta);

rls2 = dsp.RLSFilter('Length',filterLen, 'ForgettingFactor',lambda,'InitialInverseCovariance', delta);


[yr1 , r1err] = rls1(nr1, ns);
disp("on p2") %To let you know it is halfway
[yr2 , r2err] = rls2(nr2, r1err);
figure;
spectrogram(r2err, 2048, 1024, 2048, fs1, 'yaxis');
colormap gray; colorbar;
% final signal
audiowrite('EnhancedSignal.wav', r2err, fs1);
