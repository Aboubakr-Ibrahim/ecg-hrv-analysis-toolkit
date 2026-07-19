# Methodology

The workflow validates and filters ECG, builds a QRS-sensitive energy envelope, detects candidates with a physiological refractory period, and refines each candidate on the filtered ECG. R-peak separations become RR intervals in milliseconds. Physiologically implausible and abrupt local intervals are excluded before HRV features are calculated.

All adjustable thresholds and bands are in `config/default_config.m`. Report the configuration, sampling rate, duration, detected peaks, retained NN fraction, and visual review whenever presenting results.

HRV depends on acquisition length, posture, activity, respiration, age, health, medication, artifacts, and preprocessing. Different protocols should not be compared as though they were identical.
