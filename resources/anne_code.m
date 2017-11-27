%% SETTING UP DISPLAY

AssertOpenGL
DEFAULT_MONITOR_SIZE = [1024 768];
DEBUG_MONITOR_SIZE = [700 500];
MAINFONT = 'Arial';

MAINFONTSIZE = 30;
KEYBOARD_TRIGGER = 'Return';
SCAN_TRIGGER = '='; % skyra PST
ivx = [];
subjectDir = [];
fmri = 0;
% colors
colors.WHITE = [255 255 255];
colors.BLACK = [0 0 0];
colors.GREY = (colors.BLACK + colors.WHITE)./2;
colors.GREEN = [0 255 0];
colors.RED = [255 0 0];
colors.BLUE = [0 0 255];

% initialization declarations
COLORS.MAINFONTCOLOR = [200 200 200];
COLORS.BGCOLOR = [50 50 50];
WRAPCHARS = 70;

% default keypress handling
device = -1;
trigger = KEYBOARD_TRIGGER; % keyboard
workingDir = '/Users/normanlab/motStudy04/'; % this is for whatever file your code is
windowSize.degrees = [35 30];

dbstop if error
ListenChar(2); % disables keyboard input to Matlab command window
debug = true;
Screen('Preference', 'SkipSyncTests', 2); % 0 for screentest
if debug
    screenNumber = 0;
    windowSize.pixels = DEBUG_MONITOR_SIZE;
else
    %         HideCursor;
    Screen('Preference', 'SkipSyncTests', 2);
    screens = Screen('Screens');
    screenNumber = max(screens);
    resolution = Screen('Resolution',screenNumber);
end

[mainWindow, null] = Screen('OpenWindow',screenNumber,COLORS.BGCOLOR,[0 0 windowSize.pixels]);
ifi = Screen('GetFlipInterval', mainWindow);
slack  = ifi/2; % this is what I was talking about for timing***
if windowSize.pixels(2) > windowSize.pixels(1)
    SIZE_AXIS = 1;
else SIZE_AXIS = 2;
end
MAINFONTSIZE = round(30 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS))); % scales font by window size

Screen('TextFont',mainWindow,MAINFONT);
Screen('TextSize',mainWindow,MAINFONTSIZE);
Screen('Flip',mainWindow);


windowSize.degrees_per_pixel = windowSize.degrees ./ windowSize.pixels;

logName = ['subj' int2str(subject) '.txt'];


% matlab save file
matlabSaveFile = ['EXPERIMENTNAME_' num2str(subject) '_' num2str(session) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];

ListenChar(2); %suppress keyboard input to window
KbName('UnifyKeyNames');

% setting up your subject?s folder
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end
MATLAB_SAVE_FILE = [ppt_dir MATLAB_SAVE_FILE];
LOG_NAME = [ppt_dir LOG_NAME];

% SETTING UP TIMING
config.TR = stim.TRlength;
config.nTRs.ISI = stim.isiDuration/stim.TRlength;
config.nTRs.cue = stim.cueDuration/stim.TRlength;
config.nTRs.pic = stim.picDuration/stim.TRlength;
config.nTrials = length(stimList);

config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.cue + config.nTRs.pic;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI and 20 s fixation in the beginning
% calculate all future onsets
timing.plannedOnsets.preITI(1:config.nTrials) = runStart + ((0:config.nTrials-1)*config.nTRs.perTrial)*config.TR;
timing.plannedOnsets.cue(1:config.nTrials) = timing.plannedOnsets.preITI + config.nTRs.ISI*config.TR;
timing.plannedOnsets.pic(1:config.nTrials) = timing.plannedOnsets.cue + config.nTRs.cue*config.TR;
timing.plannedOnsets.lastITI = timing.plannedOnsets.pic(end) + config.nTRs.pic*config.TR;


%% DISPLAYING TEXT/PICTURES

% to display text
timespec = timing.plannedOnsets.prompt(n)-slack;
timing.actualOnsets.prompt(n) = displayText_specific(mainWindow,stim.stim{stim.trial},'center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);

% to display an image
picIndex = prepImage(strcat(PF, stim.picStim{trial}),mainWindow);
topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (PICDIMS(HORIZONTAL)*RESCALE_FACTOR)/2;
topLeft(VERTICAL) = stim.picRow - (PICDIMS(VERTICAL)*RESCALE_FACTOR)/2;
%putting word and image
DrawFormattedText(mainWindow,stim.stim{trial},'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, picIndex, [0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
% show cue with associate
timespec = timing.plannedOnsets.pic(n) - slack;
timing.actualOnsets.pic(n) = Screen('Flip',mainWindow,timespec);% pass third input to screen flip

PICDIMS = [256 256];
pic_size = [200 200];
%pic_size = [256 256]; %changed from [200 200]
RESCALE_FACTOR = pic_size/PICDIMS;

stim.cueDuration = 2*SPEED;    % cue word alone for 0ms
stim.picDuration = 4*SPEED;    % cue with associate for 4000ms
stim.isiDuration = 2*SPEED;
stim.textRow = WINDOWSIZE.pixels(2)* (1/5); %changed from 5, then 3
stim.picRow = WINDOWSIZE.pixels(2) *5/9;

[stim.cond stim.condString stimList] = counterbalance_items({cues{STIMULI}{LEARN}},{CONDSTRINGS{LEARN}}); %this just gets the cue words
picList = lutSort(stimList, preparedCues, pics);
IDlist = lutSort(stimList, preparedCues, pairIndex);
PF = TRAININGFOLDER;

%% GETTING INPUT FROM PERSON
stim.session = SESSION;
stim.subject = SUBJECT;
stim.sessionName = SESSIONSTRINGS{SESSION};
stim.num_realtime = 10;
stim.num_omit = 10;
stim.num_learn = 8;
stim.num_localizer = 16;
stim.num_total = stim.num_learn + stim.num_realtime + stim.num_omit + stim.num_localizer;
stim.TRlength = 2; %this is the speed
stim.fontSize = 24;

THUMB = 'z';
INDEXFINGER='e';
MIDDLEFINGER='r';
RINGFINGER='t';
PINKYFINGER='y';
keys = [THUMB INDEXFINGER MIDDLEFINGER RINGFINGER PINKYFINGER];
keyCell = {THUMB, INDEXFINGER, MIDDLEFINGER, RINGFINGER, PINKYFINGER};
subj_keys = keyCell;
allkeys = keys;
% define key names so don't have to do it later
for i = 1:length(allkeys)
    keys.code(i,:) = getKeys(allkeys(i));
    keys.map(i,:) = zeros(1,256);
    keys.map(i,keys.code(i,:)) = 1;
end
subj_keycode = keys.code(1:5,:);
subj_scale = makeMap({'no image', 'generic', '1 detail', '2+ details', 'full'}, 1:5, subj_keys);
TRAININGFOLDER = [base_path 'stimuli/STIM/training/'];
seed = randseedwclock(); %

% this sets up the structure
subjectiveEK = initEasyKeys([exp_string_long '_SUB'], SUBJ_NAME,ppt_dir, ...
    'default_respmap', subj_scale, ...
    'stimmap', stimmap, ...
    'condmap', condmap, ...
    'trigger_next', subj_triggerNext, ...
    'prompt_dur', subj_promptDur, ...
    'listen_dur', subj_listenDur, ...
    'exp_onset', stim.subjStartTime, ...
    'console', false, ...
    'device', DEVICE);

% this records the subject's response at every trial
subjectiveEK = easyKeys(subjectiveEK, ...
    'onset', timing.actualOnsets.vis(n), ...
    'stim', stim.stim{stim.trial}, ...
    'cond', stim.cond(stim.trial), ...
    'cresp', cresp, 'cresp_map', cresp_map, 'valid_map', subj_map);
% this closes the structure
endSession(subjectiveEK, 'Congratulations, you have completed the practice tasks!');

%% STARTING EXPERIMENT

instruct = ['NAMED SCENES\n\nToday, you will learn the names of ' num2str(length(stimList)) ' different scenes. ' ...
    'It is important that you learn these now, as you will need to be able to picture each scene based on its name throughout our study.\n\n' ...
    'In this section, you will get a chance to study each name-scene pair, one pair at a time. To help you remember each pair, try to imagine how ' ...
    'each scene got its name - the more vivid and unique, the better your memory will be. However, you will see each scene for only four seconds, ' ...
    'so you will need to work quickly.\n\n-- press ' PROGRESS_TEXT ' to begin --'];

displayText(mainWindow,instruct,INSTANT,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
kbTrig_keycode= keys.code(2,:); % this is for the ?e? key but we can change this
stim.subjStartTime = waitForKeyboard(kbTrig_keycode,KEYDEVICES);
runStart = GetSecs;
