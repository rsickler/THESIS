%%% This code is for building the classifier that is based off
%%% a DIRECTED imagery session with even ratio of original:variant.
% trial: [2s --> 4s --> 4s --> 2s] -------> [2s] --> [4s --> 4s -->4s] = 26 seconds
% 1 round = 2 trials for all 12 images = 24 trials = 10.4 minutes

function classifier_imagery(SUBJECT,SUBJ_NAME,SESSION,ROUND)

class_SETUP;

% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' num2str(ROUND) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

%% SET UP SCREEN
% make vividness texture
otherFolder = fullfile(workingDir, 'stimuli/other');
vividness_matrix = double(imread(fullfile(otherFolder,'vividness.jpeg')));
vividness_texture = Screen('MakeTexture', mainWindow, vividness_matrix);
v_PICDIMS = [1024 768];
v_picRow = CENTER(2);
v_pic_size = windowSize.pixels*.75;
v_RESCALE_FACTOR = v_pic_size./v_PICDIMS;
v_topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (v_PICDIMS(HORIZONTAL)*v_RESCALE_FACTOR(HORIZONTAL))/2;
v_topLeft(VERTICAL) = v_picRow - (v_PICDIMS(VERTICAL)*v_RESCALE_FACTOR(VERTICAL))/2;

% PSEUDO-RANDOMIZE
BLOCK = {'BL', 'BM', 'BR','GL', 'GM', 'GR','OL', 'OM', 'OR','WL', 'WM', 'WR'};
block1 = shuffle(BLOCK);
block2 = shuffle(BLOCK);
round_sequence = cat(2,block1, block2);
scenario_sequence = strcat(round_sequence,'.jpg');
%make original textures in the pseudo-randomized order
for i = 1:length(scenario_sequence)
    scenario_matrix = double(imread(fullfile(class_scenario_Folder,scenario_sequence{i})));
    scenario_texture(i) = Screen('MakeTexture', mainWindow, scenario_matrix);
end

%add hitting directions
left_dir = ['LEFTMOST PERSON'];
right_dir = ['RIGHTMOST PERSON'];
middle_dir = ['MIDDLE PERSON'];

%format beep
InitializePsychSound(1);
freq = 44100;
nrchannels = 1;
beep_time = 0.25; 
snddata = MakeBeep(378, duration, freq);
pahandle = PsychPortAudio('Open', [], [], [], freq, nrchannels);
PsychPortAudio('FillBuffer', pahandle, snddata);

% set up math
num_qs = 3;
digits_promptDur = 4*SPEED; % length digits on screen
digits_isi = 0*SPEED; 

%% start screen
instruct = ['Would you like to start?' ...
    '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end
instruct = ['Loading Scanner...'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);

%% SET UP FMRI STUFF
%set fmri pulse trigger
T = '=';
KEYS = [T];
keyCell = {T};
allkeys = KEYS;
% define key names
for i = 1:length(allkeys)
    keys.code(i,:) = getKeys(allkeys(i));
    keys.map(i,:) = zeros(1,256);
    keys.map(i,keys.code(i,:)) = 1;
end
TRIGGER_keycode = keys.code;

% fixation period for 20 s
if CURRENTLY_ONLINE
    [timing.trig.wait, timing.trig.waitSuccess] = WaitTRPulse(TRIGGER_keycode,device);
    runStart = timing.trig.wait;
    displayText(mainWindow,STILLREMINDER,STILLDURATION,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
    DrawFormattedText(mainWindow,'+','center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
    Screen('Flip', mainWindow)
    stim.fixBlock = 20; %time in the beginnning they're staring--20s, 10 TRs
    config.wait = stim.fixBlock;
else
    runStart = GetSecs;
    config.wait = 0;
end

%%set precise timing
stim.isiDuration = 2*SPEED;
stim.scenarioDuration = 4*SPEED;
stim.goDuration = 4*SPEED;
stim.feedbackDuration = 2*SPEED;
stim.mathISIDuration = 2*SPEED;
stim.mathDuration = 12*SPEED;
config.TR = stim.TRlength;
config.nTRs.ISI = stim.isiDuration/stim.TRlength;
config.nTRs.scenario = stim.scenarioDuration/stim.TRlength;
config.nTRs.go = stim.goDuration/stim.TRlength;
config.nTRs.feedback = stim.feedbackDuration/stim.TRlength;
config.nTRs.mathISI = stim.mathISIDuration/stim.TRlength;
config.nTRs.math = stim.mathDuration/stim.TRlength;
config.nTrials = 24;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.go + config.nTRs.feedback + config.nTRs.mathISI + config.nTRs.math;
config.nTRs.perBlock = config.wait/config.TR + (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI

% wait indefinitely until first scan trigger
if CURRENTLY_ONLINE
    [timing.trig.wait, timing.trig.waitSuccess] = WaitTRPulse(TRIGGER_keycode,device);
end

%% PRESENT DIRECTED IMAGERY SCENARIOS
trial = 1;
vividness = {}; 

while trial <= length(scenario_sequence)
    % calculate all future onsets
    timing.plannedOnsets.preISI(trial) = runStart +config.wait;
    if trial > 1
        timing.plannedOnsets.preISI(trial) = timing.plannedOnsets.preISI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preISI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    timing.plannedOnsets.feedback(trial) = timing.plannedOnsets.go(trial) + config.nTRs.go*config.TR;
    timing.plannedOnsets.startbeep(trial) = timing.plannedOnsets.go(trial) - beep_time;
    timing.plannedOnsets.endbeep(trial) = timing.plannedOnsets.feedback(trial) - beep_time;
    timing.plannedOnsets.mathISI(trial) = timing.plannedOnsets.feedback(trial) + config.nTRs.feedback*config.TR;
    timing.plannedOnsets.math(trial) = timing.plannedOnsets.mathISI(trial) + config.nTRs.mathISI*config.TR;
    % throw up the images
    % pre ISI
    if CURRENTLY_ONLINE
        [timing.trig.preISI(trial), timing.trig.preISI_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.preISI(trial));
    end
    timespec = timing.plannedOnsets.preISI(trial)-slack;
    timing.actualOnsets.preISI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.preISI(trial) - timing.plannedOnsets.preISI(trial));
    % scenario + directions
    this_pic = scenario_sequence{trial};
    if this_pic(2) == 'L' %left
        directions = left_dir;
    elseif this_pic(2) == 'M' % middle
        directions = middle_dir;
    else %right
        directions = right_dir;
    end
    if CURRENTLY_ONLINE
        [timing.trig.scenario(trial), timing.trig.scenario_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.scenario(trial));
    end
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    DrawFormattedText(mainWindow,directions,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
    Screen('DrawTexture', mainWindow, scenario_texture(trial), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
    timing.actualOnsets.scenario(trial) = Screen('Flip',mainWindow,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.preISI(trial) - timing.plannedOnsets.preISI(trial));
    % go
    %beep begin
    timespec = timing.plannedOnsets.startbeep(trial);
    basic_tone(timespec,beep_time, pahandle);
    %flip screen
    if CURRENTLY_ONLINE
        [timing.trig.go(trial), timing.trig.go_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.go(trial));
    end
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'+','center',COLORS.BGCOLOR,WRAPCHARS,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.go(trial) - timing.plannedOnsets.go(trial));
    %beep end
    timespec = timing.plannedOnsets.endbeep(trial);
    basic_tone(timespec,beep_time, pahandle);
    %feedback
    if CURRENTLY_ONLINE
        [timing.trig.feedback(trial), timing.trig.feedback_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.feedback(trial));
    end
    timespec = timing.plannedOnsets.feedback(trial)-slack;
    Screen('DrawTexture', mainWindow, vividness_texture,[0 0 v_PICDIMS],[v_topLeft v_topLeft+v_PICDIMS.*v_RESCALE_FACTOR]);
    timing.actualOnsets.feedback(trial) = Screen('Flip',mainWindow,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.feedback(trial) - timing.plannedOnsets.feedback(trial));
    %record vividness input
    tEnd=GetSecs+stim.feedbackDuration;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
    end
    %record imagery rating
    if (x>=-.75)&&(x<=.75) && (y>=.75); %DOWN FOR NOT VIVID AT ALL
        vividness{trial} = 'NOT VIVID AT ALL';
    elseif (x<=-.75) && (y>=-.75)&&(y<=.75); %LEFT FOR SOMEWHAT VIVID
        vividness{trial} = 'SOMEWHAT VIVID';
    elseif (x>=-.75)&&(x<=.75) && (y>=.75) % UP FOR FAIRLY VIVID
        vividness{trial} = 'FAIRLY VIVID';
    elseif (x>=.75) && (y>=-.75)&&(y<=.75) % RIGHT FOR VERY VIVID
        vividness{trial} = 'VERY VIVID';
    else
        vividness{trial} = 'UNCLEAR'; % RIGHT FOR VERY VIVID
    end    
    % pre-math ISI
    if CURRENTLY_ONLINE
        [timing.trig.mathISI(trial), timing.trig.mathISI_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.mathISI(trial));
    end
    timespec = timing.plannedOnsets.mathISI(trial)-slack;
    timing.actualOnsets.mathISI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.mathISI(trial) - timing.plannedOnsets.mathISI(trial));
    % DO MATH- 1 round of 3 problems
    if CURRENTLY_ONLINE
        [timing.trig.math(trial), timing.trig.math_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.math(trial));
    end
    timespec = timing.plannedOnsets.math(trial)-slack;
    [digitAcc(trial), timing.actualOnsets.math(trial)] ...
        = odd_even_joy(num_qs,digits_promptDur,digits_isi,mainWindow,stim.textRow, ...
        COLORS,device,slack,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.math(trial)-timing.plannedOnsets.math(trial));
    %update trial
    trial= trial+1;
end
% throw up a final isi
timing.plannedOnsets.lastISI = timing.plannedOnsets.math(end) + config.nTRs.math*config.TR;
timespec = timing.plannedOnsets.lastISI-slack;
timing.actualOnset.finalISI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(10); 

%%
% FINALIZE DATA / CLOSE UP SHOP
PsychPortAudio('Close', pahandle);

% save final variables
save([ppt_dir matlabSaveFile], 'stim', 'timing', 'scenario_sequence','digitAcc');

%present closing screen
if ROUND == 2
    instruct = ['all done! hurray!'];
else
    instruct = ['That completes the current round! You may now take a brief break before the next round. Move "right" when you are ready to continue.' ...
    '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end

end