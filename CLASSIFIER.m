%%% Master code for FMRI classifier training session. 
% train intro + 2 phase 1 rounds + imagery intro + 2 phase 2 rounds
%  ? + ~21 + ? + ~21 = ? minutes

% % INTRO
SUBJECT = 103;
SUBJ_NAME = num2str(SUBJECT);

 %% PHASE 1
SESSION = 1;
ROUND = 0; 
INTRO_CLASS_TRAIN(SUBJECT, SUBJ_NAME, SESSION, ROUND);
ROUND = 1; 
classifier_training(SUBJECT, SUBJ_NAME, SESSION, ROUND);
ROUND = 2; 
classifier_training(SUBJECT, SUBJ_NAME, SESSION, ROUND);

%% PHASE 2
SESSION = 2;
ROUND = 0; 
INTRO_CLASS_IMAGERY(SUBJECT, SUBJ_NAME, SESSION, ROUND);
ROUND = 1; 
classifier_imagery(SUBJECT, SUBJ_NAME, SESSION, ROUND);
ROUND = 2; 
classifier_imagery(SUBJECT, SUBJ_NAME, SESSION, ROUND);
