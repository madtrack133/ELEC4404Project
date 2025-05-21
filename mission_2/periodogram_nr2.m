[nr2, fs2] = audioread('../NoiseRef2.wav');

N_window = length(nr2);
my_nfft = N_window;

% -------------------- Standard & Modified Periodograms --------------------

% Standard periodogram
[px_rectangular, f_rectangular] = periodogram(nr2(1:N_window), rectwin(N_window), my_nfft, fs2);

% Modified periodograms
[px_bartlett, f_bartlett] = periodogram(nr2(1:N_window), bartlett(N_window), my_nfft, fs2);
[px_blackman, f_blackman] = periodogram(nr2(1:N_window), blackman(N_window), my_nfft, fs2);
[px_hamming, f_hamming] = periodogram(nr2(1:N_window), hamming(N_window), my_nfft, fs2);
[px_hann, f_hann] = periodogram(nr2(1:N_window), hann(N_window), my_nfft, fs2);

px_all = [px_rectangular px_bartlett px_blackman px_hamming px_hann];
f_all = [f_rectangular f_bartlett f_blackman f_hamming f_hann];

names = {'Rectangular' 'Bartlett' 'Blackman' 'Hamming' 'Hanning'};

% -------------------- Plots --------------------

xlabel('Hz');
ylabel('dB');

for i=1:5
    
    % Index current values
    px_current = px_all(:, i);
    f_current = f_all(:, i);
    name = names(i);

    % Plot current values
    plot(f_current, 10*log10(px_current));
    title(name);
    disp('-- Hit any key to continue --'), pause;

end