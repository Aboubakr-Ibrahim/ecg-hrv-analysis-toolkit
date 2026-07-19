function create_hrv_figures(result, outputDir)
%CREATE_HRV_FIGURES Save ECG, tachogram, and Poincare review plots.
safeId=regexprep(result.recordId,'[^a-zA-Z0-9_-]','_');
f=figure('Visible','off','Color','w','Position',[100 100 1100 750]);
subplot(3,1,1); plot(result.signal.timeSec,result.signal.filtered); hold on
plot(result.rPeaks/result.fs,result.signal.filtered(result.rPeaks),'rv');
xlabel('Time (s)'); ylabel('Amplitude'); title('Filtered ECG and R peaks'); grid on
subplot(3,1,2); plot(result.nnTimeSec,result.nnMs,'-o','MarkerSize',3);
xlabel('Time (s)'); ylabel('NN (ms)'); title('NN tachogram'); grid on
subplot(3,1,3); plot(result.nnMs(1:end-1),result.nnMs(2:end),'.');
xlabel('NN_n (ms)'); ylabel('NN_{n+1} (ms)'); title('Poincare plot'); grid on
exportgraphics(f,fullfile(outputDir,safeId+"_hrv_summary.png"),'Resolution',180);
close(f)
end
