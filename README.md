# ECG & HRV Analysis Toolkit

A modular MATLAB workflow for ECG preprocessing, R-peak detection, heart-rate variability feature extraction, quality control, visualization, and batch reporting.

## Portfolio purpose and ownership

I developed the predecessor analysis as a paid biomedical research contribution. This repository presents the genuine engineering work as a reusable toolkit. It does **not** present simulated environmental labels or exploratory results as validated clinical evidence.

Only code and documentation I am permitted to publish should be included. Client recordings, identities, reports, and restricted files remain excluded.

## Capabilities

- Zero-phase ECG band-pass filtering
- Adaptive R-peak detection and local refinement
- Physiologic and local-median RR artifact rejection
- Gap-aware successive-interval calculations
- Mean heart rate, SDNN, RMSSD, pNN50, and triangular index
- LF power, HF power, and LF/HF ratio for eligible recordings
- Poincare SD1 and SD2 using truly consecutive retained intervals
- ECG, tachogram, and Poincare quality-control plots
- MAT/CSV batch processing, status capture, and CSV export

## Why gap awareness matters

When an RR interval is rejected, the retained intervals on either side are not consecutive observations. Version 2 tracks this boundary so RMSSD, pNN50, SD1, and SD2 do not create an artificial difference across the rejected gap.

## Quick start

```matlab
addpath('config', 'src');
cfg = default_config();
result = run_hrv_pipeline(ecg, fs, cfg, "record_01", "results");
disp(result.metrics)
disp(result.cleaning)
```

MAT inputs require variables `ecg` and `fs`. CSV inputs require columns named `ecg` and `fs`, with one constant positive sampling frequency. See [data format and analysis rules](docs/data-format.md).

## Frequency-domain safeguard

LF/HF values are returned only when the retained NN tachogram spans at least 300 seconds by default. Shorter recordings remain usable for suitable time-domain review, but frequency outputs are marked ineligible rather than over-interpreted.

## Verification

The implementation has been statically reviewed for interfaces, units, continuity handling, and assumptions. Tests are included; current MATLAB runtime execution is not claimed here.

```matlab
results = runtests('tests');
table(results)
```

## Interpretation limits

Automated R-peak detection and rule-based interval cleaning do not establish normal sinus rhythm or clinical NN intervals. Results require visual quality control and an explicit annotation/artifact policy. The HRV triangular index is especially sensitive to recording duration and should not be compared across incompatible protocols.

## Responsible use

This is an educational research portfolio project, **not a medical device**. It must not be used for diagnosis, treatment, alarms, or clinical decisions.

## Author

**Aboubakr Ibrahim** — Biomedical Engineer and Independent Biomedical Research & MATLAB Consultant  
[GitHub profile](https://github.com/Aboubakr-Ibrahim) · [LinkedIn](https://www.linkedin.com/in/aboubakr-ibrahim-45435a246)

## License

[MIT](LICENSE)
