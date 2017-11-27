% - flip correct keypress for counterbalanced scenarios

% SETTING WINDOW/DISPLAY
% debug conditions
debugging = true;
DEBUG_MONITOR_SIZE = [700 500];
% display conditions
AssertOpenGL;
DEFAULT_MONITOR_SIZE = [1024 768];
MAINFONT = 'Arial';
MAINFONTSIZE = 30;
KEYBOARD_TRIGGER = 'Return';
SCAN_TRIGGER = '='; % skyra PST
subjectDir = [];
fmri = 0;
% seed
seed = sum(100*clock);
RandStream.setGlobalStream(RandStream('mt19937ar','Seed',seed));
% colors
COLORS.WHITE = [255 255 255];
COLORS.BLACK = [0 0 0];
COLORS.GREY = (COLORS.BLACK + COLORS.WHITE)./2;
COLORS.MAINFONTCOLOR = [200 200 200];
COLORS.BGCOLOR = [50 50 50];
WRAPCHARS = 70;
% default keypress handling
device = -1;
trigger = KEYBOARD_TRIGGER;
KbName('UnifyKeyNames');
workingDir = '/Users/treysickler/Documents/MATLAB/THESIS';

%SET UP SUBJECT DATA
SESSION = 1;
SUBJECT = 1;
SUBJ_NAME = 'trey' ;
logName = ['subj' int2str(SUBJECT) '.txt'];
% matlab save file
matlabSaveFile = ['SICKLERTEST_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
% setting up your subject's folder
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end
MATLAB_SAVE_FILE = [ppt_dir matlabSaveFile];
LOG_NAME = [ppt_dir logName];

% OPEN SCREEN
ListenChar(2); % disables keyboard input to Matlab command window
Screen('Preference', 'SkipSyncTests', 2);
screens = Screen('Screens');
screenNumber = max(screens);
resolution = Screen('Resolution',screenNumber);
if debugging
    windowSize.pixels = DEBUG_MONITOR_SIZE;
else
    HideCursor;
    windowSize.pixels = [resolution.width resolution.height];
end
[mainWindow, null] = Screen('OpenWindow',screenNumber,COLORS.WHITE,[0 0 windowSize.pixels]);
ifi = Screen('GetFlipInterval', mainWindow);
%scale font
if windowSize.pixels(2) > windowSize.pixels(1)
    SIZE_AXIS = 1;
else SIZE_AXIS = 2;
end
MAINFONTSIZE = round(30 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS)));
Screen('TextFont',mainWindow,MAINFONT);
Screen('TextSize',mainWindow,MAINFONTSIZE);
windowSize.degrees = [35 30];
windowSize.degrees_per_pixel = windowSize.degrees ./ windowSize.pixels;

% LOAD IMAGES
% create orignal directories
originalFolder = fullfile(workingDir, 'stimuli/original');
og_dir = dir(fullfile(originalFolder,'og*.jpeg'));
og_correct_dir = dir(fullfile(originalFolder,'co*.jpeg'));
og_incorrect1_dir = dir(fullfile(originalFolder,'incorrect1*.jpeg'));
og_incorrect2_dir = dir(fullfile(originalFolder,'incorrect2*.jpeg'));
N_og_images = length(og_dir);

% create variant directories
variantFolder = fullfile(workingDir, 'stimuli/variant');
v_dir = dir(fullfile(variantFolder,'v*.jpeg'));
v_correct_dir = dir(fullfile(variantFolder,'co*.jpeg'));
v_incorrect1_dir = dir(fullfile(variantFolder,'incorrect1*.jpeg'));
v_incorrect2_dir = dir(fullfile(variantFolder,'incorrect2*.jpeg'));
N_v_images = length(v_dir);

% make nonresponse texture
stimuliFolder = fullfile(workingDir, 'stimuli');
noresponse_matrix = double(imread(fullfile(stimuliFolder,'noresponse.jpg')));
noresponse_texture = Screen('MakeTexture', mainWindow, noresponse_matrix);

%make og textures
for i = 1:N_og_images
    og_matrix = double(imread(fullfile(originalFolder,og_dir(i).name)));
    og_texture(i) = Screen('MakeTexture', mainWindow, og_matrix);
    correct_matrix = double(imread(fullfile(originalFolder,og_correct_dir(i).name)));
    og_correct_texture(i) = Screen('MakeTexture', mainWindow, correct_matrix);
    incorrect1_matrix = double(imread(fullfile(originalFolder,og_incorrect1_dir(i).name)));
    og_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, incorrect1_matrix);
    incorrect2_matrix = double(imread(fullfile(originalFolder,og_incorrect2_dir(i).name)));
    og_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, incorrect2_matrix);
end
%make v textures
for i = 1:N_v_images
    v_matrix = double(imread(fullfile(variantFolder,v_dir(i).name)));
    v_texture(i) = Screen('MakeTexture', mainWindow, v_matrix);
    correct_matrix = double(imread(fullfile(variantFolder,v_correct_dir(i).name)));
    v_correct_texture(i) = Screen('MakeTexture', mainWindow, correct_matrix);
    incorrect1_matrix = double(imread(fullfile(variantFolder,v_incorrect1_dir(i).name)));
    v_incorrect1_texture(i) = Screen('MakeTexture', mainWindow, incorrect1_matrix);
    incorrect2_matrix = double(imread(fullfile(variantFolder,v_incorrect2_dir(i).name)));
    v_incorrect2_texture(i) = Screen('MakeTexture', mainWindow, incorrect2_matrix);
end

% GETTING INPUT FROM PERSON
stim.session = SESSION;
stim.subject = SUBJECT;
stim.num_realtime = 10;
stim.num_omit = 10;
stim.num_learn = 8;
stim.num_localizer = 16;
stim.num_total = stim.num_learn + stim.num_realtime + stim.num_omit + stim.num_localizer;

% define key names
LEFT = 'z';
MIDDLE='x';
RIGHT= 'c';
left = KbName(LEFT);
middle = KbName(MIDDLE);
right = KbName(RIGHT);
keyCell = {LEFT, MIDDLE, RIGHT};
subj_keys = keyCell;
allkeys = [LEFT, MIDDLE, RIGHT];
for i = 1:length(allkeys)
    keys.code(i,:) = getKeys(allkeys(i));
    keys.map(i,:) = zeros(1,256);
    keys.map(i,keys.code(i,:)) = 1;
end
subj_keycode = keys.code(1:3,:);
subj_scale = makeMap({'left', 'middle', 'right'}, 1:3, subj_keys);

% STARTING EXPERIMENT
instruct = ['Hello! \n\n Today, you will go though volleyball scenarios.' ...
    '\n\n-- press "enter" to begin --'];
displayText(mainWindow,instruct,'center',[255 0 255],WRAPCHARS);
Screen('Flip',mainWindow);
trigger = KbName(trigger);
stim.subjStartTime = waitForKeyboard(trigger,device);
runStart = GetSecs;

% SET UP PRECISE TIMING
slack  = ifi/2;
stim.TRlength = 2; %this is the speed
SPEED = 1;
stim.fontSize = 24;
stim.isiDuration = 2*SPEED;
stim.scenarioDuration = 4*SPEED;
stim.goDuration = 2*SPEED;
stim.feedbackDuration = 2*SPEED;
stim.textRow = windowSize.pixels(2)* (1/5);
stim.picRow = windowSize.pixels(2) *5/9;

%~~what dis getting at?
% [stim.cond stim.condString stimList] = counterbalance_items({cues{STIMULI}{LEARN}},{CONDSTRINGS{LEARN}}); %this just gets the cue words
% picList = lutSort(stimList, preparedCues, pics);
% IDlist = lutSort(stimList, preparedCues, pairIndex);
stimCount = 2;
config.TR = stim.TRlength;
config.nTRs.ISI = stim.isiDuration/stim.TRlength;
config.nTRs.scenario = stim.scenarioDuration/stim.TRlength;
config.nTRs.go = stim.goDuration/stim.TRlength;
config.nTRs.feedback = stim.feedbackDuration/stim.TRlength;
config.nTrials = stimCount;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.go +config.nTRs.feedback;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI

% START PHASE 1
pics = 1:stimCount;
picnumber = 1;
trial = 1;
correct_trials = 0;
ratio = 0;
while ratio < .8
    % calculate all future onsets
    timing.plannedOnsets.preITI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.preITI(trial) = timing.plannedOnsets.preITI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preITI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    timing.plannedOnsets.feedback(trial) = timing.plannedOnsets.go(trial) + config.nTRs.go*config.TR;
    % throw up the images
    % pre ITI
    timespec = timing.plannedOnsets.preITI(trial)-slack;
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.BLACK,WRAPCHARS,timespec);
    % scenario
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    Screen('DrawTexture', mainWindow, og_texture(pics(picnumber)));
    timing.actualOnsets.scenario(trial) = Screen('Flip',mainWindow,timespec);
    % go
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'go!','center',COLORS.BLACK,WRAPCHARS,timespec);
    %feedback
    timespec = timing.plannedOnsets.feedback(trial)-slack;
    stop = 0;
    tEnd=GetSecs+2;
    key=0;
    while ~stop && GetSecs<tEnd
        [ keyIsDown, t, keyCode ] = KbCheck;
        key = find(keyCode, 1);
        if key==left
            stop = 1;
        elseif key== middle
            stop = 1;
        elseif key== right
            stop = 1;
        end
    end
    if key==left
        Screen('DrawTexture', mainWindow, og_correct_texture(pics(picnumber)));
        correct_trials = correct_trials + 1;
    elseif key== middle
        Screen('DrawTexture', mainWindow, og_incorrect1_texture(pics(picnumber)));
    elseif key== right
        Screen('DrawTexture', mainWindow, og_incorrect2_texture(pics(picnumber)));
    else
        Screen('DrawTexture', mainWindow, noresponse_texture);
    end
    timing.actualOnsets.feedback(trial) = Screen('Flip',mainWindow,timespec);
    %after completing full trial, update counts
    picnumber = picnumber +1; 
    % at end of  trial cycle, check accuracy and re-cycle through if needed
    if ~mod(trial,stimCount)
        %calculate ratio
        ratio = correct_trials / trial;        
        %if ratio too low, reshuffle for another run through
        if ratio < .8
         pics = Shuffle(pics);
         picnumber = 1; 
        end
        %if done, have final feedback stay up on screen for intended duration
        if ratio > .8
           WaitSecs(2);
        end
    end
    trial = trial + 1;
end

% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.feedback(end) + config.nTRs.feedback*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.BLACK,WRAPCHARS,timespec);
WaitSecs(2);
displayText(mainWindow,'80% accuracy achieved! hurray!','center',[255 0 255],WRAPCHARS);
Screen('Flip',mainWindow);
WaitSecs(2);

% START PHASE 2
instruct = ['Would you like to start phase 2?' ...
    '\n\n-- press "enter" to begin --'];
displayText(mainWindow,instruct,'center',[255 0 255],WRAPCHARS);
Screen('Flip',mainWindow);
phase2_StartTime = waitForKeyboard(trigger,device);
runStart = GetSecs;

%initialize variables
originalCount = 2;
variantCount = 2;
trialCount = originalCount + variantCount;
trial = 1;
og_randomized = randperm(originalCount);
v_randomized = randperm(variantCount);
og_picnumber = 1; 
v_picnumber = 1; 
% randomly interleave variants into originals at 3:1 ratio
A = zeros(1,originalCount);
B = ones(1, variantCount);
C = horzcat(A,B);
condition = Shuffle(C);
while trial <= trialCount
    if condition(trial) == 0
        %load original images
        current_scenario_texture = og_texture(og_randomized(og_picnumber));
        current_correct_texture = og_correct_texture(og_randomized(og_picnumber));
        current_incorrect1_texture = og_incorrect1_texture(og_randomized(og_picnumber));
        current_incorrect2_texture = og_incorrect2_texture(og_randomized(og_picnumber));
        og_picnumber = og_picnumber +1;
    else
        %load variant images
        current_scenario_texture = v_texture(v_randomized(v_picnumber));
        current_correct_texture = v_correct_texture(v_randomized(v_picnumber));
        current_incorrect1_texture = v_incorrect1_texture(v_randomized(v_picnumber));
        current_incorrect2_texture = v_incorrect2_texture(v_randomized(v_picnumber));
        v_picnumber = v_picnumber +1;
    end
    % calculate all future onsets
    timing.plannedOnsets.preITI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.preITI(trial) = timing.plannedOnsets.preITI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preITI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    timing.plannedOnsets.feedback(trial) = timing.plannedOnsets.go(trial) + config.nTRs.go*config.TR;
    % throw up the images
    % pre ITI
    timespec = timing.plannedOnsets.preITI(trial)-slack;
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.BLACK,WRAPCHARS,timespec);
    % scenario
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    Screen('DrawTexture', mainWindow, current_scenario_texture);
    timing.actualOnsets.scenario(trial) = Screen('Flip',mainWindow,timespec);
    % go
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'go!','center',COLORS.BLACK,WRAPCHARS,timespec);
    %feedback
    timespec = timing.plannedOnsets.feedback(trial)-slack;
    stop = 0;
    tEnd=GetSecs+2;
    key=0;
    while ~stop && GetSecs<tEnd
        [ keyIsDown, t, keyCode ] = KbCheck;
        key = find(keyCode, 1);
        if key==left
            stop = 1;
        elseif key== middle
            stop = 1;
        elseif key== right
            stop = 1;
        end
    end
    if key==left
        Screen('DrawTexture', mainWindow, current_correct_texture);
        correct_trials = correct_trials + 1;
    elseif key== middle
        Screen('DrawTexture', mainWindow, current_incorrect1_texture);
    elseif key== right
        Screen('DrawTexture', mainWindow, current_incorrect2_texture);
    else
        Screen('DrawTexture', mainWindow, noresponse_texture);
    end
    timing.actualOnsets.feedback(trial) = Screen('Flip',mainWindow,timespec);
    %after completing full trial, update counts
    trial = trial + 1;
    %if done, have final feedback stay up on screen for intended duration
    if trial >= trialCount
        WaitSecs(2);
    end
end

% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.feedback(end) + config.nTRs.feedback*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.BLACK,WRAPCHARS,timespec);
WaitSecs(2);
displayText(mainWindow,'all done! hurray!','center',[255 0 255],WRAPCHARS);
Screen('Flip',mainWindow);
WaitSecs(2);

% CLOSE SCREEN
Screen('CloseAll')
ShowCursor;
