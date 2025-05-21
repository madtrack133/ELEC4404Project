[nr2, fs2] = audioread('../NoiseRef2.wav');

N = length(nr2);
t = (0:N-1)/fs2;

windows = [rectwin(N) hanning(N) hamming(N) bartlett(N) blackman(N)];

% shorter window lengths for window fft visualisation
N_short = 51;
short_windows = [rectwin(N_short) hanning(N_short) hamming(N_short) bartlett(N_short) blackman(N_short)];

names = {'Rectangular' 'Hanning' 'Hamming' 'Bartlett' 'Blackman'};

for i = 1:5
    window = windows(:, i);
    s_window = short_windows(:, i);
    name = names(i);

    % plot the window and its effect on the targeted signal
    subplot(1, 2, 1);
    plot(t, window, t, window.*nr2);
    title(['NoiseRef2.wav with' name 'Window']);
    xlabel('Time (s)')
    ylabel('Magnitude')

    % plot the fft of the current window
    subplot(1, 2, 2);
    Y = fft(s_window, 4096); % 4096-point fft calc (4096 bins with 51 samples)
    Y = fftshift(Y); % shift Y to the center
    Ydb = 20*log10(abs(Y) / max(abs(Y))); % normalised power dB
    fnorm = linspace(-0.5, 0.5, 4096); % normalised x-axis

    plot(fnorm, Ydb);
    title(['FFT of' name ' Window']);
    xlabel('Normalised Frequency')
    ylabel('Normalised Magnitude (dB)')

    disp('-- Hit any key to continue --'), pause;
end