# Limitations and responsible use

- This R-peak detector is a research implementation, not a validated clinical algorithm.
- Polarity, pacing, arrhythmia, motion, poor contact, and unusual sampling rates can reduce accuracy.
- Automated NN cleaning may remove physiology or retain artifacts; inspect every plot.
- Frequency HRV requires sufficient, reasonably stationary data. Short records return `NaN`.
- LF/HF is descriptive and is not claimed as a direct sympathovagal-balance measure.
- Simulated environmental/activity assignments from predecessor exploration are excluded.
- No patient data is included. Do not use this toolkit for clinical decisions.
