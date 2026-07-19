function [nnMs, nnTimeSec, info] = clean_nn_intervals(rPeaks, fs, cfg)
%CLEAN_NN_INTERVALS Exclude implausible and abrupt RR intervals.
if numel(rPeaks)<3, error('ECGHRV:TooFewPeaks','Three peaks required.'); end
rrMs=diff(double(rPeaks(:)))/fs*1000;
rrTime=double(rPeaks(2:end))/fs;
localMedian=movmedian(rrMs,5,'omitnan');
valid=rrMs>=cfg.nnRangeMs(1) & rrMs<=cfg.nnRangeMs(2) & ...
    abs(rrMs-localMedian)<=cfg.localOutlierFraction.*max(localMedian,eps);
nnMs=rrMs(valid); nnTimeSec=rrTime(valid);
info=struct('totalIntervals',numel(rrMs),'retainedIntervals',numel(nnMs),...
    'retainedFraction',numel(nnMs)/numel(rrMs));
if numel(nnMs)<2, error('ECGHRV:TooFewNN','Too few NN intervals remain.'); end
end
