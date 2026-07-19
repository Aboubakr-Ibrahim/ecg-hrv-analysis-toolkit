classdef test_hrv_metrics < matlab.unittest.TestCase
    methods (Test)
        function constantIntervals(testCase)
            addpath('config','src'); cfg=default_config();
            m=compute_time_domain_hrv(repmat(1000,20,1),cfg);
            testCase.verifyEqual(m.MeanHR_bpm,60,'AbsTol',1e-12)
            testCase.verifyEqual(m.SDNN_ms,0,'AbsTol',1e-12)
            testCase.verifyEqual(m.RMSSD_ms,0,'AbsTol',1e-12)
        end
        function removesImpossibleInterval(testCase)
            addpath('config','src'); cfg=default_config();
            peaks=round(cumsum([0 1 1 .1 1 1])*250)+1;
            [nn,~,info,pairs]=clean_nn_intervals(peaks,250,cfg);
            testCase.verifyFalse(any(nn<cfg.nnRangeMs(1)))
            testCase.verifyLessThan(info.retainedIntervals,info.totalIntervals)
            testCase.verifyLessThan(sum(pairs),numel(nn)-1)
        end
        function successiveMetricsDoNotBridgeRejectedGap(testCase)
            addpath('config','src'); cfg=default_config();
            nn=[800;810;1200]; consecutive=[true;false];
            m=compute_time_domain_hrv(nn,cfg,consecutive);
            testCase.verifyEqual(m.SuccessivePair_count,1)
            testCase.verifyEqual(m.RMSSD_ms,10,'AbsTol',1e-12)
        end
        function shortRecordSuppressesFrequencyMetrics(testCase)
            addpath('config','src'); cfg=default_config();
            nn=repmat(1000,120,1); t=(1:120)';
            m=compute_frequency_domain_hrv(nn,t,cfg);
            testCase.verifyFalse(m.FrequencyEligible)
            testCase.verifyTrue(isnan(m.LF_HF_ratio))
        end
        function finitePoincare(testCase)
            addpath('src'); m=compute_poincare_hrv([800 810 790 805 795 815]);
            testCase.verifyTrue(isfinite(m.SD1_ms)&&isfinite(m.SD2_ms))
        end
    end
end
