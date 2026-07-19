# Input data format

Do not commit identifiable, restricted, confidential, or client-owned recordings.

- MAT: variables named `ecg` and `fs`
- CSV: columns named `ecg` and `fs`

`ecg` is a numeric vector. `fs` is the sampling frequency in hertz. Explicit names prevent timestamps, labels, or another channel from being silently analyzed as ECG.
