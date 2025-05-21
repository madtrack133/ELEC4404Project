[nr1, fs1] = audioread('NoiseRef1.wav');
[nr2, fs2 ] = audioread('NoiseRef2.wav');
[ns , fss] = audioread('x_clean_notch.wav');


filterLen = 1000;   
nlms1 = dsp.LMSFilter(filterLen,'Method','Normalized LMS','StepSize',0.20);
nlms2 = dsp.LMSFilter(filterLen,'Method','Normalized LMS','StepSize',0.20);



[yr1,r1err] = nlms1(nr1,ns);

[yr2,r2err] = nlms2(nr2,r1err); 



spectrogram(r2err,2048,1024,2048,fs1,'yaxis');


audiowrite('cleansignal.wav', r2err, fs1);
