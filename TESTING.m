%%% Master code for final running room testing session. 

SUBJECT = 1;
SUBJ_NAME = 'Trey';
SESSION = 1;
TEST_INTRO(SUBJECT, SESSION);
clear all;

if task = 1
    SUBJECT = 1;
    SUBJ_NAME = 'Trey';
    SESSION = 2;
    phase1(SUBJECT, SESSION);
    clear all; 
end

 if task = 2
    SUBJECT = 1;
    SUBJ_NAME = 'Trey';
    SESSION = 2;
    phase1(SUBJECT, SESSION);
    clear all;
 end
 
 if task = 3;
     SUBJECT = 1;
     SUBJ_NAME = 'Trey';
     SESSION = 3;
     phase2(SUBJECT, SESSION);
     clear all;
 end