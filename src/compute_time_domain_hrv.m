function metrics = compute_time_domain_hrv(nnMs, cfg)
%COMPUTE_TIME_DOMAIN_HRV Standard time-domain descriptors.
nn=double(nnMs(:)); dnn=diff(nn);
edges=min(nn):cfg.triangularBinWidthMs:max(nn)+cfg.triangularBinWidthMs;
counts=histcounts(nn,edges);
if isempty(counts)||max(counts)==0, tri=NaN; else, tri=numel(nn)/max(counts); end
metrics=struct('MeanRR_ms',mean(nn),'MeanHR_bpm',60000/mean(nn),...
    'SDNN_ms',std(nn,0),'RMSSD_ms',sqrt(mean(dnn.^2)),...
    'pNN50_percent',100*mean(abs(dnn)>50),'TriangularIndex',tri,...
    'NN_count',numel(nn));
end
