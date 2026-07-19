function summary = analyze_batch(inputDir, outputDir, cfg)
%ANALYZE_BATCH Analyze MAT/CSV ECG records and export one summary table.
arguments
    inputDir (1,1) string
    outputDir (1,1) string
    cfg (1,1) struct
end
if ~isfolder(outputDir), mkdir(outputDir); end
files=[dir(fullfile(inputDir,'*.mat'));dir(fullfile(inputDir,'*.csv'))];
records=cell(numel(files),1);
for i=1:numel(files)
    path=fullfile(files(i).folder,files(i).name);
    [~,id]=fileparts(files(i).name);
    try
        [ecg,fs]=load_record(path);
        result=run_hrv_pipeline(ecg,fs,cfg,string(id),outputDir);
        row=result.metrics; row.Record=string(id); row.Status="ok";
    catch exception
        row=empty_row(); row.Record=string(id); row.Status=string(exception.identifier);
    end
    records{i}=row;
end
if isempty(records)
    summary=table();
else
    summary=struct2table(vertcat(records{:}));
end
writetable(summary,fullfile(outputDir,'hrv_summary.csv'));
end

function [ecg,fs]=load_record(path)
[~,~,extension]=fileparts(path);
if strcmpi(extension,'.mat')
    data=load(path);
    if ~isfield(data,'ecg')||~isfield(data,'fs')
        error('ECGHRV:InputFormat','MAT requires ecg and fs.');
    end
    ecg=data.ecg; fs=data.fs;
else
    data=readtable(path);
    names=lower(string(data.Properties.VariableNames));
    ecgIndex=find(names=="ecg",1); fsIndex=find(names=="fs",1);
    if isempty(ecgIndex)||isempty(fsIndex)
        error('ECGHRV:InputFormat','CSV requires ecg and fs columns.');
    end
    ecg=data{:,ecgIndex}; fs=data{1,fsIndex};
end
end

function row=empty_row()
row=struct('MeanRR_ms',NaN,'MeanHR_bpm',NaN,'SDNN_ms',NaN,...
    'RMSSD_ms',NaN,'pNN50_percent',NaN,'TriangularIndex',NaN,...
    'NN_count',NaN,'LF_ms2',NaN,'HF_ms2',NaN,'LF_HF_ratio',NaN,...
    'SD1_ms',NaN,'SD2_ms',NaN,'SD1_SD2_ratio',NaN,...
    'Record',"",'Status',"");
end
