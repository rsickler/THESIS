% debug conditions
debugging = false;
joystick = true;
running = 17;
SPEED = 1;

% setting up your subject's folder
if running == 17
    workingDir = '/Users/normanlab/THESIS';
elseif running == 18
    workingDir = '/Users/norman_lab/THESIS';
else workingDir = '/Users/treysickler/Documents/MATLAB/THESIS';
end

DEBUG_MONITOR_SIZE = [2560 1600]/4;

% SETTING WINDOW/DISPLAY
DEFAULT_MONITOR_SIZE = [1024 768];
AssertOpenGL;
MAINFONT = 'Arial';
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
COLORS.GREEN = [0 255 0];
COLORS.RED = [255 0 0];
WRAPCHARS = 70;

% default keypress handling
device = -1;
KbName('UnifyKeyNames');
press = 'Space';
trigger = KbName(press);
scan_trigger = '='; % skyra PST

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
[mainWindow, null] = Screen('OpenWindow',screenNumber,COLORS.BGCOLOR,[0 0 windowSize.pixels]);
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
% scale images
stim.textRow = windowSize.pixels(2) *(1/8);
stim.picRow = windowSize.pixels(2) *(1/2);
HORIZONTAL = 1; 
VERTICAL = 2; 
CENTER = windowSize.pixels/2;
pic_size = windowSize.pixels/2;
%feedback photos
PICDIMS = [1537 1537];
RESCALE_FACTOR = pic_size./PICDIMS;
topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (PICDIMS(HORIZONTAL)*RESCALE_FACTOR(HORIZONTAL))/2;
topLeft(VERTICAL) = stim.picRow - (PICDIMS(VERTICAL)*RESCALE_FACTOR(VERTICAL))/2;
%scenario photos
s_PICDIMS = [2049 1537];
s_RESCALE_FACTOR = pic_size./s_PICDIMS;
s_topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (s_PICDIMS(HORIZONTAL)*s_RESCALE_FACTOR(HORIZONTAL))/2;
s_topLeft(VERTICAL) = stim.picRow - (s_PICDIMS(VERTICAL)*s_RESCALE_FACTOR(VERTICAL))/2;
%non-response photo
NR_PICDIMS = [1024 768];
NR_RESCALE_FACTOR = pic_size./NR_PICDIMS;
NR_topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (NR_PICDIMS(HORIZONTAL)*NR_RESCALE_FACTOR(HORIZONTAL))/2;
NR_topLeft(VERTICAL) = stim.picRow - (NR_PICDIMS(VERTICAL)*NR_RESCALE_FACTOR(VERTICAL))/2;

% LOAD IMAGES
% create original directories and lists
og_scenario_Folder = fullfile(workingDir, 'stimuli/og_scenario');
og_scenario_dir = dir(fullfile(og_scenario_Folder));
og_scenarios = {};
for i = 4:length(og_scenario_dir)
    og_scenarios{i-3} = og_scenario_dir(i).name;
end

og_correct_Folder = fullfile(workingDir, 'stimuli/og_correct');
og_correct_dir = dir(fullfile(og_correct_Folder));
og_corrects = {};
for i = 4:length(og_correct_dir)
    og_corrects{i-3} = og_correct_dir(i).name;
end
og_inc1_Folder = fullfile(workingDir, 'stimuli/og_inc1');
og_inc1_dir = dir(fullfile(og_inc1_Folder));
og_inc1s = {};
for i = 4:length(og_inc1_dir)
    og_inc1s{i-3} = og_inc1_dir(i).name;
end
og_inc2_Folder = fullfile(workingDir, 'stimuli/og_inc2');
og_inc2_dir = dir(fullfile(og_inc2_Folder));
og_inc2s = {};
for i = 4:length(og_inc2_dir)
    og_inc2s{i-3} = og_inc2_dir(i).name;
end

% create variant directories and lists
v_scenario_Folder = fullfile(workingDir, 'stimuli/v_scenario');
v_scenario_dir = dir(fullfile(v_scenario_Folder));
v_scenarios = {};
for i = 4:length(v_scenario_dir)
    v_scenarios{i-3} = v_scenario_dir(i).name;
end
v_correct_Folder = fullfile(workingDir, 'stimuli/v_correct');
v_correct_dir = dir(fullfile(v_correct_Folder));
v_corrects = {};
for i = 4:length(v_correct_dir)
    v_corrects{i-3} = v_correct_dir(i).name;
end
v_inc1_Folder = fullfile(workingDir, 'stimuli/v_inc1');
v_inc1_dir = dir(fullfile(v_inc1_Folder));
v_inc1s = {};
for i = 4:length(v_inc1_dir)
    v_inc1s{i-3} = v_inc1_dir(i).name;
end
v_inc2_Folder = fullfile(workingDir, 'stimuli/v_inc2');
v_inc2_dir = dir(fullfile(v_inc2_Folder));
v_inc2s = {};
for i = 4:length(v_inc2_dir)
    v_inc2s{i-3} = v_inc2_dir(i).name;
end

N_og_images = length(og_scenarios);
N_v_images = length(v_scenarios);

% GETTING INPUT FROM PERSON
stim.num_realtime = 10;
stim.num_omit = 10;
stim.num_learn = 8;
stim.num_localizer = 16;
stim.num_total = stim.num_learn + stim.num_realtime + stim.num_omit + stim.num_localizer;
% % initialize joystick and trajectory variables
if joystick
    ID = 1;
    joy=vrjoystick(ID);
    ky=[];
    kx=[];
end

% SET UP PRECISE TIMING 
INSTANT = 0.001;
slack  = ifi/2;
stim.TRlength = 2;
stim.fontSize = 24;
stim.isiDuration = 2*SPEED;
stim.scenarioDuration = 6*SPEED;
stim.goDuration = 4*SPEED;
stim.feedbackDuration = 2*SPEED;
config.TR = stim.TRlength;
config.nTRs.ISI = stim.isiDuration/stim.TRlength;
config.nTRs.scenario = stim.scenarioDuration/stim.TRlength;
config.nTRs.go = stim.goDuration/stim.TRlength;
config.nTRs.feedback = stim.feedbackDuration/stim.TRlength;
