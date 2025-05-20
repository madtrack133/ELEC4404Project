[nr2, fs2] = audioread('NoiseRef2.wav');

N_window = length(nr2);

%standard periodogram
[px_rectangular, f_rectangular] = periodogram(nr2(1:N_window), rectwin(N_window), [], fs2);

% -------------------- Welch's method --------------------

% overlap percentage
overlap = 0.1:0.2:0.9;

% length of window
L = 512;

window1 = rectwin(L);

% -------------------- Plots --------------------


figure;

plot(f_rectangular, 10*log10(px_rectangular), 'DisplayName', 'Standard Periodogram');
hold on;

for i = 1:length(overlap)

    % overlap value
    ov = overlap(i);
    noverlap = round(L * ov);

    % default value for nfft: the number of FFT points used
    [px_rect_w, f_rect_w] = pwelch(nr2, window1, noverlap, [], fs2);

    plot(f_rect_w, 10*log10(px_rect_w),'DisplayName', sprintf('Welch (%.0f%% Overlap)', ov*100));

end

xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title("Welch's Periodogram with Varying Overlap (Rectangular Window)");
legend show;
grid on;