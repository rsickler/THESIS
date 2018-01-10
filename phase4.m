%%% Code for the final testing phase for all subject groups, in which
%%% subejects are tested on original and variants at even ratios and
%%% WITHOUT feedback. 
% 2s --> 6s ----> 4s
% all 16 images twice => 6.4 minutes

function phase4(SUBJECT,SUBJ_NAME,SESSION)

% STARTING EXPERIMENT
SETUP; 
instruct = 'Loading Phase 4...';
displayText(mainWindow, instruct, INSTANT, 'center',COLORS.MAINFONTCOLOR, WRAPCHARS);

% PSEUDO-RANDOMIZE
%pseudorandomize all originals and variants in blocks of 4, using all 16
% images twice each
all_scenarios =  cat(2,og_scenarios, v_scenarios);
used = zeros(1,length(all_scenarios));
scenario_sequence = [];

nQuads = 8;
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
P4_order = scenario_sequence;

%make SCENARIO TEXTURES ONLY in the pseudo-randomized order
N_images = length(scenario_sequence);
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
% make nonresponse texture
stimuliFolder = fullfile(workingDir, 'stimuli');
noresponse_matrix = double(imread(fullfile(stimuliFolder,'noresponse.jpg')));
noresponse_texture = Screen('MakeTexture', mainWindow, noresponse_matrix);

%make phase 4 timing changes(***EXLCUDE FEEDBACK)
config.nTrials = N_images;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.go;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI
runStart = GetSecs;

% give cue, wait to begin
instruct = ['Would you like to begin Phase 4?' ...
    '\n\n-- press "enter" to begin --'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
stim.p4StartTime = waitForKeyboard(trigger,device);

% BEGIN PHASE 4 TRIALS
trial = 1;
Atrials = 0; 
Btrials = 0; 
Acorrect_trials = 0; 
Bcorrect_trials = 0; 

while trial <= N_images
    % calculate all future onsets
    timing.plannedOnsets.preITI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.preITI(trial) = timing.plannedOnsets.preITI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.scenario(trial) = timing.plannedOnsets.preITI(trial) + config.nTRs.ISI*config.TR;
    timing.plannedOnsets.go(trial) = timing.plannedOnsets.scenario(trial) + config.nTRs.scenario*config.TR;
    % throw up the images
    % pre ITI
    timespec = timing.plannedOnsets.preITI(trial)-slack;
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.BLACK,WRAPCHARS,timespec);    
    % scenario
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    Screen('DrawTexture', mainWindow, scenario_texture(trial), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
    timing.actualOnsets.scenario(trial) = Screen('Flip',mainWindow,timespec);
    % go
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'GO!','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);    
    %record trajectory
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        ky(end+1)=y;
        kx(end+1)=x;
        pause(.05)
    end
    %set correct movements according to if in in A, B, A',B'
    this_pic = scenario_sequence{trial};
    if this_pic(1) == 'A'
        Atrials = Atrials+1;
        %switch diagnal movements if antenna on right side
        if this_pic(2) == 'R'
            x = -x;
        end
        if this_pic(3) == 'O' % if original
            correct_movement = (x<=-.75) && (y<=0.1);   %full diagnal line
            inc1_movement = (y<=.1) && (x>=-.75)&&(x<=.75); %full straight
            inc2_movement = (x>=.75) && (y<=0.1); %full diagnal cross
        else % if variant
            correct_movement = (x>=.75) && (y<=0.1); %full diagnal cross 
            inc1_movement = (y<=.1) && (x>=-.75)&&(x<=.75); %full straight
            inc2_movement = (x<=-.75) && (y<=0.1);  %full diagnal line
        end
    else %else in B
        Btrials = Btrials+1;
        %switch diagnal movements if antenna on right side
        if this_pic(2) == 'R'
            x = -x;
        end
        if this_pic(3) == 'O' % if original
            correct_movement = (x<=-.75) && (y>=-.1) && (y<=.75); %shwype
            inc1_movement = (x>=-.75)&&(x<=.75) && (y>=.1) && (y<=.6); %tip ahead
            inc2_movement = (x>=.75) && (y>=-.1) && (y<=.75); %sharp cross
        else
            correct_movement = (x>=-.75)&&(x<=.75) && (y>=.1) && (y<=.6); %tip ahead
            inc1_movement = (x<=-.75) && (y>=-.1) && (y<=.75); %shwype
            inc2_movement = (x>=.75) && (y>=-.1) && (y<=.75); %sharp cross
        end        
    end
    if correct_movement
        P4_response{trial} = 'correct';
        if this_pic(1) == 'A'
            Acorrect_trials = Acorrect_trials+1;
        else Bcorrect_trials = Bcorrect_trials+1;
        end
    elseif inc1_movement
        P4_response{trial} = 'incorrect1';
    elseif inc2_movement
        P4_response{trial} = 'incorrect2';
    else
        P4_response{trial} = 'improp response';
    end
    %update trial
    trial= trial+1;
end
% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.go(end) + config.nTRs.go*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.BLACK,WRAPCHARS,timespec);
WaitSecs(2);
displayText(mainWindow,'all done! hurray!',INSTANT,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
WaitSecs(2);


%SET UP SUBJECT DATA 
% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

total_trials = trial - 1; 
Aratio = Acorrect_trials / Atrials;
Bratio = Bcorrect_trials / Btrials;

save([ppt_dir matlabSaveFile], 'SUBJ_NAME', 'stim', 'timing', 'total_trials',...
    'P4_order','P4_response','P4_luck','Acorrect_trials','Bcorrect_trials','Aratio','Bratio');  

end