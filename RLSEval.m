[nr1,fs1] = audioread('NoiseRef1.wav');
[nr2, fs2] = audioread('NoiseRef2.wav');
[ns , fs0 ] = audioread('x_clean_notch.wav');

projPow   = @(z,v) (dot(z,v).^2)./dot(v,v);

lambdaVals = 0.95 : 0.001 : 0.999;
L = 128;  delta = 0.1;

NRR1 = zeros(size(lambdaVals));
NRR2 = zeros(size(lambdaVals));
Resid = zeros(size(lambdaVals));

for k = 1:numel(lambdaVals)
    lam  = lambdaVals(k);

    rls1 = dsp.RLSFilter('Length',L,'ForgettingFactor',lam,'InitialInverseCovariance',delta);
    [r1y,r1err] = rls1(nr1,ns);

    rls2 = dsp.RLSFilter('Length',L,'ForgettingFactor',lam,'InitialInverseCovariance',delta);
    [r2y,e2] = rls2(nr2,r1err);

    P_before_v1= projPow(ns, nr1);
    P_after_v1  = projPow(r1err,nr1);
    P_before_v2 = projPow(r1err,nr2);
    P_after_v2  = projPow(r2err,nr2);

    NRR1_dB(k)  = 10*log10(P_before_v1 / P_after_v1 );
    NRR2_dB(k)  = 10*log10(P_before_v2 / P_after_v2 );
    TotalResid(k) = P_after_v1 + P_after_v2;
end

figure;
plot(lambdaVals,NRR1,'-o',lambdaVals,NRR2,'-s','LineWidth',1.5); grid on
xlabel('\lambda'); ylabel('NRR (dB)');
legend('v_1','v_2','Location','best');
title(sprintf('RLS – NRR vs \\lambda  (L = %d)',L));
yyaxis right
hold on
plot(lambdaVals,10*log10(Resid/Resid(1)),'-k');
ylabel('Residual power (dB)');
legend('v_1','v_2','total resid','Location','best');
