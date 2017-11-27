% LOAD IMAGES
workingDir = '/Users/treysickler/Documents/MATLAB/THESIS';
ListenChar(2); % disables keyboard input to Matlab command window
Screen('Preference', 'SkipSyncTests', 2);
screens = Screen('Screens');
screenNumber = max(screens);
resolution = Screen('Resolution',screenNumber);
DEBUG_MONITOR_SIZE = [700 500];
COLORS.WHITE = [255 255 255];
windowSize.pixels = DEBUG_MONITOR_SIZE;
[mainWindow, null] = Screen('OpenWindow',screenNumber,COLORS.WHITE,[0 0 windowSize.pixels]);

% create original and variant directories and textures
% A
OA_Folder = fullfile(workingDir, 'stimuli/OA');
OAL_dir = dir(fullfile(OA_Folder,'OAL*.jpeg'));
OAL_correct_dir = dir(fullfile(OA_Folder,'correct_OAL*.jpeg'));
OAL_incorrect1_dir = dir(fullfile(OA_Folder,'incorrect1_OAL*.jpeg'));
OAL_incorrect2_dir = dir(fullfile(OA_Folder,'incorrect2_OAL*.jpeg'));
OAR_dir = dir(fullfile(OA_Folder,'OAR*.jpeg'));
OAR_correct_dir = dir(fullfile(OA_Folder,'correct_OAR*.jpeg'));
OAR_incorrect1_dir = dir(fullfile(OA_Folder,'incorrect1_OAR*.jpeg'));
OAR_incorrect2_dir = dir(fullfile(OA_Folder,'incorrect2_OAR*.jpeg'));
N_OAL_images = length(OAL_dir);
N_OAR_images = length(OAR_dir);

for i = 1:N_OAL_images
    OAL_matrix = double(imread(fullfile(OA_Folder,OAL_dir(i).name)));
    OAL_texture(i) = Screen('MakeTexture', mainWindow, OAL_matrix);
    OAL_correct_matrix = double(imread(fullfile(OA_Folder,OAL_correct_dir(i).name)));
    OAL_correct_texture(i) = Screen('MakeTexture', mainWindow, OAL_correct_matrix);
    OAL_incorrect1_matrix = double(imread(fullfile(OA_Folder,OAL_incorrect1_dir(i).name)));
    OAL_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, OAL_incorrect1_matrix);
    OAL_incorrect2_matrix = double(imread(fullfile(OA_Folder,OAL_incorrect2_dir(i).name)));
    OAL_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, OAL_incorrect2_matrix);
end
for i = 1:N_OAR_images
    OAR_matrix = double(imread(fullfile(OA_Folder,OAR_dir(i).name)));
    OAR_texture(i) = Screen('MakeTexture', mainWindow, OAR_matrix);
    OAR_correct_matrix = double(imread(fullfile(OA_Folder,OAR_correct_dir(i).name)));
    OAR_correct_texture(i) = Screen('MakeTexture', mainWindow, OAR_correct_matrix);
    OAR_incorrect1_matrix = double(imread(fullfile(OA_Folder,OAR_incorrect1_dir(i).name)));
    OAR_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, OAL_incorrect1_matrix);
    OAR_incorrect2_matrix = double(imread(fullfile(OA_Folder,OAR_incorrect2_dir(i).name)));
    OAR_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, OAR_incorrect2_matrix);
end

% B
OB_Folder = fullfile(workingDir, 'stimuli/OB');
OBL_dir = dir(fullfile(OB_Folder,'OBL*.jpeg'));
OBL_correct_dir = dir(fullfile(OB_Folder,'correct_OBL*.jpeg'));
OBL_incorrect1_dir = dir(fullfile(OB_Folder,'incorrect1_OBL*.jpeg'));
OBL_incorrect2_dir = dir(fullfile(OB_Folder,'incorrect2_OBL*.jpeg'));
OBR_dir = dir(fullfile(OB_Folder,'OBR*.jpeg'));
OBR_correct_dir = dir(fullfile(OB_Folder,'correct_OBR*.jpeg'));
OBR_incorrect1_dir = dir(fullfile(OB_Folder,'incorrect1_OBR*.jpeg'));
OBR_incorrect2_dir = dir(fullfile(OB_Folder,'incorrect2_OBR*.jpeg'));
N_OBL_images = length(OBL_dir);
N_OBR_images = length(OBR_dir);

for i = 1:N_OBL_images
    OBL_matrix = double(imread(fullfile(OB_Folder,OBL_dir(i).name)));
    OBL_texture(i) = Screen('MakeTexture', mainWindow, OBL_matrix);
    OBL_correct_matrix = double(imread(fullfile(OB_Folder,OBL_correct_dir(i).name)));
    OBL_correct_texture(i) = Screen('MakeTexture', mainWindow, OBL_correct_matrix);
    OBL_incorrect1_matrix = double(imread(fullfile(OB_Folder,OBL_incorrect1_dir(i).name)));
    OBL_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, OBL_incorrect1_matrix);
    OBL_incorrect2_matrix = double(imread(fullfile(OB_Folder,OBL_incorrect2_dir(i).name)));
    OBL_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, OBL_incorrect2_matrix);
end
for i = 1:N_OBR_images
    OBR_matrix = double(imread(fullfile(OB_Folder,OBR_dir(i).name)));
    OBR_texture(i) = Screen('MakeTexture', mainWindow, OBR_matrix);
    OBR_correct_matrix = double(imread(fullfile(OB_Folder,OBR_correct_dir(i).name)));
    OBR_correct_texture(i) = Screen('MakeTexture', mainWindow, OBR_correct_matrix);
    OBR_incorrect1_matrix = double(imread(fullfile(OB_Folder,OBR_incorrect1_dir(i).name)));
    OBR_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, OBR_incorrect1_matrix);
    OBR_incorrect2_matrix = double(imread(fullfile(OB_Folder,OBR_incorrect2_dir(i).name)));
    OBR_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, OBR_incorrect2_matrix);
end

% A'
VA_Folder = fullfile(workingDir, 'stimuli/VA');
VAL_dir = dir(fullfile(VA_Folder,'VAL*.jpeg'));
VAL_correct_dir = dir(fullfile(VA_Folder,'correct_VAL*.jpeg'));
VAL_incorrect1_dir = dir(fullfile(VA_Folder,'incorrect1_VAL*.jpeg'));
VAL_incorrect2_dir = dir(fullfile(VA_Folder,'incorrect2_VAL*.jpeg'));
VAR_dir = dir(fullfile(VA_Folder,'VAR*.jpeg'));
VAR_correct_dir = dir(fullfile(VA_Folder,'correct_VAR*.jpeg'));
VAR_incorrect1_dir = dir(fullfile(VA_Folder,'incorrect1_VAR*.jpeg'));
VAR_incorrect2_dir = dir(fullfile(VA_Folder,'incorrect2_VAR*.jpeg'));
N_VAL_images = length(VAL_dir);
N_VAR_images = length(VAR_dir);

for i = 1:N_VAL_images
    VAL_matrix = double(imread(fullfile(VA_Folder,VAL_dir(i).name)));
    VAL_texture(i) = Screen('MakeTexture', mainWindow, VAL_matrix);
    VAL_correct_matrix = double(imread(fullfile(VA_Folder,VAL_correct_dir(i).name)));
    VAL_correct_texture(i) = Screen('MakeTexture', mainWindow, VAL_correct_matrix);
    VAL_incorrect1_matrix = double(imread(fullfile(VA_Folder,VAL_incorrect1_dir(i).name)));
    VAL_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, VAL_incorrect1_matrix);
    VAL_incorrect2_matrix = double(imread(fullfile(VA_Folder,VAL_incorrect2_dir(i).name)));
    VAL_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, VAL_incorrect2_matrix);
end
for i = 1:N_VAR_images
    VAR_matrix = double(imread(fullfile(VA_Folder,VAR_dir(i).name)));
    VAR_texture(i) = Screen('MakeTexture', mainWindow, VAR_matrix);
    VAR_correct_matrix = double(imread(fullfile(VA_Folder,VAR_correct_dir(i).name)));
    VAR_correct_texture(i) = Screen('MakeTexture', mainWindow, VAR_correct_matrix);
    VAR_incorrect1_matrix = double(imread(fullfile(VA_Folder,VAR_incorrect1_dir(i).name)));
    VAR_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, VAL_incorrect1_matrix);
    VAR_incorrect2_matrix = double(imread(fullfile(VA_Folder,VAR_incorrect2_dir(i).name)));
    VAR_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, VAR_incorrect2_matrix);
end

% B'
VB_Folder = fullfile(workingDir, 'stimuli/VB');
VBL_dir = dir(fullfile(VB_Folder,'VBL*.jpeg'));
VBL_correct_dir = dir(fullfile(VB_Folder,'correct_VBL*.jpeg'));
VBL_incorrect1_dir = dir(fullfile(VB_Folder,'incorrect1_VBL*.jpeg'));
VBL_incorrect2_dir = dir(fullfile(VB_Folder,'incorrect2_VBL*.jpeg'));
VBR_dir = dir(fullfile(VB_Folder,'VBR*.jpeg'));
VBR_correct_dir = dir(fullfile(VB_Folder,'correct_VBR*.jpeg'));
VBR_incorrect1_dir = dir(fullfile(VB_Folder,'incorrect1_VBR*.jpeg'));
VBR_incorrect2_dir = dir(fullfile(VB_Folder,'incorrect2_VBR*.jpeg'));
N_VBL_images = length(VBL_dir);
N_VBR_images = length(VBR_dir);

for i = 1:N_VBL_images
    VBL_matrix = double(imread(fullfile(VB_Folder,VBL_dir(i).name)));
    VBL_texture(i) = Screen('MakeTexture', mainWindow, VBL_matrix);
    VBL_correct_matrix = double(imread(fullfile(VB_Folder,VBL_correct_dir(i).name)));
    VBL_correct_texture(i) = Screen('MakeTexture', mainWindow, VBL_correct_matrix);
    VBL_incorrect1_matrix = double(imread(fullfile(VB_Folder,VBL_incorrect1_dir(i).name)));
    VBL_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, VBL_incorrect1_matrix);
    VBL_incorrect2_matrix = double(imread(fullfile(VB_Folder,VBL_incorrect2_dir(i).name)));
    VBL_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, VBL_incorrect2_matrix);
end
for i = 1:N_OBR_images
    VBR_matrix = double(imread(fullfile(VB_Folder,VBR_dir(i).name)));
    VBR_texture(i) = Screen('MakeTexture', mainWindow, VBR_matrix);
    VBR_correct_matrix = double(imread(fullfile(VB_Folder,VBR_correct_dir(i).name)));
    VBR_correct_texture(i) = Screen('MakeTexture', mainWindow, VBR_correct_matrix);
    VBR_incorrect1_matrix = double(imread(fullfile(VB_Folder,VBR_incorrect1_dir(i).name)));
    VBR_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, VBR_incorrect1_matrix);
    VBR_incorrect2_matrix = double(imread(fullfile(VB_Folder,VBR_incorrect2_dir(i).name)));
    VBR_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, VBR_incorrect2_matrix);
end

% make error-response texture (if don't pick one of movement options)
stimuliFolder = fullfile(workingDir, 'stimuli');
error_matrix = double(imread(fullfile(stimuliFolder,'noresponse.jpg')));
error_texture = Screen('MakeTexture', mainWindow, error_matrix);


STIM_NUMBER = 1;

%ORIGINALS
if STIM_NUMBER ==1 %A, L
    scenario_texture = AL_texture(og_randomized(og_picnumber));
    correct_texture = AL_correct_texture(og_randomized(og_picnumber));
    incorrect1_texture = AL_correct_texture_incorrect1_texture(og_randomized(og_picnumber));
    incorrect2_texture = AL_correct_texture(og_randomized(og_picnumber));
    %correct_movement = 
    %incorrect_movement1 = 
    %incorrect_movement2 = 
    OAL_picnumber = OAL_picnumber +1;

elseif STIM_NUMBER ==2 %A, R
    scenario_texture = AR_texture(og_randomized(og_picnumber));
    correct_texture = AR_correct_texture(og_randomized(og_picnumber));
    incorrect1_texture = AR_incorrect1_texture(og_randomized(og_picnumber));
    incorrect2_texture = AR_incorrect2_texture(og_randomized(og_picnumber));

elseif STIM_NUMBER ==3 %B, L
    scenario_texture = OAL_texture(og_randomized(og_picnumber));
    correct_texture = og_correct_texture(og_randomized(og_picnumber));
    incorrect1_texture = og_incorrect1_texture(og_randomized(og_picnumber));
    incorrect2_texture = og_incorrect2_texture(og_randomized(og_picnumber));

elseif STIM_NUMBER ==4 %B, R
    scenario_texture = OAL_texture(og_randomized(og_picnumber));
    correct_texture = og_correct_texture(og_randomized(og_picnumber));
    incorrect1_texture = og_incorrect1_texture(og_randomized(og_picnumber));
    incorrect2_texture = og_incorrect2_texture(og_randomized(og_picnumber));


%VARIANTS
elseif STIM_NUMBER ==5 %A', L
    
elseif STIM_NUMBER ==6 %A', R
    
elseif STIM_NUMBER ==7 %B', L
    
elseif STIM_NUMBER ==8 %B', R
    
    
end