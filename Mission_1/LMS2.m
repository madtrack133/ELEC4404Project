[nr1, fs1] = audioread('../NoiseRef1.wav');
[nr2, fs2] = audioread('../NoiseRef2.wav');
[ns, fss] = audioread('../Notch_Filter/x_clean_notch.wav');

%Basic LMS filter code, superseeded by NLMS
filterLen = 1000;      
mu        = 0.01;  %Low as not power adjustable 
lms1 = dsp.LMSFilter(filterLen, 'StepSize', mu);
lms2 = dsp.LMSFilter(filterLen, 'StepSize', mu);
[yr1,r1err] = lms1(nr1,ns);

[yr2,r2err] = lms2(nr2,r1err);

Final = ns-yr1-yr2;
%will play audio directly
player = audioplayer(r2err,Fs);
play(player);