SETUP; 
% make vividness texture
otherFolder = fullfile(workingDir, 'stimuli/other');
vividness_matrix = double(imread(fullfile(otherFolder,'vividness.jpg')));
vividness_texture = Screen('MakeTexture', mainWindow, vividness_matrix);
%set display conditions
v_PICDIMS = [750 558];
v_picRow = CENTER(2);
v_pic_size = windowSize.pixels*.75;
v_RESCALE_FACTOR = v_pic_size./v_PICDIMS;
v_topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (v_PICDIMS(HORIZONTAL)*v_RESCALE_FACTOR(HORIZONTAL))/2;
v_topLeft(VERTICAL) = v_picRow - (v_PICDIMS(VERTICAL)*v_RESCALE_FACTOR(VERTICAL))/2;
scenario_textRow = windowSize.pixels(2) *(.4);
color_textRow = windowSize.pixels(2) *(.6);
%set button presses to for feedback
UNO = '1'; 
DOS= '2';
TRES = '3';
CUATRO = '4';
CINCO = '5';
fingers = [UNO, DOS TRES CUATRO CINCO];
keyCell = [UNO, DOS TRES CUATRO CINCO];
allkeys = fingers;

% this records the subject's response at every trial



%randomize scenario presentation
scenarios = {'AO', 'AV', 'BO', 'BV'};
block_size = length(scenarios);
used = zeros(1,block_size);
scenario_sequence = [];
nDoubles = 5;
for T = 1:nDoubles
    ABorder = randperm(2);
    for i = 1:2
        sitch = ABorder(i);  
        TRIAL = (T-1)*2 + i;
        start = (sitch-1)*2 + 1;
        index = start + randi(1:2) -1;
        found = 0;
        while ~found
            if ~used(index)
                scenario_sequence{TRIAL} = scenarios{index};
                found = 1;
                used(index) = 1;
            else
                index = start + randi(2) -1;
                done = all(used);
                if done
                    used = zeros(1,block_size);
                end
            end
        end
    end
end
class_mi_order = scenario_sequence;
trial_count = length(class_mi_order); 

% SET UP PRECISE TIMING 
stim.TRlength = 2;
SPEED = 1;
stim.isiDuration = 2*SPEED;
stim.scenarioDuration = 4*SPEED;
stim.goDuration = 8*SPEED;
stim.vividnessDuration = 6*SPEED;
config.nTRs.ISI = stim.isiDuration/stim.TRlength;
config.nTRs.scenario = stim.scenarioDuration/stim.TRlength;
config.nTRs.go = stim.goDuration/stim.TRlength;
config.nTRs.vividness = stim.vividnessDuration/stim.TRlength;
config.nTrials = block_size;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.go + config.nTRs.vividness;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI
runStart = GetSecs;

% give instructions, wait to begin
instruct = ['Would you like to start?' ...
    '\n\n-- press "enter" to begin --'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
stim.p3StartTime = waitForKeyboard(trigger,device);
%show them visualization rating so they know what it says


%present scenarios!
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
    else
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
displayText(mainWindow,'all done! hurray!',INSTANT,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
WaitSecs(2);