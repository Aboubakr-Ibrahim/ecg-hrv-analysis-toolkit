function [rPeaks, quality] = detect_r_peaks(ecg, fs, cfg)
%DETECT_R_PEAKS Energy-envelope detector with local peak refinement.
x = double(ecg(:));
band = cfg.detectorBandHz;
band(2) = min(band(2),0.90*fs/2);
if band(1) >= band(2)
    error('ECGHRV:SamplingRate', ...
        'Sampling rate is too low for the configured detector passband.');
end
[b,a] = butter(2,band/(fs/2),'bandpass');
z = filtfilt(b,a,x);
envelope = movmean([0;diff(z)].^2,max(3,round(0.12*fs)));
threshold = median(envelope)+cfg.peakThresholdScale*1.4826*...
    median(abs(envelope-median(envelope)));
distance = max(1,floor(60*fs/cfg.maxHeartRateBpm));
[~,candidates] = findpeaks(envelope,'MinPeakHeight',threshold,...
    'MinPeakDistance',distance);
radius = max(1,round(cfg.refinementWindowSeconds*fs));
rPeaks = zeros(size(candidates));
for i = 1:numel(candidates)
    left=max(1,candidates(i)-radius); right=min(numel(x),candidates(i)+radius);
    [~,j]=max(abs(x(left:right))); rPeaks(i)=left+j-1;
end
rPeaks=unique(rPeaks(:));
bpm=numel(rPeaks)/(numel(x)/fs/60);
quality=struct('candidateCount',numel(candidates),'peakCount',numel(rPeaks),...
    'estimatedBpm',bpm,'plausibleRate',bpm>=cfg.minHeartRateBpm && ...
    bpm<=cfg.maxHeartRateBpm);
end
