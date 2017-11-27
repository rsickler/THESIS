%%% Master code for fMRI scanning room session. 

%SET UP SUBJECT DATA 

SUBJECT = 1;
SUBJ_NAME = 'Trey';
SESSION = 1;
SCAN_INTRO(SUBJECT, SESSION);
clear all;

if task == 1
    SUBJECT = 1;
    SUBJ_NAME = 'Trey';
    SESSION = 2;
    phase3_training(SUBJECT, SESSION);
    clear all; 
end

 if task == 2
    SUBJECT = 1;
    SUBJ_NAME = 'Trey';
    SESSION = 2;
    phase3_distractor(SUBJECT, SESSION);
    clear all;
 end
 
 if task == 3
     SUBJECT = 1;
     SUBJ_NAME = 'Trey';
     SESSION = 3;
     phase3_imagery(SUBJECT, SESSION);
     clear all;
 end

 