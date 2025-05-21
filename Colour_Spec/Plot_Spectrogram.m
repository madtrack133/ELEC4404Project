%
% Plot Spectrogram
%

[y,Fs]=audioread('../NoiseRef2.wav');
spectrogram(y,512,256,512,Fs,'yaxis');
title('NoiseRef2 v2(n) spectrogram');
colorbar;
