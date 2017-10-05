% STARTING EXPERIMENT
SETUP;

% PSEUDO-RANDOMIZE
%pseudorandomize all originals and variants for current sweep
all_scenarios =  cat(2,og_scenarios, v_scenarios);
all_corrects = cat(2,og_corrects, v_corrects);
all_inc1s = cat(2,og_inc1s, v_inc1s);
all_inc2s = cat(2,og_inc2s, v_inc2s);
all_corrects_u = cat(2,og_corrects_u, v_corrects_u);
all_inc1s_u = cat(2,og_inc1s_u, v_inc1s_u);
all_inc2s_u = cat(2,og_inc2s_u, v_inc2s_u);
used = zeros(1,length(all_scenarios));
scenario_sequence = [];
correct_sequence = [];
inc1_sequence = [];
inc2_sequence = [];
correct_u_sequence = [];
inc1_u_sequence = [];
inc2_u_sequence = [];

nQuads = 5;
for T = 1:nQuads
    ORDER = randperm(4);
    for i = 1:4
        sitch = ORDER(i);
        TRIAL = (T-1)*4 + i;
        start = (sitch-1)*2 + 1;
        index = start + randi(1:2) -1;
        found = 0;
        while ~found
            if ~used(index)
                scenario_sequence{TRIAL} = all_scenarios{index};
                correct_sequence{TRIAL} = all_corrects{index};
                inc1_sequence{TRIAL} = all_inc1s{index};
                inc2_sequence{TRIAL} = all_inc2s{index};
                correct_u_sequence{TRIAL} = all_corrects_u{index};
                inc1_u_sequence{TRIAL} = all_inc1s_u{index};
                inc2_u_sequence{TRIAL} = all_inc2s_u{index};
                found = 1;
                used(index) = 1;
            else
                index = start + randi(2) -1;
                done = all(used);
                if done
                    used = zeros(1,length(all_scenarios));
                end
            end
        end
    end
end
%make textures in the pseudo-randomized order
N_images = length(scenario_sequence);
for i = 1:N_images
    current = scenario_sequence{i};
    if current(3) == 'O'
        scenario_Folder = og_scenario_Folder;
        correct_Folder = og_correct_Folder;
        inc1_Folder = og_inc1_Folder;
        inc2_Folder = og_inc2_Folder;
        correct_u_Folder = og_correct_u_Folder;
        inc1_u_Folder = og_inc1_u_Folder;
        inc2_u_Folder = og_inc2_u_Folder;
    else
        scenario_Folder = v_scenario_Folder;
        correct_Folder = v_correct_Folder;
        inc1_Folder = v_inc1_Folder;
        inc2_Folder = v_inc2_Folder;
        correct_u_Folder = v_correct_u_Folder;
        inc1_u_Folder = v_inc1_u_Folder;
        inc2_u_Folder = v_inc2_u_Folder;
    end
    scenario_matrix = double(imread(fullfile(scenario_Folder,scenario_sequence{i})));
    scenario_texture(i) = Screen('MakeTexture', mainWindow, scenario_matrix);
    correct_matrix = double(imread(fullfile(correct_Folder,correct_sequence{i})));
    correct_texture(i) = Screen('MakeTexture', mainWindow, correct_matrix);
    inc1_matrix = double(imread(fullfile(inc1_Folder,inc1_sequence{i})));
    inc1_texture(i) = Screen('MakeTexture', mainWindow, inc1_matrix);
    inc2_matrix = double(imread(fullfile(inc2_Folder,inc2_sequence{i})));
    inc2_texture(i) = Screen('MakeTexture', mainWindow, inc2_matrix);
    correct_u_matrix = double(imread(fullfile(correct_u_Folder,correct_u_sequence{i})));
    correct_u_texture(i) = Screen('MakeTexture', mainWindow, correct_u_matrix);
    inc1_u_matrix = double(imread(fullfile(inc1_u_Folder,inc1_u_sequence{i})));
    inc1_u_texture(i) = Screen('MakeTexture', mainWindow, inc1_u_matrix);
    inc2_u_matrix = double(imread(fullfile(inc2_u_Folder,inc2_u_sequence{i})));
    inc2_u_texture(i) = Screen('MakeTexture', mainWindow, inc2_u_matrix);
end

%BEGIN PHASE 3
% give instructions, wait to begin
instruct = ['Would you like to start phase 3?' ...
    '\n\n-- press "enter" to begin --'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
stim.p3StartTime = waitForKeyboard(trigger,device);
% create structure for storing responses
P3_order = scenario_sequence;
P3_response = {};
%set up phase 2 timing changes
config.nTrials = N_images;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.go +config.nTRs.feedback;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI
runStart = GetSecs;
%begin!
trial = 1;
while trial <= N_images
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
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.BLACK,WRAPCHARS,timespec);
    % scenario
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    Screen('DrawTexture', mainWindow, scenario_texture(trial), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
    timing.actualOnsets.scenario(trial) = Screen('Flip',mainWindow,timespec);
    % go
    timespec = timing.plannedOnsets.go(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'GO!','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    %feedback
    timespec = timing.plannedOnsets.feedback(trial)-slack;
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
    luck = rand;
    if correct_movement
        if luck > .2
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        else
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, correct_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        end
        P3_response{trial} = 'correct';
    elseif inc1_movement
        if luck < .2
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc1_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        else
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc1_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        end
        P3_response{trial} = 'incorrect1';
    elseif inc2_movement
        if luck < .2
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc2_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        else
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc2_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        end
        P3_response{trial} = 'incorrect2';
    else
        DrawFormattedText(mainWindow,'IMPROPER RESPONSE','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,noresponse_texture,[0 0 NR_PICDIMS],[NR_topLeft NR_topLeft+NR_PICDIMS.*NR_RESCALE_FACTOR]);
        P3_response{trial} = 'no response';
    end
    timing.actualOnsets.feedback(trial) = Screen('Flip',mainWindow,timespec);
    %update trial
    trial= trial+1;
end
% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.feedback(end) + config.nTRs.feedback*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.BLACK,WRAPCHARS,timespec);
WaitSecs(2);
displayText(mainWindow,'all done! hurray!',INSTANT,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
WaitSecs(2);
