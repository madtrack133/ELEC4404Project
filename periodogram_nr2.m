[nr2, fs2] = audioread('NoiseRef2.wav');

N_window = length(nr2);

%standard periodogram
[px_rectangular, f_rectangular] = periodogram(nr2(1:N_window), rectwin(N_window), [], fs2);

%modified periodograms
[px_bartlett, f_bartlett] = periodogram(nr2(1:N_window), bartlett(N_window), [], fs2);
[px_blackman, f_blackman] = periodogram(nr2(1:N_window), blackman(N_window), [], fs2);
[px_hamming, f_hamming] = periodogram(nr2(1:N_window), hamming(N_window), [], fs2);


% -------------------- Welch's method --------------------

% overlap percentage
overlap = 0.5;

% length of window
L = 512;

window1 = rectwin(L);
window2 = bartlett(L);
window3 = blackman(L);
window4 = hamming(L);

% overlap value
noverlap = L * overlap;

% default value for nfft: the number of FFT points used
[px_rect_w, f_rect_w] = pwelch(nr2, window1, noverlap, [], fs2);
[px_bart_w, f_bart_w] = pwelch(nr2, window2, noverlap, [], fs2);
[px_black_w, f_black_w] = pwelch(nr2, window3, noverlap, [], fs2);
[px_hamm_w, f_hamm_w] = pwelch(nr2, window4, noverlap, [], fs2);


% -------------------- Plots --------------------

t = tiledlayout(2,2);
nexttile
plot(f_rectangular, 10*log10(px_rectangular));
hold on;
plot(f_rect_w, 10*log10(px_rect_w));
title('Rectangular');
xlabel('Hz');
ylabel('dB');
nexttile
plot(f_bartlett, 10*log10(px_bartlett));
hold on;
plot(f_bart_w, 10*log10(px_bart_w));
title('Bartlett');
xlabel('Hz');
ylabel('dB');
nexttile
plot(f_blackman, 10*log10(px_blackman));
hold on;
plot(f_black_w, 10*log10(px_black_w));
title('Blackman');
xlabel('Hz');
ylabel('dB');
nexttile
plot(f_hamming, 10*log10(px_hamming));
hold on;
plot(f_hamm_w, 10*log10(px_hamm_w));
title('Hamming');
xlabel('Hz');
ylabel('dB');