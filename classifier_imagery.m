%%% This code is for building the classifier that is based off 
%%% a DIRECTED imagery session with even ratio of original:variant.
% trial: [2s --> 4s --> 4s --> 2s] -------> [2s] --> [4s --> 4s -->4s] = 26 seconds 
% 1 round = 2 trials for all 12 images = 24 trials = 10.4 minutes

%%% [timing.trig.wait timing.trig.waitSuccess] = WaitTRPulse(TRIGGER_keycode,DEVICE);
%%% [timing.trig.preITI(n), timing.trig.preITI_Success(n)] = WaitTRPulse(TRIGGER_keycode,DEVICE,timing.plannedOnsets.preITI(n));
% if fmri TRIGGER_keycode = keys.code(6,:); end

function classifier_imagery(SUBJECT,SUBJ_NAME,SESSION,ROUND)

class_SETUP; 
% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

% make vividness texture
otherFolder = fullfile(workingDir, 'stimuli/other');
vividness_matrix = double(imread(fullfile(otherFolder,'vividness.jpg')));
vividness_texture = Screen('MakeTexture', mainWindow, vividness_matrix);
v_PICDIMS = [750 558];
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

%CREATE STRUCTURES
%set button presses for feedback
ONE = '1';
TWO = '2';
THREE = '3';
FOUR = '4';
FIVE = '5';
KEYS = [ONE TWO THREE FOUR FIVE];
keyCell = {ONE, TWO THREE FOUR FIVE};
allkeys = KEYS;
% define key names
for i = 1:length(allkeys)
    keys.code(i,:) = getKeys(allkeys(i));
    keys.map(i,:) = zeros(1,256);
    keys.map(i,keys.code(i,:)) = 1;
end
%make maps
digits_map = sum(keys.map([1:2],:)); 
digits_keys = keyCell;
digits_scale = makeMap({'even','odd'},[0 1],keyCell([1 2]));
cond_map = makeMap({'even', 'odd'});

subj_map = sum(keys.map(1:5,:)); 
subj_keys = keyCell;
subj_scale = makeMap({'no image', 'generic', '1 detail', '2+ details', 'full'}, 1:5, subj_keys);
subj_cresp_map = sum(keys.map(3:5,:)); 
stim_names = strcat(BLOCK,'.jpg');
stim_map = makeMap(stim_names);

% this sets up the vividness feedback structure
subj_cresp = keyCell(3:5); 
subj_triggerNext = false; 
subj_promptDur = 2*SPEED; 
subj_listenDur = 0;

% this sets up the odd even task structure
digits_cresp = keyCell(1:2); 
digits_triggerNext = false; 
digits_promptDur = 4*SPEED; % length digits on screen
digits_isi = 0*SPEED; % length ISI
digits_listenDur = 0;

% initialize vividness structure
runStart = GetSecs;
subjectiveEK = initEasyKeys(['phase3_imagery' '_SUB'], SUBJ_NAME,ppt_dir, ...
    'default_respmap', subj_scale, ...
    'stimmap', stim_map, ...
    'condmap', cond_map, ...
    'trigger_next', subj_triggerNext, ...
    'prompt_dur', subj_promptDur, ...
    'listen_dur', subj_listenDur, ...
    'exp_onset', runStart, ...
    'console', false, ...
    'device', -1);
subjectiveEK = startSession(subjectiveEK); 

% initialize odd/even structure
digitsEK = initEasyKeys(['phase3_distractor' '_SUB'], SUBJ_NAME,ppt_dir, ...
    'default_respmap', digits_scale, ...
    'condmap', cond_map, ...
    'trigger_next', digits_triggerNext, ...
    'prompt_dur', digits_promptDur, ...
    'listen_dur', digits_listenDur, ...
    'exp_onset', runStart, ...
    'console', false, ...
    'device', -1);
digitsEK = startSession(digitsEK); 

%add hitting directions
left_dir = ['LEFTMOST PERSON'];
right_dir = ['RIGHTMOST PERSON'];
middle_dir = ['MIDDLE PERSON'];

%format beep 
beep_time = 0.25; 

%PRESENT DIRECTED IMAGERY SCENARIOS
instruct = ['Would you like to start?' ...
    '\n\n-- press "space" to begin --'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
stim.StartTime = waitForKeyboard(trigger,device);
runStart = GetSecs;
trial = 1;
while trial <= length(scenario_sequence)
    % calculate all future onsets
    timing.plannedOnsets.preITI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.preITI(trial) = timing.plannedOnsets.preITI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preITI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    timing.plannedOnsets.feedback(trial) = timing.plannedOnsets.go(trial) + config.nTRs.go*config.TR;
    timing.plannedOnsets.startbeep(trial) = timing.plannedOnsets.go(trial) - beep_time;
    timing.plannedOnsets.endbeep(trial) = timing.plannedOnsets.feedback(trial) - beep_time;
    timing.plannedOnsets.mathISI(trial) = timing.plannedOnsets.feedback(trial) + config.nTRs.feedback*config.TR;
    timing.plannedOnsets.math(trial) = timing.plannedOnsets.mathISI(trial) + config.nTRs.mathISI*config.TR;
    % throw up the images
    % pre ITI
    timespec = timing.plannedOnsets.preITI(trial)-slack;
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % scenario + directions
    this_pic = scenario_sequence{trial};
    if this_pic(2) == 'L' %left 
        directions = left_dir;
    elseif this_pic(2) == 'M' % middle
        directions = middle_dir; 
    else %right
        directions = right_dir; 
    end
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    DrawFormattedText(mainWindow,directions,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
    Screen('DrawTexture', mainWindow, scenario_texture(trial), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
    timing.actualOnsets.scenario(trial) = Screen('Flip',mainWindow,timespec);
    % go
    %beep begin
    timespec = timing.plannedOnsets.startbeep(trial);
    duration = beep_time;
    basic_tone(timespec,duration);
    %flip screen
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'+','center',COLORS.BGCOLOR,WRAPCHARS,timespec);
    %beep end
    timespec = timing.plannedOnsets.endbeep(trial);
    duration = beep_time;
    basic_tone(timespec,duration);
    %feedback
    timespec = timing.plannedOnsets.feedback(trial)-slack;
    Screen('DrawTexture', mainWindow, vividness_texture,[0 0 v_PICDIMS],[v_topLeft v_topLeft+v_PICDIMS.*v_RESCALE_FACTOR]);
    timing.actualOnsets.feedback(trial) = Screen('Flip',mainWindow,timespec);
    %record vividness input
    subjectiveEK = easyKeysTREY(subjectiveEK, ...
        'onset', timing.actualOnsets.feedback(trial), ...
        'stim', scenario_sequence(trial), ...
        'cresp', subj_cresp, ...
        'cond', 1, ...
        'cresp_map', subj_cresp_map,...
        'valid_map', subj_map);   
    % pre-math ISI
    timespec = timing.plannedOnsets.mathISI(trial)-slack;
    timing.actualOnsets.mathITI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % DO MATH- 1 round of 3 problems
    num_rounds = 5;
    num_qs = 3;
    timespec = timing.plannedOnsets.math(trial)-slack;
    [digitAcc(trial), digitRT(trial), actualOnsets(trial)] ...
        = odd_even(digitsEK,num_qs,digits_promptDur,digits_isi,mainWindow, ...
        keyCell([1 2]),COLORS,device,SUBJ_NAME,[SESSION trial],slack,timespec, keys);
    %update trial
    trial= trial+1;
end
% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.feedback(end) + config.nTRs.vividness*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(2);

% FINALIZE DATA / CLOSE UP SHOP
% close the structure
endSession(digitsEK);
endSession(subjectiveEK);

% save final variables
save([ppt_dir matlabSaveFile], 'stim', 'timing', 'scenario_sequence','digitAcc','digitRT','actualOnsets');  

%present closing screen
if ROUND == 2
    instruct = ['all done! hurray!'];
else
    instruct = ['That completes the current round! You may now take a brief break before the next round. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "space" to continue --'];
end
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end
