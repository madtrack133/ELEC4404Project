[nr2, fs2] = audioread('../NoiseRef2.wav');

N_window = length(nr2);

%standard periodogram
[px_rectangular, f_rectangular] = periodogram(nr2(1:N_window), rectwin(N_window), [], fs2);

% -------------------- Welch's method --------------------

% overlap percentage
%overlap = 0.1:0.2:0.9;
%overlap = 0.9;

% length of window
L = [2^12, 2^13, 2^14];

% -------------------- Plots --------------------


figure;

plot(f_rectangular, 10*log10(px_rectangular), 'DisplayName', 'Standard Periodogram');
hold on;

for i = 1:length(L)

    L_val = L(i);                      % current window length
    window1 = rectwin(L_val);                % rectangular window of length L
    noverlap = round(L_val * overlap);       % fixed overlap percentage

    % Compute Welch's PSD
    [px_rect_w, f_rect_w] = pwelch(nr2, window1, noverlap, [], fs2);

    % Plot with label
    plot(f_rect_w, 10*log10(px_rect_w), 'DisplayName', sprintf('Welch (L = %d)', L_val));
end

xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title("Welch's Periodogram with Varying L (Rectangular Window)");
legend show;
grid on;