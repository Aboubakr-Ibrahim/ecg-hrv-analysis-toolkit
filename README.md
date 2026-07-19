# ECG & HRV Analysis Toolkit

A modular MATLAB workflow for ECG preprocessing, R-peak detection, heart-rate variability (HRV) feature extraction, visualization, and batch reporting.

## Portfolio purpose

I developed the predecessor analysis as a paid biomedical research contribution. This repository presents the genuine engineering work as a reusable toolkit. It does **not** present simulated environmental labels or exploratory results as validated clinical evidence.

## Capabilities

- Zero-phase ECG band-pass filtering
- Adaptive R-peak detection and local refinement
- RR-to-NN interval cleaning
- Mean heart rate, SDNN, RMSSD, pNN50, and triangular index
- LF power, HF power, and LF/HF ratio
- Poincare SD1 and SD2
- ECG, tachogram, and Poincare quality-control plots
- MAT/CSV batch processing and CSV export

## Quick start

```matlab
addpath('config', 'src');
cfg = default_config();
result = run_hrv_pipeline(ecg, fs, cfg, "record_01", "results");
disp(result.metrics)
```

MAT inputs require variables `ecg` and `fs`. CSV inputs require columns named `ecg` and `fs`. See [data format](docs/data-format.md).

## Verification

The implementation has been statically reviewed for interfaces, units, and assumptions. Tests are included but were not executed here because this workspace has no MATLAB runtime.

```matlab
results = runtests('tests');
table(results)
```

## Responsible use

This is an educational research portfolio project, **not a medical device**. It must not be used for diagnosis, treatment, alarms, or clinical decisions.

## Author

**Aboubakr Ibrahim** — Biomedical Engineer and Independent Biomedical Research & MATLAB Consultant  
[GitHub profile](https://github.com/Aboubakr-Ibrahim)

## License

[MIT](LICENSE)
