function metrics = compute_time_domain_hrv(nnMs, cfg, pairIsConsecutive)
%COMPUTE_TIME_DOMAIN_HRV Standard time-domain descriptors.
arguments
    nnMs {mustBeNumeric,mustBeVector}
    cfg (1,1) struct
    pairIsConsecutive (:,1) logical = logical.empty(0,1)
end
nn = double(nnMs(:));
if isempty(pairIsConsecutive)
    pairIsConsecutive = true(max(numel(nn)-1,0),1);
end
assert(numel(pairIsConsecutive)==max(numel(nn)-1,0), ...
    'ECGHRV:PairMask','Consecutive-pair mask length is invalid.');
dnn = diff(nn);
dnn = dnn(pairIsConsecutive);
edges = min(nn):cfg.triangularBinWidthMs:max(nn)+cfg.triangularBinWidthMs;
counts = histcounts(nn,edges);
if isempty(counts)||max(counts)==0, tri=NaN; else, tri=numel(nn)/max(counts); end
if isempty(dnn)
    rmssd=NaN; pnn50=NaN;
else
    rmssd=sqrt(mean(dnn.^2)); pnn50=100*mean(abs(dnn)>50);
end
metrics=struct('MeanRR_ms',mean(nn),'MeanHR_bpm',60000/mean(nn),...
    'SDNN_ms',std(nn,0),'RMSSD_ms',rmssd,...
    'pNN50_percent',pnn50,'TriangularIndex',tri,...
    'NN_count',numel(nn),'SuccessivePair_count',numel(dnn));
end
