% convert timing
convertTR(timing.plannedOnsets.preISI(1),timing.plannedOnsets.go,2)


%timing.plannedOnsets.preISI(1) = runStart +config.wait;

runStart = timing.plannedOnsets.preISI(1)  - 20;
convertTR(runStart,timing.actualOnsets.go,2) % % find START of the go trial

% check timing lags
timing.plannedOnsets.go - timing.actualOnsets.go