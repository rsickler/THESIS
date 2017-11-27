%%% Master code for FMRI classifier training session. 

%go through intro
SUBJECT = 1;
SUBJ_NAME = 'Trey';
SESSION = 1;
CLASS_INTRO(SUBJECT, SESSION);
clear all;

%expose them to photos so know what to imagine by doing training first
SUBJECT = 1;
SUBJ_NAME = 'Trey';
SESSION = 3;
classifier_training(SUBJECT, SESSION);
clear all; 

%go through visualization runs
SUBJECT = 1;
SUBJ_NAME = 'Trey';
SESSION = 2;
classifier_imagery(SUBJECT, SESSION);
clear all; 




