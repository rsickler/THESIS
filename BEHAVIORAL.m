%%% Master code for initial running room behavioral session. 

% % INTRO
SUBJECT = 1;
SUBJ_NAME = num2str(SUBJECT);

%%
SESSION = 0;
INTRO_BEHAV(SUBJECT, SUBJ_NAME, SESSION);
%%
% PHASE 1
SESSION = 1;
phase1(SUBJECT, SUBJ_NAME, SESSION);
%%
% PHASE 2
SESSION = 2;
phase2(SUBJECT, SUBJ_NAME, SESSION);
%%
% PHASE 3
SESSION = 3;
TASK = 2;
if TASK == 1
    phase3_training(SUBJECT, SUBJ_NAME, SESSION);
elseif TASK == 2
    phase3_imagery(SUBJECT, SUBJ_NAME, SESSION);
elseif TASK == 3
    phase3_distractor(SUBJECT, SUBJ_NAME, SESSION);
end
%%
% PHASE 4
SESSION = 4;
phase4(SUBJECT, SUBJ_NAME, SESSION);
