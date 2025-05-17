[nr2, fs2] = audioread('NoiseRef2.wav');

N = length(nr2);
N_window = N;

%standard periodogram
[px_rectangular, f_rectangular] = periodogram(nr2, rectwin(N_window), N, fs2);

%modified periodograms
[px_bartlett, f_bartlett] = periodogram(nr2, bartlett(N_window), N, fs2);
[px_blackman, f_blackman] = periodogram(nr2, blackman(N_window), N, fs2);
[px_hamming, f_hamming] = periodogram(nr2, hamming(N_window), N, fs2);

%create plots
t = tiledlayout(2,2);
nexttile
plot(f_rectangular, 10*log10(px_rectangular));
title('Rectangular');
xlabel('Hz');
ylabel('dB');
nexttile
plot(f_bartlett, 10*log10(px_bartlett));
title('Bartlett');
xlabel('Hz');
ylabel('dB');
nexttile
plot(f_blackman, 10*log10(px_blackman));
title('Blackman');
xlabel('Hz');
ylabel('dB');
nexttile
plot(f_hamming, 10*log10(px_hamming));
title('Hamming');
xlabel('Hz');
ylabel('dB');