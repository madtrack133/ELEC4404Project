[nr1, fs1] = audioread('NoiseRef1.wav');
[nr2, fs2 ] = audioread('NoiseRef2.wav');
[ns , fss] = audioread('x_clean_notch.wav');


filterLen = 800;   
mu = 0.1;

nlms1 = dsp.LMSFilter(filterLen,'Method','Normalized LMS','StepSize',mu);
nlms2 = dsp.LMSFilter(filterLen,'Method','Normalized LMS','StepSize',mu);



[yr1,r1err] = nlms1(nr1,ns);

[yr2,r2err] = nlms2(nr2,r1err); 

player = audioplayer(r2err,fs1);
play(player);          
