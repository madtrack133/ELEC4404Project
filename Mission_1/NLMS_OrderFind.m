[nr1, fs1] = audioread('../NoiseRef1.wav');
[nr2, fs2 ] = audioread('../NoiseRef2.wav');
[ns , fss] = audioread('../Notch_Filter/x_clean_notch.wav');

filterLen = 2000;
mu        = 0.4;

nlms1 = dsp.LMSFilter(filterLen,'Method','Normalized LMS','StepSize',mu);
[yr1,r1err,wHist1] = nlms1(nr1, ns); 
nlms2 = dsp.LMSFilter(filterLen,'Method','Normalized LMS','StepSize',mu);
[yr2,r2err,wHist2] = nlms2(nr2, r1err);

w1 = abs(wHist1(:,end));
w2 = abs(wHist2(:,end));

figure;
subplot(2,1,1); stem(w1);
title('|c_1|  (Filter 1 after 10 s)'), xlabel('Tap #'), ylabel('Magnitude');

subplot(2,1,2); stem(w2);
title('|c_2|  (Filter 2 after 10 s)'), xlabel('Tap #'), ylabel('Magnitude');
