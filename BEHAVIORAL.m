%%% Master code for initial running room behavioral session. 

% % INTRO
% SUBJECT = 1;
% SUBJ_NAME = 'Trey';
% SESSION = 0;
% INTRO_BEHAV(SUBJECT, SUBJ_NAME, SESSION);
% clear all;

% PHASE 1
SUBJECT = 1;
SUBJ_NAME = 'Trey';
SESSION = 1;
phase1(SUBJECT, SUBJ_NAME, SESSION);
clear all; 

% PHASE 2
SUBJECT = 1;
SUBJ_NAME = 'Trey';
SESSION = 2;
phase2(SUBJECT, SUBJ_NAME, SESSION);
clear all; 

% PHASE 3
SUBJECT = 1;
SUBJ_NAME = 'Trey';
SESSION = 3;
TASK = 1;
if TASK == 1
    phase3_training(SUBJECT, SUBJ_NAME, SESSION);
elseif TASK == 2
    phase3_imagery(SUBJECT, SUBJ_NAME, SESSION);
elseif TASK == 3
    phase3_distractor(SUBJECT, SUBJ_NAME, SESSION);
end
clear all; 

% PHASE 4
SUBJECT = 1;
SUBJ_NAME = 'Trey';
SESSION = 4;
phase4(SUBJECT, SUBJ_NAME, SESSION);
clear all; 

