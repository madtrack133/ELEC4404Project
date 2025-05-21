
[nr1, fs] = audioread('../NoiseRef1.wav');
[nr2, fs] = audioread('../NoiseRef2.wav');
[ns , fss] = audioread('../Notch_Filter/x_clean_notch.wav');


%power of z vs v, correlated power
projPow = @(z,v) (dot(z,v).^2) / dot(v,v);

%iteration
muVals     = 0.01 : 0.025 : 0.8;
NRR1_dB    = zeros(size(muVals));
NRR2_dB    = zeros(size(muVals));
TotalResid = zeros(size(muVals));

filterLen = 1000;         % keep constant

for k = 1:numel(muVals) %for each
    mu = muVals(k);
    nlms1 = dsp.LMSFilter(filterLen, 'Method','Normalized LMS','StepSize',mu);
    [yr1, r1err] = nlms1(nr1, ns);

    nlms2 = dsp.LMSFilter(filterLen, 'Method','Normalized LMS','StepSize',mu);
    [yr2, r2err] = nlms2(nr2, r1err);

    P_before_v1= projPow(ns, nr1);
    P_after_v1  = projPow(r1err,nr1); %intermeduate steps
    P_before_v2 = projPow(r1err,nr2);
    P_after_v2  = projPow(r2err,nr2);

    NRR1_dB(k)  = 10*log10(P_before_v1 / P_after_v1 ); %noise reduction ratio per report
    NRR2_dB(k)  = 10*log10(P_before_v2 / P_after_v2 ); %noise reduction ratio per report
    TotalResid(k) = P_after_v1 + P_after_v2; %summation of leftover correlatted power
end
%display NNR (dB) for each filter.
figure;
plot(muVals, NRR1_dB,'-o', muVals, NRR2_dB,'-s','LineWidth',1.5);
grid on;  xlabel('\mu  (NLMS step size)');
ylabel('Noise-reduction ratio  (dB)');
legend('v_1 (NoiseRef1)', 'v_2 (NoiseRef2)', 'Location','best');
title(sprintf('Sequential NLMS -  NRR vs \\mu   (L = %d taps)', filterLen));

% overlay total residual power (normalised)
hold on;
yyaxis right;
plot(muVals, 10*log10(TotalResid/TotalResid(1)),'-k');
ylabel('Residual power (dB)');
legend('v_1 (NoiseRef1)','v_2 (NoiseRef2)','total resid','Location','best');
