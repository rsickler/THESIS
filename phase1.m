%%% phase 1 is introduction to originals until 80% accuracy or max exposure. 
% 2s --> 6s ----> 4s --> 2s
%min trial = 24 => 5.6 minutes 
%max trial = 40 => 9.3 minutes 

function phase1(SUBJECT,SUBJ_NAME,SESSION)

% STARTING EXPERIMENT
SETUP; 
instruct = 'Loading Phase 1...';
displayText(mainWindow, instruct, INSTANT, 'center',COLORS.MAINFONTCOLOR, WRAPCHARS);

%KEY VARIABLES
min_trials = 24;
max_trials = 40; 

% PSEUDO-RANDOMIZE
all_orig = [1:N_og_images];
ROUNDS = 4;
max_sequence_rounds = 10;
scenario_sequence = [];
correct_sequence = [];
inc1_sequence = [];
inc2_sequence = [];
new_scenario_bundle = cell(1,N_og_images);
new_correct_bundle = cell(1,N_og_images);
new_inc1_bundle = cell(1,N_og_images);
new_inc2_bundle = cell(1,N_og_images);

for j = 1:max_sequence_rounds
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
    correct_sequence = cat(2,correct_sequence,new_correct_bundle);
    inc1_sequence = cat(2,inc1_sequence, new_inc1_bundle);
    inc2_sequence = cat(2,inc2_sequence, new_inc2_bundle);
end

%make original textures in the pseudo-randomized order
for i = 1:N_og_images*max_sequence_rounds
    og_scenario_matrix = double(imread(fullfile(og_scenario_Folder,scenario_sequence{i})));
    og_scenario_texture(i) = Screen('MakeTexture', mainWindow, og_scenario_matrix);
    og_correct_matrix = double(imread(fullfile(og_correct_Folder,correct_sequence{i})));
    og_correct_texture(i) = Screen('MakeTexture', mainWindow, og_correct_matrix);
    og_inc1_matrix = double(imread(fullfile(og_inc1_Folder,inc1_sequence{i})));
    og_inc1_texture(i) = Screen('MakeTexture', mainWindow, og_inc1_matrix);
    og_inc2_matrix = double(imread(fullfile(og_inc2_Folder,inc2_sequence{i})));
    og_inc2_texture(i) = Screen('MakeTexture', mainWindow, og_inc2_matrix);
end

% make nonresponse texture
stimuliFolder = fullfile(workingDir, 'stimuli');
noresponse_matrix = double(imread(fullfile(stimuliFolder,'noresponse.jpeg')));
noresponse_texture = Screen('MakeTexture', mainWindow, noresponse_matrix);


% ----BEGIN PHASE 1 ----
instruct = ['Would you like to begin Phase 1?'...
    '\n\n\n\n -- press "space" to continue --'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
stim.p1StartTime = waitForKeyboard(trigger,device);

%set up phase 1 specific timings
config.nTrials = N_og_images;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.go +config.nTRs.feedback;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI
runStart = GetSecs;
% create structure for storing responses
P1_order = {};
P1_response = {};
%initiate variables
trial = 1;
Atrials =0;
Btrials =0;
Acorrect_trials = 0;
Bcorrect_trials = 0;
Aratio = 0;
Bratio = 0;

% RUN TRIALS
%loop through until trial number and trial accuracies for both are met
while (trial <= max_trials)
    %store current image in structure
    P1_order{trial} = scenario_sequence{trial};
    % calculate all future onsets
    timing.plannedOnsets.preITI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.preITI(trial) = timing.plannedOnsets.preITI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preITI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    timing.plannedOnsets.feedback(trial) = timing.plannedOnsets.go(trial) + config.nTRs.go*config.TR;
    % throw up the images
    % pre ITI
    timespec = timing.plannedOnsets.preITI(trial)-slack;
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % scenario
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    Screen('DrawTexture', mainWindow, og_scenario_texture(trial), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
    timing.actualOnsets.scenario(trial) = Screen('Flip',mainWindow,timespec);
    % go
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'GO!','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    %feedback
    timespec = timing.plannedOnsets.feedback(trial)-slack;
    %record trajectory and final (x,y) at end of 2 secs
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        ky(end+1)=y;
        kx(end+1)=x;
        pause(.05)
    end
    %set correct movements according to if in in A or B
    this_pic = scenario_sequence{trial};
    if this_pic(1) == 'A'
        Atrials = Atrials+1;
        %switch diagnal movements if antenna on right side
        if this_pic(2) == 'R'
            x = -x;
        end
        correct_movement = (x<=-.75) && (y<=-.75);   %full diagnal line
        inc1_movement = (y<=-.75) && (x>=-.75)&&(x<=.75); %full straight
        inc2_movement = (x>=.75) && (y<=-.75); %full diagnal cross
    else
        Btrials = Btrials+1;
        %switch diagnal movements if antenna on right side
        if this_pic(2) == 'R'
            x = -x;
        end
        correct_movement = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
        inc1_movement = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
        inc2_movement = (x>=.75) && (y>=-.5) && (y<=.5); %sharp cross
    end
    if correct_movement
        DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        if this_pic(1) == 'A'
            Acorrect_trials = Acorrect_trials+1;
        else Bcorrect_trials = Bcorrect_trials+1;
        end
        P1_response{trial} = 'correct';
    elseif inc1_movement
        DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_inc1_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);  
        P1_response{trial} = 'incorrect1';
    elseif inc2_movement
        DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_inc2_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        P1_response{trial} = 'incorrect2';
    else
        DrawFormattedText(mainWindow,'IMPROPER RESPONSE \n\n ---Remember to HOLD it!---','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,noresponse_texture,[0 0 NR_PICDIMS],[NR_topLeft NR_topLeft+NR_PICDIMS.*NR_RESCALE_FACTOR]);
        P1_response{trial} = 'improp response';
    end
    timing.actualOnsets.feedback(trial) = Screen('Flip',mainWindow,timespec);
    
    % at end of each trial, check accuracy
    Aratio = Acorrect_trials / Atrials;
    Bratio = Bcorrect_trials / Btrials;
    %if both are good, and met minumum trial count, end loop!
    if (Aratio > .8) && (Bratio > .8) && (trial > min_trials)
        WaitSecs(2);
        break
    end
    trial = trial + 1;
end

% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.feedback(end) + config.nTRs.feedback*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(2);

%SAVE SUBJECT DATA 
% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end
%fix trial count if went to max
if trial > max_trials
    trial = trial-1;
end
%save important variables
save([ppt_dir matlabSaveFile],'SUBJ_NAME','stim', 'timing','trial','P1_order',...
    'P1_response','Atrials','Btrials','Acorrect_trials','Bcorrect_trials','Aratio','Bratio');  

%present closing screen
instruct = ['That completes the first phase! You may now take a brief break before phase two. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end
