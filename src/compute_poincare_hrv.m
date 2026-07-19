function metrics = compute_poincare_hrv(nnMs, pairIsConsecutive)
%COMPUTE_POINCARE_HRV Calculate Poincare SD1 and SD2.
arguments
    nnMs {mustBeNumeric,mustBeVector}
    pairIsConsecutive (:,1) logical = logical.empty(0,1)
end
nn=double(nnMs(:));
if isempty(pairIsConsecutive)
    pairIsConsecutive = true(max(numel(nn)-1,0),1);
end
assert(numel(pairIsConsecutive)==max(numel(nn)-1,0), ...
    'ECGHRV:PairMask','Consecutive-pair mask length is invalid.');
d=diff(nn); d=d(pairIsConsecutive); sdnn=std(nn,0);
if isempty(d)
    sd1=NaN; sd2=NaN; ratio=NaN;
else
    sd1=sqrt(0.5)*std(d,0);
    sd2=sqrt(max(0,2*sdnn^2-0.5*std(d,0)^2));
    if sd2<=eps, ratio=NaN; else, ratio=sd1/sd2; end
end
metrics=struct('SD1_ms',sd1,'SD2_ms',sd2,...
    'SD1_SD2_ratio',ratio,'PoincarePair_count',numel(d));
end
