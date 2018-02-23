%%% This code is for building the classifier that is based off 
%%% a DIRECTED imagery session with even ratio of original:variant.
% trial: 2s --> 4s --> 4s --> 2s -------> [2s --> 4s --> 4s -->4s] = 26 seconds 
% 1 round = 2 trials for all 8 images = 16 trials = 6.9 minutes

function classifier_imagery(SUBJECT,SUBJ_NAME,SESSION,ROUND)

SETUP; 
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
all_A = [1:class_scenarios];
scenario_sequence = [];
feedback_sequence = [];
new_scenario_bundle = cell(1,N_og_images);
new_feedback_bundle = cell(1,N_og_images);
times_through = 2;
for j = 1:times_through
    used = zeros(1,N_og_images);
    for T = 1:ROUNDS
        ABorder = randperm(2);
        for i = 1:2
            sitch = ABorder(i);  
            TRIAL = (T-1)*2 + i;
            start = (sitch-1)*4 + 1;
            index = start + randi(4) -1;
            found = 0;
            while ~found
                if ~used(index)
                    new_scenario_bundle{TRIAL} = og_scenarios{index};
                    new_correct_bundle{TRIAL} = og_corrects{index};
                    new_inc1_bundle{TRIAL} = og_inc1s{index};
                    new_inc2_bundle{TRIAL} = og_inc2s{index};
                    %update status
                    found = 1;
                    used(index) = 1;
                else
                    index = start + randi(4) -1;
                end
            end
        end
    end
    scenario_sequence = cat(2,scenario_sequence, new_scenario_bundle);
    feedback_sequence = cat(2,feedback_sequence,new_correct_bundle);
    inc1_sequence = cat(2,inc1_sequence, new_inc1_bundle);
    inc2_sequence = cat(2,inc2_sequence, new_inc2_bundle);
end





%set button presses to for feedback
ONE = '1';
TWO = '2';
THREE = '3';
FOUR = '4';
FIVE = '5';
KEYS = [ONE TWO THREE FOUR FIVE];
keyCell = {ONE, TWO THREE FOUR FIVE};
cresp = keyCell(1:5); 
digits_keys = keyCell;
allkeys = KEYS;
% define key names
for i = 1:length(allkeys)
    keys.code(i,:) = getKeys(allkeys(i));
    keys.map(i,:) = zeros(1,256);
    keys.map(i,keys.code(i,:)) = 1;
end
%make maps
digits_map = sum(keys.map([1:2],:)); 
digits_scale = makeMap({'even','odd'},[0 1],keyCell([1 2]));
cond_map = makeMap({'even', 'odd'});


% initialize structure
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


%PRESENT DIRECTED IMAGERY SCENARIOS
runStart = GetSecs;
trial = 1;
while trial <= trial_count
    % calculate all future onsets
    timing.plannedOnsets.preITI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.preITI(trial) = timing.plannedOnsets.preITI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preITI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    timing.plannedOnsets.vividness(trial) = timing.plannedOnsets.go(trial) + config.nTRs.go*config.TR;
    % throw up the images
    % pre ITI
    timespec = timing.plannedOnsets.preITI(trial)-slack;
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % scenario
    this_pic = scenario_sequence{trial};
    if this_pic(1) == 'A'
        if this_pic(2) == 'O'
            instruct = 'SINGLE BLOCKER \n\n WHITE TEAM \n\n HIT LINE';
        else
            instruct = 'SINGLE BLOCKER \n\n BLACK TEAM \n\n HIT CROSS';
        end
    else % IF B
        if this_pic(2) == 'O'
            instruct = 'DOUBLE BLOCKER \n\n ORANGE TEAM \n\n TOOL OFF BLOCK';
        else
            instruct = 'DOUBLE BLOCKER \n\n GREY TEAM \n\n TIP OVER BLOCK';
        end
    end
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    timing.actualOnsets.scenario(trial) = start_time_func(mainWindow,instruct,'center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % go
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    %vividness
    timespec = timing.plannedOnsets.vividness(trial)-slack;
    Screen('DrawTexture', mainWindow, vividness_texture,[0 0 v_PICDIMS],[v_topLeft v_topLeft+v_PICDIMS.*v_RESCALE_FACTOR]);
    timing.actualOnsets.vividness(trial) = Screen('Flip',mainWindow,timespec);
    %record vividness input

    
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

% save final variables
save([ppt_dir matlabSaveFile], 'stim', 'timing', 'digitAcc','digitRT','actualOnsets');  

%present closing screen
if round == 3
    instruct = ['all done! hurray!'];
else
    instruct = ['That completes the third phase! You may now take a brief break before phase four. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "space" to continue --'];
end
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(2);

end
