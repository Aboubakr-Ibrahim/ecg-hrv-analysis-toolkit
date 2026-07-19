function cfg = default_config()
%DEFAULT_CONFIG Reproducible defaults for ECG/HRV analysis.
cfg.filterBandHz = [0.5 40];
cfg.detectorBandHz = [5 20];
cfg.filterOrder = 4;
cfg.maxHeartRateBpm = 220;
cfg.minHeartRateBpm = 30;
cfg.peakThresholdScale = 0.45;
cfg.refinementWindowSeconds = 0.08;
cfg.nnRangeMs = [300 2000];
cfg.localOutlierFraction = 0.20;
cfg.frequencyResampleHz = 4;
cfg.minFrequencyDurationSec = 300;
cfg.lfBandHz = [0.04 0.15];
cfg.hfBandHz = [0.15 0.40];
cfg.triangularBinWidthMs = 7.8125;
cfg.saveFigures = true;
end
