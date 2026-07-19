function metrics = compute_poincare_hrv(nnMs)
%COMPUTE_POINCARE_HRV Calculate Poincare SD1 and SD2.
nn=double(nnMs(:)); d=diff(nn); sdnn=std(nn,0);
sd1=sqrt(0.5)*std(d,0);
sd2=sqrt(max(0,2*sdnn^2-0.5*std(d,0)^2));
metrics=struct('SD1_ms',sd1,'SD2_ms',sd2,...
    'SD1_SD2_ratio',sd1/max(sd2,eps));
end
