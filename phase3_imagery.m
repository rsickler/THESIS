%%% This code is for the phase 3 DIRECTED visualization session,
%%% with even ratio of original:variant and feedback given.
% 2s --> 3s --> 3s --> 4s --> 2s

function phase3_imagery(SUBJECT,SUBJ_NAME,SESSION)

SETUP; 
instruct = 'Loading Phase 3...';
displayText(mainWindow, instruct, INSTANT, 'center',COLORS.MAINFONTCOLOR, WRAPCHARS);

% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

% this sets up the structure
subj_triggerNext = false; 
subj_promptDur = 2; 
subj_listenDur = 0;

% PSEUDORANDOMIZE SCENARIOS
%pseudorandomize all originals and variants in blocks of 4, using all 16
% images once each
all_scenarios =  cat(2,og_scenarios, v_scenarios);
used = zeros(1,length(all_scenarios));
scenario_sequence = [];
nQuads = 4;     % this number * 4 = total # trials
for T = 1:nQuads
    ORDER = randperm(4);
    for i = 1:4
        sitch = ORDER(i);
        TRIAL = (T-1)*4 + i;
        start = (sitch-1)*4 + 1;
        index = start + randi(4) -1;
        found = 0;
        while ~found
            if ~used(index)
                scenario_sequence{TRIAL} = all_scenarios{index};
                found = 1;
                used(index) = 1;
            else
                index = start + randi(4) -1;
                if all(used)
                    used = zeros(1,length(all_scenarios));
                end
            end
        end
    end
end
N_images = length(scenario_sequence);
%make stim map
stim_map = makeMap(scenario_sequence);
cond_map = makeMap({'even', 'odd'});

%make textures in the pseudo-randomized order
for i = 1:N_images
    current = scenario_sequence{i};
    if current(3) == 'O'
        scenario_Folder = og_scenario_Folder;
    else
        scenario_Folder = v_scenario_Folder;
    end
    scenario_matrix = double(imread(fullfile(scenario_Folder,scenario_sequence{i})));
    scenario_texture(i) = Screen('MakeTexture', mainWindow, scenario_matrix);
end
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

%set button presses to for feedback
THUMB = 'z';
INDEXFINGER='e';
MIDDLEFINGER='r';
RINGFINGER='t';
PINKYFINGER='y';
KEYS = [THUMB INDEXFINGER MIDDLEFINGER RINGFINGER PINKYFINGER];
keyCell = {THUMB, INDEXFINGER, MIDDLEFINGER, RINGFINGER, PINKYFINGER};
cresp = keyCell(3:5); 
subj_keys = keyCell;
allkeys = KEYS;
% define key names
for i = 1:length(allkeys)
    keys.code(i,:) = getKeys(allkeys(i));
    keys.map(i,:) = zeros(1,256);
    keys.map(i,keys.code(i,:)) = 1;
end
subj_keycode = keys.code(1:5,:);
cresp_map = sum(keys.map(3:5,:)); 
subj_map = sum(keys.map(1:5,:)); 
subj_scale = makeMap({'no image', 'generic', '1 detail', '2+ details', 'full'}, 1:5, subj_keys);



% GIVE INTRO
%explanation of task 
instruct = ['you will be performing mental imagery of...'...
    'imagine yourself in the described scenario performing the given motion...'...
    'as vividly as you can?.think of side of court, faces of opponent,' ...
    'bla bla bla' ...
    '\n\n-- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
press1 = waitForKeyboard(trigger,device);

%explain visualization rating
instruct = ['you will see this image...'];
cont = ['-- press "space" to continue --'];
intro_textRow = windowSize.pixels(2) *(.05);
intro_picRow = windowSize.pixels(2) *(.65);
cont_textRow = windowSize.pixels(2) *(.93); 
Screen('DrawTexture', mainWindow, vividness_texture,[0 0 v_PICDIMS],[v_topLeft v_topLeft+v_PICDIMS.*v_RESCALE_FACTOR]);
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
press2 = waitForKeyboard(trigger,device);

%prompt for beginning
instruct = ['Would you like to start?' ...
    '\n\n-- press "space" to begin --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
press3 = waitForKeyboard(trigger,device);

% SET UP PRECISE TIMING 
stim.isiDuration = 2*SPEED;
stim.scenarioDuration = 3*SPEED;
stim.imagineDuration = 3*SPEED;
stim.goDuration = 4*SPEED;
stim.vividnessDuration = 2*SPEED;
beep_time = 0.25; 

config.nTRs.ISI = stim.isiDuration/stim.TRlength;
config.nTRs.scenario = stim.scenarioDuration/stim.TRlength;
config.nTRs.imagine = stim.imagineDuration/stim.TRlength;
config.nTRs.go = stim.goDuration/stim.TRlength;
config.nTRs.vividness = stim.vividnessDuration/stim.TRlength;
config.nTrials = N_images;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.imagine + config.nTRs.go + config.nTRs.vividness;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI
runStart = GetSecs;

% initialize structure
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

%PRESENT DIRECTED TRIALS
trial = 1;
while trial <= N_images
    % calculate all future onsets
    timing.plannedOnsets.preITI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.preITI(trial) = timing.plannedOnsets.preITI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preITI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.imagine(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.imagine(trial) + config.nTRs.imagine*config.TR;
    timing.plannedOnsets.vividness(trial) = timing.plannedOnsets.go(trial) + config.nTRs.go*config.TR;
    timing.plannedOnsets.beep(trial) = timing.plannedOnsets.vividness(trial) - beep_time;
    % throw up the images
    % pre ITI
    timespec = timing.plannedOnsets.preITI(trial)-slack;
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % scenario
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    Screen('DrawTexture', mainWindow, scenario_texture(trial), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
    timing.actualOnsets.scenario(trial) = Screen('Flip',mainWindow,timespec);
    % imagine
    timespec = timing.plannedOnsets.imagine(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
        % imagine audio
    
    
    % go
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % find out which audio to play
    this_pic = scenario_sequence{trial};
    if this_pic(1) == 'A'
        if this_pic(3) == 'O' % if original
            correct_movement = 1;   %full diagnal line
        else % if variant
            correct_movement = 2; %full diagnal cross
        end
    else %else in B
        if this_pic(3) == 'O' % if original
            correct_movement = 3; %shwype
        else % if variant
            correct_movement = 4; %tip ahead
        end
    end
    % beep 
    timespec = timing.plannedOnsets.beep(trial);
    duration = beep_time;
    basic_tone(timespec,duration);
    % vividness
    timespec = timing.plannedOnsets.vividness(trial)-slack;
    Screen('DrawTexture', mainWindow, vividness_texture,[0 0 v_PICDIMS],[v_topLeft v_topLeft+v_PICDIMS.*v_RESCALE_FACTOR]);
    timing.actualOnsets.vividness(trial) = Screen('Flip',mainWindow,timespec);
    subjectiveEK = easyKeysTREY(subjectiveEK, ...
        'onset', timing.actualOnsets.vividness(trial), ...
        'stim', scenario_sequence(trial), ...
        'cresp', cresp, ...
        'cond', 1, ...
        'cresp_map', cresp_map,...
        'valid_map', subj_map); 
    
        %update trial
    trial= trial+1;
end
% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.vividness(end) + config.nTRs.vividness*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(2);

%close some loose ends
PsychPortAudio('Close', pahandle);
endSession(subjectiveEK);

% SAVE SUBJECT DATA 
total_trials = trial - 1; 
P3_order = scenario_sequence;
save([ppt_dir matlabSaveFile], 'SUBJ_NAME', 'stim', 'timing', 'total_trials',...
    'P3_order');  

%present closing screen
instruct = ['That completes the third phase! You may now take a brief break before phase four. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end
