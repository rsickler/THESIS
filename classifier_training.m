%%% This code is for building the classifier that is based off
%%% DIRECTED real training on the scenarios, with even ratio of original:variant.
% trial: 2s --> 4s --> 4s --> 2s -------> [2s --> 4s --> 4s -->4s] = 26 seconds
% 1 round = 2 trials for all 12 images = 24 trials = 10.4 minutes

function classifier_training(SUBJECT,SUBJ_NAME,SESSION,ROUND)

% STARTING EXPERIMENT
class_SETUP;
% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end
%% SET UP SCREEN
% PSEUDO-RANDOMIZE
BLOCK = {'BL', 'BM', 'BR','GL', 'GM', 'GR','OL', 'OM', 'OR','WL', 'WM', 'WR'};
block1 = shuffle(BLOCK);
block2 = shuffle(BLOCK);
round_sequence = cat(2,block1, block2);
scenario_sequence = strcat(round_sequence,'.jpg');
feedback_sequence = scenario_sequence;
%make original textures in the pseudo-randomized order
for i = 1:length(scenario_sequence)
    scenario_matrix = double(imread(fullfile(class_scenario_Folder,scenario_sequence{i})));
    scenario_texture(i) = Screen('MakeTexture', mainWindow, scenario_matrix);
    feedback_matrix = double(imread(fullfile(class_feedback_Folder,feedback_sequence{i})));
    feedback_texture(i) = Screen('MakeTexture', mainWindow, feedback_matrix);
end
% make incorrect response texture
classFolder = fullfile(workingDir, 'stimuli/CLASSIFIER');
incorrect_matrix = double(imread(fullfile(classFolder,'class_incorrect.jpeg')));
incorrect_texture = Screen('MakeTexture', mainWindow, incorrect_matrix);
%add hitting directions
left_dir = ['LEFTMOST PERSON'];
right_dir = ['RIGHTMOST PERSON'];
middle_dir = ['MIDDLE PERSON'];

%% CREATE STRUCTURES
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
% this sets up the odd/even task structure
digits_cresp = keyCell(1:2);
digits_triggerNext = false;
digits_promptDur = 4*SPEED; % length digits on screen
digits_isi = 0*SPEED; % length ISI
digits_listenDur = 0;
% initialize vividness structure
runStart = GetSecs;
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

%% SET UP FMRI STUFF
if fmri
    TRIGGER_keycode = keys.code(5,:);
end

% fixation period for 20 s
if CURRENTLY_ONLINE && ROUND <=1
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
    [timing.trig.wait timing.trig.waitSuccess] = WaitTRPulse(TRIGGER_keycode,DEVICE);
end

%% BEGIN PRESENTATION!
% create structure for storing joystick responses
train_responses = {};
% give instructions, wait to begin
instruct = ['Would you like to start?' ...
    '\n\n-- press "space" to begin --'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
stim.p3StartTime = waitForKeyboard(trigger,device);
runStart = GetSecs;
trial = 1;
while trial <= length(scenario_sequence)
    % calculate all future onsets
    timing.plannedOnsets.preISI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.preISI(trial) = timing.plannedOnsets.preISI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preISI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    timing.plannedOnsets.feedback(trial) = timing.plannedOnsets.go(trial) + config.nTRs.go*config.TR;
    timing.plannedOnsets.mathISI(trial) = timing.plannedOnsets.feedback(trial) + config.nTRs.feedback*config.TR;
    timing.plannedOnsets.math(trial) = timing.plannedOnsets.mathISI(trial) + config.nTRs.mathISI*config.TR;
    if CURRENTLY_ONLINE
        [timing.trig.preISI(trial), timing.trig.preISI_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.preISI(trial));
    end
    % throw up the images
    % pre ISI
    timespec = timing.plannedOnsets.preISI(trial)-slack;
    timing.actualOnsets.preISI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.preISI(trial) - timing.plannedOnsets.preISI(trial));
    % scenario + direction
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
    if CURRENTLY_ONLINE
        [timing.trig.go(trial), timing.trig.go_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.go(trial));
    end
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'GO!','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.go(trial) - timing.plannedOnsets.go(trial));
    %feedback
    %record trajectory
    tEnd=GetSecs+4;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        ky(end+1)=y;
        kx(end+1)=x;
        pause(.05)
    end
    X(trial) = x;
    Y(trial) = y;
    %make sure did correct movement
    this_pic = scenario_sequence{trial};
    if this_pic(2) == 'L' %if left
        correct_movement = (x<=-.75) && (y<=0.1); %hit left
    elseif this_pic(2) == 'M' %if middle
        correct_movement = (y<=0.1) && (x>=-.75)&&(x<=.75); %hit straight
    else %if right
        correct_movement = (x>=.75) && (y<=0.1); %hit right
    end
    %draw feedback
    if CURRENTLY_ONLINE
        [timing.trig.feedback(trial), timing.trig.feedback_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.feedback(trial));
    end
    timespec = timing.plannedOnsets.feedback(trial)-slack;
    if correct_movement
        train_responses{trial} = 'correct';
        Screen('DrawTexture', mainWindow, feedback_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
    else
        train_responses{trial} = 'incorrect';
        DrawFormattedText(mainWindow,'IMPROPER RESPONSE- MAKE SURE TO FOLLOW THE GIVEN DIRECTIONS!','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,incorrect_texture,[0 0 INC_PICDIMS],[INC_topLeft INC_topLeft+INC_PICDIMS.*INC_RESCALE_FACTOR]);
    end
    timing.actualOnsets.feedback(trial) = Screen('Flip',mainWindow,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.feedback(trial) - timing.plannedOnsets.feedback(trial));
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
    num_rounds = 5;
    num_qs = 3;
    timespec = timing.plannedOnsets.math(trial)-slack;
    [digitAcc(trial), digitRT(trial), timing.actualOnsets.math(trial)] ...
        = odd_even(digitsEK,num_qs,digits_promptDur,digits_isi,mainWindow, ...
        keyCell([1 2]),COLORS,device,SUBJ_NAME,[SESSION trial],slack,INSTANT, keys);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.math(trial)-timing.plannedOnsets.math(trial));
    
    %update trial
    trial= trial+1;
end
% throw up a final ISI
timing.plannedOnsets.lastISI = timing.plannedOnsets.math(end) + config.nTRs.math*config.TR;
timespec = timing.plannedOnsets.lastISI-slack;
timing.actualOnset.finalISI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(2);

%% FINALIZE DATA / CLOSE UP SHOP
% close the structure
endSession(digitsEK);

%check accuracy
corrects = 0;
for i = 1:length(scenario_sequence)
    if strcmp(train_responses{trial},'correct')
        corrects = corrects+1;
    end
end
class_ratio = corrects / length(scenario_sequence);

%save important variables
save([ppt_dir matlabSaveFile],'SUBJ_NAME','stim', 'timing','scenario_sequence','X', 'Y',...
    'train_responses','digitAcc','digitRT','actualOnsets','class','Btrials','class_ratio');

%present closing screen
instruct = ['That completes the current round! You may now take a brief break before the next round. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end
