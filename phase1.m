function phase2(SUBJECT,SESSION)

% PSEUDO-RANDOMIZE
SETUP; 
all_orig = [1:N_og_images];
ROUNDS = 4;
max_sequence_rounds = 10;
scenario_sequence = [];
correct_sequence = [];
inc1_sequence = [];
inc2_sequence = [];
correct_u_sequence = [];
inc1_u_sequence = [];
inc2_u_sequence = [];

new_scenario_bundle = cell(1,N_og_images);
new_correct_bundle = cell(1,N_og_images);
new_inc1_bundle = cell(1,N_og_images);
new_inc2_bundle = cell(1,N_og_images);
new_correct_u_bundle = cell(1,N_og_images);
new_inc1_u_bundle = cell(1,N_og_images);
new_inc2_u_bundle = cell(1,N_og_images);

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
                    new_correct_u_bundle{TRIAL} = og_corrects_u{index};
                    new_inc1_u_bundle{TRIAL} = og_inc1s_u{index};
                    new_inc2_u_bundle{TRIAL} = og_inc2s_u{index};
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
    correct_u_sequence = cat(2,correct_u_sequence,new_correct_u_bundle);
    inc1_u_sequence = cat(2,inc1_u_sequence, new_inc1_u_bundle);
    inc2_u_sequence = cat(2,inc2_u_sequence, new_inc2_u_bundle);
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
    og_correct_u_matrix = double(imread(fullfile(og_correct_u_Folder,correct_u_sequence{i})));
    og_correct_u_texture(i) = Screen('MakeTexture', mainWindow, og_correct_u_matrix);
    og_inc1_u_matrix = double(imread(fullfile(og_inc1_u_Folder,inc1_u_sequence{i})));
    og_inc1_u_texture(i) = Screen('MakeTexture', mainWindow, og_inc1_u_matrix);
    og_inc2_u_matrix = double(imread(fullfile(og_inc2_u_Folder,inc2_u_sequence{i})));
    og_inc2_u_texture(i) = Screen('MakeTexture', mainWindow, og_inc2_u_matrix);
end


% ----BEGIN PHASE 1 ----
instruct = ['Would you like to begin the experiment?'...
    '\n\n\n\n -- press "enter" to continue --'];
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
picnumber = 1;
trial = 1;
Atrials =0;
Btrials =0;
Acorrect_trials = 0;
Bcorrect_trials = 0;
Aratio = 0;
Bratio = 0;
min_trials = 32;
max_trials = 80; 

% RUN TRIALS
%loop through until accuracies for both are met
while (((Aratio < .8) || (Bratio < .8)) || (trial < min_trials)) && trial < max_trials
    %store current image in structure
    P1_order{trial} = scenario_sequence{picnumber};
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
    Screen('DrawTexture', mainWindow, og_scenario_texture(picnumber), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
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
    this_pic = scenario_sequence{picnumber};
    if this_pic(1) == 'A'
        Atrials = Atrials+1;
        %switch diagnal movements if antenna on right side
        if this_pic(2) == 'R'
            x = -x;
        end
        correct_movement = (x<=-.75) && (y<=-.75);   %full diagnal line
        inc1_movement = (y<=-.5) && (x>=-.75)&&(x<=.75); %full straight
        inc2_movement = (x>=.75) && (y<=-.75); %full diagnal cross
    else
        Btrials = Btrials+1;
        %switch diagnal movements if antenna on right side
        if this_pic(2) == 'R'
            x = -x;
        end
        correct_movement = (x<=-.75) && (y>=-.75) && (y<=.25); %shwype
        inc1_movement = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
        inc2_movement = (x>=.75) && (y>=-.75) && (y<=.25); %sharp cross
    end
    luck = rand;
    if correct_movement
        if luck > .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_correct_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_correct_u_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        end
        if this_pic(1) == 'A'
            Acorrect_trials = Acorrect_trials+1;
        else Bcorrect_trials = Bcorrect_trials+1;
        end
        P1_response{trial} = 'correct';
    elseif inc1_movement
        if luck < .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc1_u_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc1_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        end
        P1_response{trial} = 'incorrect1';
    elseif inc2_movement
        if luck < .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc2_u_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc2_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        end
        P1_response{trial} = 'incorrect2';
    else
        DrawFormattedText(mainWindow,'IMPROPER RESPONSE \n\n ---Remember to HOLD it!---','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,noresponse_texture,[0 0 NR_PICDIMS],[NR_topLeft NR_topLeft+NR_PICDIMS.*NR_RESCALE_FACTOR]);
        P1_response{trial} = 'improp response';
    end
    timing.actualOnsets.feedback(trial) = Screen('Flip',mainWindow,timespec);
    % update counts
    picnumber = picnumber +1;
    % at end of  trial cycle, check accuracy and re-cycle through if needed
    if ~mod(trial,config.nTrials)
        %calculate ratios
        Aratio = Acorrect_trials / Atrials;
        Bratio = Bcorrect_trials / Btrials;
        %if either ratio is too low, reshuffle for another run through
        if (Aratio < .8) || (Bratio < .8)
            picnumber = 1;
            pseudorandomize;
        end
        %if both are good, have final feedback stay up on screen
        if (Aratio > .8) && (Bratio > .8)
            WaitSecs(2);
        end
    end
    trial = trial + 1;
end

% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.feedback(end) + config.nTRs.feedback*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(2);
displayText(mainWindow,'80% accuracy achieved! Hurray!',INSTANT,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
WaitSecs(2);

%SET UP SUBJECT DATA 
% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end
MATLAB_SAVE_FILE = [ppt_dir matlabSaveFile];
LOG_NAME = [ppt_dir logName];

save(matlabSaveFile, 'stim', 'timing');  

end
