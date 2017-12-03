% PHASE 1
try
    SUBJECT = 1;
    SUBJ_NAME = 'Trey';
    SESSION = 1;
    phase1(SUBJECT, SUBJ_NAME, SESSION);
catch ME
    disp(['ID: ' ME.identifier])
    rethrow(ME)
end