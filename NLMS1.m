[nr1, fs1] = audioread('NoiseRef1.wav');
[nr2, fs2 ] = audioread('NoiseRef2.wav');
[ns , fss] = audioread('x_clean_notch.wav');

%% ── Padding section ───────────────────────────────────────────────
padLen  = 10000;                 % samples of silence you want to add
front   = true;                 % true = prepend, false = append zeros

pad     = zeros(padLen,1);

if front
    nr1 = [pad ; nr1];
    nr2 = [pad ; nr2];
    ns  = [pad ;  ns ];
else
    nr1 = [nr1 ; pad];
    nr2 = [nr2 ; pad];
    ns  = [ns  ; pad];
end

% (optional) make sure they are still equal length
minLen = min([numel(ns) numel(nr1) numel(nr2)]);
nr1 = nr1(1:minLen);    nr2 = nr2(1:minLen);    ns = ns(1:minLen);
%% ─────────────────────────────────────────────────────────────────

lag = finddelay(ns, nr1);             % positive = nr1 lags ns
nr1  = nr1(1+max(lag,0):end);         % shift & equal-length
nr2  = nr2(1+max(lag,0):end);
ns   = ns(1:end-max(lag,0));


filterLen = 1000;   
mu = 0.4;

nlms1 = dsp.LMSFilter(filterLen,'Method','Normalized LMS','StepSize',mu);
nlms2 = dsp.LMSFilter(filterLen,'Method','Normalized LMS','StepSize',mu);
nlms1.LeakageFactor = 0.995;   
nlms2.LeakageFactor = 0.995;




[yr1,r1err] = nlms1(nr1,ns);

[yr2,r2err] = nlms2(nr2,r1err); 

player = audioplayer(r2err,fs1);
play(player);          
