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

% **KEY PRESS FOR ODD EVEN TASK? OR USE JOYSTICK? 



%add hitting directions
left_dir = ['LEFTMOST PERSON'];
right_dir = ['RIGHTMOST PERSON'];
middle_dir = ['MIDDLE PERSON'];

%BEGIN PRESENTATION!
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
    timing.plannedOnsets.preITI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.preITI(trial) = timing.plannedOnsets.preITI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preITI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    timing.plannedOnsets.feedback(trial) = timing.plannedOnsets.go(trial) + config.nTRs.go*config.TR;
    timing.plannedOnsets.mathISI(trial) = timing.plannedOnsets.feedback(trial) + config.nTRs.feedback*config.TR;
    timing.plannedOnsets.math(trial) = timing.plannedOnsets.mathISI(trial) + config.nTRs.mathISI*config.TR;
    % throw up the images
    % pre ITI
    timespec = timing.plannedOnsets.preITI(trial)-slack;
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % scenario + direction
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
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'GO!','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    %feedback
    timespec = timing.plannedOnsets.feedback(trial)-slack;
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
    % pre-math ISI
    timespec = timing.plannedOnsets.mathISI(trial)-slack;
    timing.actualOnsets.mathITI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % DO MATH- 1 round of 3 problems
    num_rounds = 5;
    num_qs = 3;
    [digitAcc(trial), digitRT(trial), actualOnsets(trial)] ...
        = odd_even(digitsEK,num_qs,digits_promptDur,digits_isi,mainWindow, ...
        keyCell([1 2]),COLORS,device,SUBJ_NAME,[SESSION trial],slack,INSTANT, keys);
    %update trial
    trial= trial+1;
end
% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.feedback(end) + config.nTRs.feedback*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(2);

% FINALIZE DATA / CLOSE UP SHOP
% close the structure????


%check accuracy 
corrects = 0; 
for i = 1:length(scenario_sequence)
    if train_responses{trial} == 'correct'
        corrects = corrects+1; 
    end
end
class_ratio = corrects / length(scenario_sequence); 

%save important variables
save([ppt_dir matlabSaveFile],'SUBJ_NAME','stim', 'timing','scenario_sequence','X', 'Y',...
    'train_responses','digitAcc','digitRT','actualOnsets','class','Btrials','class_ratio');  

instruct = ['That completes the current round! You may now take a brief break before the next round. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end
