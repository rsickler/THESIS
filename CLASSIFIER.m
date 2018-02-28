%%% Master code for FMRI classifier training session. 

% intro + 2 phase 1 rounds + 2 phase 2 rounds
%  ? + ~21 + ~21 = ? minutes

% % INTRO
SUBJECT = 1;
SUBJ_NAME = num2str(SUBJECT);

%% intro
SESSION = 0;
INTRO_BEHAV(SUBJECT, SUBJ_NAME, SESSION);

%% PHASE 1
SESSION = 1;
ROUND = 1; 
classifier_training(SUBJECT, SUBJ_NAME, SESSION, ROUND);
ROUND = 2; 
classifier_training(SUBJECT, SUBJ_NAME, SESSION, ROUND);

%% PHASE 2
SESSION = 2;
ROUND = 1; 
classifier_training(SUBJECT, SUBJ_NAME, SESSION, ROUND);
ROUND = 2; 
classifier_training(SUBJECT, SUBJ_NAME, SESSION, ROUND);
