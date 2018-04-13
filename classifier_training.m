%%% This code is for building the classifier that is based off
%%% DIRECTED real training on the scenarios, with even ratio of original:variant.
% trial: 2s --> 4s --> 4s --> 2s -------> [2s --> 4s --> 4s -->4s] = 26 seconds
% 1 round = 2 trials for all 12 images = 24 trials = 10.4 minutes
% 624 seconds + 20 second strat delay + 10 second shut down = 654 sec = 327 TR

function classifier_training(SUBJECT,SUBJ_NAME,SESSION,ROUND)

% STARTING EXPERIMENT
class_SETUP;
% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' num2str(ROUND) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
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

%% start screen
instruct = ['Would you like to start?' ...
    '\n\n\n\n -- move the joystick RIGHT to begin --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end
instruct = ['Loading Scanner...'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);

%% set up math
num_qs = 3;
digits_promptDur = 4*SPEED; % length digits on screen
digits_isi = 0*SPEED; 

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

%% BEGIN PRESENTATION!
% initialize variables
train_responses = {};
trial = 1;

while trial <= length(scenario_sequence)
    % calculate all future onsets
    timing.plannedOnsets.preISI(trial) = runStart +config.wait;
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
    %record trajectory
    tEnd=GetSecs+stim.goDuration;
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
        correct_movement = (x<=-.6); %hit left
    elseif this_pic(2) == 'M' %if middle
        correct_movement = (y<=-.5) && (x>=-.6)&&(x<=.6); %hit straight
    else %if right
        correct_movement = (x>=.6); %hit right
    end
    %feedback
    if CURRENTLY_ONLINE
        [timing.trig.feedback(trial), timing.trig.feedback_Success(trial)] = WaitTRPulse(TRIGGER_keycode,device,timing.plannedOnsets.feedback(trial));
    end
    timespec = timing.plannedOnsets.feedback(trial)-slack;
    if correct_movement
        train_responses{trial} = 'correct';
        DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
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
    timespec = timing.plannedOnsets.math(trial)-slack;
    [digitAcc(trial), timing.actualOnsets.math(trial)] ...
        = odd_even_joy(num_qs,digits_promptDur,digits_isi,mainWindow,stim.textRow, ...
        COLORS,device,slack,timespec);
    fprintf('Flip time error = %.4f\n', timing.actualOnsets.math(trial)-timing.plannedOnsets.math(trial));
    %update trial
    trial= trial+1;
end
% throw up a final ISI
timing.plannedOnsets.lastISI = timing.plannedOnsets.math(end) + config.nTRs.math*config.TR;
timespec = timing.plannedOnsets.lastISI-slack;
timing.actualOnset.finalISI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(10); 

%% FINALIZE DATA / CLOSE UP SHOP

%check accuracy
corrects = 0;
for i = 1:length(scenario_sequence)
    if strcmp(train_responses{i},'correct')
        corrects = corrects+1;
    end
end
class_ratio = corrects / length(scenario_sequence);

%save important variables
save([ppt_dir matlabSaveFile],'SUBJ_NAME','stim','timing','config','round_sequence','X','Y',...
    'train_responses','digitAcc','class_ratio');

%present closing screen
instruct = ['That completes the current round! You may now take a brief break before the next round.'...
    '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end


end
