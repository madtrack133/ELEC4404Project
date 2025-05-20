[nr2, fs2] = audioread('../NoiseRef2.wav');

N_window = length(nr2);

% -------------------- Standard & Modified Periodograms --------------------

% standard periodogram
[px_rectangular, f_rectangular] = periodogram(nr2(1:N_window), rectwin(N_window), [], fs2);

% modified periodograms
[px_bartlett, f_bartlett] = periodogram(nr2(1:N_window), bartlett(N_window), [], fs2);
[px_blackman, f_blackman] = periodogram(nr2(1:N_window), blackman(N_window), [], fs2);
[px_hamming, f_hamming] = periodogram(nr2(1:N_window), hamming(N_window), [], fs2);
[px_hann, f_hann] = periodogram(nr2(1:N_window), hann(N_window), [], fs2);

% -------------------- Welch's method --------------------

% overlap percentage
overlap = 0.5;

% length of window
L = 512;

window1 = rectwin(L);
window2 = bartlett(L);
window3 = blackman(L);
window4 = hamming(L);
window5 = hann(L);

% overlap value
noverlap = L * overlap;

% default value for nfft: the number of FFT points used
[px_rect_w, f_rect_w] = pwelch(nr2, window1, noverlap, [], fs2);
[px_bart_w, f_bart_w] = pwelch(nr2, window2, noverlap, [], fs2);
[px_black_w, f_black_w] = pwelch(nr2, window3, noverlap, [], fs2);
[px_hamm_w, f_hamm_w] = pwelch(nr2, window4, noverlap, [], fs2);
[px_hann_w, f_hann_w] = pwelch(nr2, window5, noverlap, [], fs2);


% -------------------- Plots --------------------
xlabel('Hz');
ylabel('dB');

plot(f_rectangular, 10*log10(px_rectangular), f_rect_w, 10*log10(px_rect_w));
title('Rectangular');
disp('-- Hit any key to continue --'), pause;

plot(f_bartlett, 10*log10(px_bartlett), f_bart_w, 10*log10(px_bart_w));
title('Bartlett');
disp('-- Hit any key to continue --'), pause;

plot(f_blackman, 10*log10(px_blackman), f_black_w, 10*log10(px_black_w));
title('Blackman');
disp('-- Hit any key to continue --'), pause;

plot(f_hamming, 10*log10(px_hamming), f_hamm_w, 10*log10(px_hamm_w));
title('Hamming');
disp('-- Hit any key to continue --'), pause;

plot(f_hann, 10*log10(px_hann), f_hann_w, 10*log10(px_hann_w));
title('Hann');
disp('-- Hit any key to continue --'), pause;


plot(f_hann_w, 10*log10(px_hann_w), ...
    f_hamm_w, 10*log10(px_hamm_w), ...
    f_black_w, 10*log10(px_black_w), ...
    f_bart_w, 10*log10(px_bart_w), ...
    f_rect_w, 10*log10(px_rect_w))
title('All Windows Using Welchs Method')
legend('Hann','Hamming','Blackman','Bartlett', 'Rectangular');