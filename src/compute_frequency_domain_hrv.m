function metrics = compute_frequency_domain_hrv(nnMs, nnTimeSec, cfg)
%COMPUTE_FREQUENCY_DOMAIN_HRV Estimate LF/HF power from an NN tachogram.
nn=double(nnMs(:)); t=double(nnTimeSec(:));
metrics=struct('LF_ms2',NaN,'HF_ms2',NaN,'LF_HF_ratio',NaN);
if numel(nn)<16 || t(end)-t(1)<60, return; end
tu=(t(1):1/cfg.frequencyResampleHz:t(end))';
yu=detrend(interp1(t,nn,tu,'pchip'));
[pxx,f]=pwelch(yu,[],[],max(256,2^nextpow2(numel(yu))),cfg.frequencyResampleHz);
lf=f>=cfg.lfBandHz(1)&f<cfg.lfBandHz(2);
hf=f>=cfg.hfBandHz(1)&f<cfg.hfBandHz(2);
metrics.LF_ms2=trapz(f(lf),pxx(lf));
metrics.HF_ms2=trapz(f(hf),pxx(hf));
if metrics.HF_ms2>0, metrics.LF_HF_ratio=metrics.LF_ms2/metrics.HF_ms2; end
end
