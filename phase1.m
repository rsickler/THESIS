% STARTING EXPERIMENT
INTRO;
instruct = ['Would you like to begin the experiment?'...
    '\n\n\n\n -- press "enter" to continue --'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
stim.p1StartTime = waitForKeyboard(trigger,device);

%BEGIN PHASE 1
% PSEUDO-RANDOMIZE
pseudorandomize;
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
min_trials = config.nTrials * 3;
%loop through until accuracies for both are met
while ((Aratio < .8) || (Bratio < .8)) || (trial < min_trials)
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
        correct_movement = (x<=-.75) && (y<=0.1);   %full diagnal line
        inc1_movement = (y<=.1) && (x>=-.75)&&(x<=.75); %full straight
        inc2_movement = (x>=.75) && (y<=0.1); %full diagnal cross
    else
        Btrials = Btrials+1;
        %switch diagnal movements if antenna on right side
        if this_pic(2) == 'R'
            x = -x;
        end
        correct_movement = (x<=-.75) && (y>=-.1) && (y<=.75); %shwype
        inc1_movement = (x>=-.75)&&(x<=.75) && (y>=.1) && (y<=.6); %tip ahead
        inc2_movement = (x>=.75) && (y>=-.1) && (y<=.75); %sharp cross
    end
    luck = rand;
    if correct_movement
        if luck > .2
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_correct_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        else
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_correct_u_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        end
        if this_pic(1) == 'A'
            Acorrect_trials = Acorrect_trials+1;
        else Bcorrect_trials = Bcorrect_trials+1;
        end
        P1_response{trial} = 'correct';
    elseif inc1_movement
        if luck < .2
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc1_u_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        else
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc1_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        end
        P1_response{trial} = 'incorrect1';
    elseif inc2_movement
        if luck < .2
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc2_u_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        else
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc2_texture(picnumber),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        end
        P1_response{trial} = 'incorrect2';
    else
        DrawFormattedText(mainWindow,'IMPROPER RESPONSE','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,noresponse_texture,[0 0 NR_PICDIMS],[NR_topLeft NR_topLeft+NR_PICDIMS.*NR_RESCALE_FACTOR]);
        P1_response{trial} = 'no response';
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
displayText(mainWindow,'80% accuracy achieved! hurray!',INSTANT,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
WaitSecs(2);