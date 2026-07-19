function result = run_hrv_pipeline(ecg, fs, cfg, recordId, outputDir)
%RUN_HRV_PIPELINE Analyze one ECG vector from signal to HRV report.
arguments
    ecg {mustBeNumeric,mustBeVector}
    fs (1,1) double {mustBePositive}
    cfg (1,1) struct
    recordId (1,1) string = "record"
    outputDir (1,1) string = ""
end
signal = preprocess_ecg(ecg,fs,cfg);
[rPeaks,quality] = detect_r_peaks(signal.filtered,fs,cfg);
[nnMs,nnTimeSec,cleaning,pairIsConsecutive] = ...
    clean_nn_intervals(rPeaks,fs,cfg);
metrics = compute_time_domain_hrv(nnMs,cfg,pairIsConsecutive);
frequency = compute_frequency_domain_hrv(nnMs,nnTimeSec,cfg);
poincare = compute_poincare_hrv(nnMs,pairIsConsecutive);
metrics = cell2struct([struct2cell(metrics);struct2cell(frequency);...
    struct2cell(poincare)],[fieldnames(metrics);fieldnames(frequency);...
    fieldnames(poincare)],1);
result = struct('recordId',recordId,'fs',fs,'signal',signal,...
    'rPeaks',rPeaks,'nnMs',nnMs,'nnTimeSec',nnTimeSec,...
    'pairIsConsecutive',pairIsConsecutive,'metrics',metrics,...
    'quality',quality,'cleaning',cleaning);
if strlength(outputDir)>0 && cfg.saveFigures
    if ~isfolder(outputDir), mkdir(outputDir); end
    create_hrv_figures(result,outputDir);
end
end
