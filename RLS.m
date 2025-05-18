
[nr1 , fs1 ] = audioread('NoiseRef1.wav');
[nr2 , fs2 ] = audioread('NoiseRef2.wav');
[ns  , fss ] = audioread('x_clean_notch.wav');

filterLen = 256;  %256 takes 2 minutes with 6 core.
lambda    = 0.9999;
delta     = 1;         

rls1 = dsp.RLSFilter('Length',filterLen, 'ForgettingFactor',lambda,'InitialInverseCovariance', delta);

rls2 = dsp.RLSFilter('Length',filterLen, 'ForgettingFactor',lambda,'InitialInverseCovariance', delta);


[yr1 , r1err] = rls1(nr1, ns);
disp("on p2")
[yr2 , r2err] = rls2(nr2, r1err);
figure;
spectrogram(r2err, 2048, 1024, 2048, fs1, 'yaxis');
colormap gray; colorbar;

audiowrite('cleansignal_RLS.wav', r2err, fs1);
