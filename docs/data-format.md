# Input data, units, and analysis rules

Do not commit identifiable, restricted, confidential, or client-owned recordings.

## MAT input

MAT files require:

- `ecg` — one numeric ECG vector
- `fs` — one finite positive sampling-frequency scalar in hertz

## CSV input

CSV files require:

- `ecg` — one numeric ECG column
- `fs` — a column containing one constant finite positive value

Explicit names prevent timestamps, labels, or another channel from being silently analyzed as ECG. MAT and CSV files sharing the same base name receive different output identifiers.

## Units

ECG amplitude may use calibrated or arbitrary units because the detector uses robust scaling and relative thresholds. Calibration and channel identity should still be documented for every research result.

RR and NN intervals are reported in milliseconds. Sampling frequency is in hertz. LF/HF power is reported in ms² after resampling the NN tachogram.

## Required quality review

Before publishing HRV outputs, document:

- Recording source, channel, duration, and sampling rate
- R-peak detection or reference-annotation method
- Artifact and ectopic-beat policy
- Retained and rejected interval counts
- Visual review of the ECG, detected peaks, and tachogram
- Whether the rhythm and protocol support HRV interpretation
- Which metrics were suppressed and why

## Method boundaries

- The automated detector does not prove that every retained interval is a normal-to-normal interval.
- Rejected RR intervals are excluded; successive-difference and Poincare calculations do not bridge the resulting gaps.
- Frequency-domain metrics require the configured minimum duration, 300 seconds by default.
- The triangular index is duration- and binning-sensitive and is not automatically comparable across studies.
- Environmental or group labels from predecessor exploratory work are not included as validated evidence.
