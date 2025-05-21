[nr1, fs1] = audioread('../NoiseRef1.wav');
[nr2, fs2] = audioread('../NoiseRef2.wav');
[ns, fss] = audioread('../Notch_Filter/x_clean_notch.wav');


filterLen = 1000;      
mu        = 0.0001;    
lms1 = dsp.LMSFilter(filterLen, 'StepSize', mu);
lms2 = dsp.LMSFilter(filterLen, 'StepSize', mu);
[yr1,r1err] = lms1(nr1,ns);

[yr2,r2err] = lms2(nr2,r1err);

Final = ns-yr1-yr2;

player = audioplayer(r2err,Fs);
play(player);