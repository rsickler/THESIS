%%% This code is for the phase 3 DIRECTED visualization session,
%%% with even ratio of original:variant and feedback given.
% 2s --> 3s --> 3s --> 4s --> 2s

function phase3_imagery(SUBJECT,SUBJ_NAME,SESSION)
%% setup up eryting
SETUP;
instruct = 'Loading Phase 3...';
displayText(mainWindow, instruct, INSTANT, 'center',COLORS.MAINFONTCOLOR, WRAPCHARS);

% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

%set up beep
InitializePsychSound(1);
freq = 44100;
nrchannels = 1;
beep_time = 0.25;
snddata = MakeBeep(378, beep_time, freq);
pahandle = PsychPortAudio('Open', [], [], [], freq, nrchannels);
PsychPortAudio('FillBuffer', pahandle, snddata);
%load in audio files
audioFolder = fullfile(workingDir, 'stimuli/audio');
addpath(audioFolder)  
right = 'right.mp3';
middle = 'middle.mp3';
left = 'left.mp3';
sharp_right = 'sharp_right.mp3';
sharp_left = 'sharp_left.mp3';
tip = 'tip.mp3';

% make vividness texture
otherFolder = fullfile(workingDir, 'stimuli/other');
vividness_matrix = double(imread(fullfile(otherFolder,'vividness.jpeg')));
vividness_texture = Screen('MakeTexture', mainWindow, vividness_matrix);
v_PICDIMS = [1024 768];
v_picRow = CENTER(2);
v_pic_size = windowSize.pixels*.75;
v_RESCALE_FACTOR = v_pic_size./v_PICDIMS;
v_topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (v_PICDIMS(HORIZONTAL)*v_RESCALE_FACTOR(HORIZONTAL))/2;
v_topLeft(VERTICAL) = v_picRow - (v_PICDIMS(VERTICAL)*v_RESCALE_FACTOR(VERTICAL))/2;
%make audio overview texture
audio_matrix = double(imread(fullfile(otherFolder,'audio.jpeg')));
audio_texture = Screen('MakeTexture', mainWindow, audio_matrix);

% PSEUDORANDOMIZE SCENARIOS
%pseudorandomize all originals and variants in blocks of 4, using all 16 images twices each
all_scenarios =  cat(2,og_scenarios, v_scenarios);
used = zeros(1,length(all_scenarios));
scenario_sequence = [];
nQuads = 8;     % this number * 4 = total # trials
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
%make textures in the pseudo-randomized order
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

% assign audio directions according to pseudorandomized order
audio = cell(1,length(scenario_sequence));
for i = 1: length(scenario_sequence)
    this_pic = scenario_sequence{i};
    if this_pic(1) == 'A'
        if this_pic(3) == 'O'      % if original
            if this_pic(2) == 'L'   % if left
                audio{i} = left;
            else                    %if right
                audio{i} = right;
            end
        else                   % if variant
            if this_pic(2) == 'L'   % if left
                audio{i} = right;
            else                    %if right
                audio{i} = left;
            end
        end
    else %else in B
        if this_pic(3) == 'O'      % if original
            if this_pic(2) == 'L'   % if left
                audio{i} = sharp_left;
            else                    %if right
                audio{i} = sharp_right;
            end
        else                       % if variant
            if this_pic(2) == 'L'   % if left
                audio{i} = tip;
            else                    %if right
                audio{i} = tip;
            end
        end
    end
end


%% GIVE INTRO
%explanation of task
instruct = ['You will now begin the third phase of the experiment. ' ...
    'In this phase, you will be presented with the same images as before,'...
    'following the same basic procedure of being presented an image and "hitting" toward the correct person or place for that image.'...
    '\n\n However, during this portion of the experiment, instead of '...
    'using the joystick as before, you will be performing '...
    'mental imagery of the proper joystick movement for that image, without ever actually moving it.'...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);

%instructions for keeping image
instruct = ['To aid you in this imagery, you will be presented with auditory "beep" cues ' ...
    'to tell you when to close and open your eyes. You should close your eyes on the first beep, which starts ' ...
    'right after the image is done being presented, and leave them closed until you hear the second beep. ' ...
    '\n\n After closing your eyes in response to the first beep, you should try to keep a representation of the presented image in '...
    'your mind as best as you can- try to keep a mental picture of the opponents color, the scenario presented, and any other details that will help you maintain the image.'...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);

%instructions for movement
instruct = ['3 Seconds after the first beep, you will then be given audible directions telling you what the proper response is for'...
    'that specific image. Upon receiving these directions, you should imagine moving and holding '...
    'the joystick in the proper position as specified by them, imagining doing so in real time over the same 4 second window as before. '...
    '\n\n Try to mentally simulate the sensation of initiating, making, and holding each specific movement '...
    'of the joystick as vividly as you can- the more effort you put into this here, the better our data!'... '...
    ' To denote the end of this 4 second window, a second "beep" will be presented, cueing you to open your eyes.'...
    '\n\n The directions you will be given will be presented on the next page to prevent any confusion.'...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);

%show overview screen
Screen('DrawTexture', mainWindow, audio_texture,[0 0 v_PICDIMS],[v_topLeft v_topLeft+v_PICDIMS.*v_RESCALE_FACTOR]);
cont = ['-- press "space" to continue --'];
cont_textRow = windowSize.pixels(2) *(.93);
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);

%instructions for feedback rating
instruct = ['Lastly, following this imagery phase, instead of seeing the outcome of your '...
    'imagined joystick movement, you will be asked to provide feedback '...
    'on the quality and vividness of the mental images you constructed during that specific trial. '...
    'It is at this point where you will be using the joystick to report this feedback, moving in the direction '...
    'that corresponds to the vividness of your imagery. \n\n You will have only 2 seconds to report this feedback, so please try '...
    'to respond quickly, and make sure you hold the joystick in the chosen direction until the end of the 2 seconds! '...
    '\n\n The feedback prompt you will see during this window will be shown on the next screen. '...
    'Please take the time to familiarize yourself with it so that you can report answers efficiently from the start.'...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);

%show vividness screen
Screen('DrawTexture', mainWindow, vividness_texture,[0 0 v_PICDIMS],[v_topLeft v_topLeft+v_PICDIMS.*v_RESCALE_FACTOR]);
cont = ['-- press "space" to continue --'];
cont_textRow = windowSize.pixels(2) *(.93);
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);

%end intro
instruct = ['To recap: '...
    '\n\n You will presented with an image, and after the first beep should close your eyes and try to maintain '...
    'the image in your head as well as you can. After 3 seconds, you will then be given an auditory cue for what the correct response is to that image- '...
    'you should imagine moving the joystick as if you were choosing that response yourself just as you did before in the previous phases. '...
    '\n\n After imagining moving the joystick over the same 4 second window, you will cued by another beep to open your eyes. You should should then use the joystick '...
    'to report your feedback on the imagery session using the joystick. You should only move the joystick during this point in time- NOT during the imagery segment! '...
    '\n\n Would you like to start?' ...
    '\n\n-- press "space" to begin --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);

%% Initialize experiment variables
%SET UP PRECISE TIMING
stim.isiDuration = 2*SPEED;
stim.scenarioDuration = 3*SPEED;
stim.imagineDuration = 3*SPEED;
stim.goDuration = 4*SPEED;
stim.vividnessDuration = 2*SPEED;

config.nTRs.ISI = stim.isiDuration/stim.TRlength;
config.nTRs.scenario = stim.scenarioDuration/stim.TRlength;
config.nTRs.imagine = stim.imagineDuration/stim.TRlength;
config.nTRs.go = stim.goDuration/stim.TRlength;
config.nTRs.vividness = stim.vividnessDuration/stim.TRlength;
config.nTrials = N_images;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.imagine + config.nTRs.go + config.nTRs.vividness;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI
runStart = GetSecs;

%% PRESENT DIRECTED TRIALS
trial = 1;
vividness = {}; 
X = []; 
Y = []; 

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
    timing.plannedOnsets.startbeep(trial) = timing.plannedOnsets.imagine(trial) - beep_time;
    timing.plannedOnsets.endbeep(trial) = timing.plannedOnsets.vividness(trial) - beep_time;
    % throw up the images
    % pre ITI
    timespec = timing.plannedOnsets.preITI(trial)-slack;
    timing.actualOnsets.preITI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % scenario
    timespec = timing.plannedOnsets.scenario(trial)-slack;
    Screen('DrawTexture', mainWindow, scenario_texture(trial), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
    timing.actualOnsets.scenario(trial) = Screen('Flip',mainWindow,timespec);
    % close eyes beep
    timespec = timing.plannedOnsets.startbeep(trial);
    basic_tone(timespec,beep_time, pahandle);
    % imagine scenario
    timespec = timing.plannedOnsets.imagine(trial)-slack;
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'+','center',COLORS.RED,WRAPCHARS,timespec);
    % go
    timespec = timing.plannedOnsets.go(trial)-slack;
    recording(timespec,audio{trial});
    timing.actualOnsets.go(trial) = start_time_func(mainWindow,'+','center',COLORS.RED,WRAPCHARS,timespec);
    % open eyes beep
    timespec = timing.plannedOnsets.endbeep(trial);
    basic_tone(timespec,beep_time,pahandle);
    % vividness
    timespec = timing.plannedOnsets.vividness(trial)-slack;
    Screen('DrawTexture', mainWindow, vividness_texture,[0 0 v_PICDIMS],[v_topLeft v_topLeft+v_PICDIMS.*v_RESCALE_FACTOR]);
    timing.actualOnsets.vividness(trial) = Screen('Flip',mainWindow,timespec);
    %record vividness input
    tEnd=GetSecs+stim.vividnessDuration;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
    end
    X(trial) = x;
    Y(trial) = y; 
%    record imagery rating
    if (x>=-.75)&&(x<=.75) && (y>=.75); %DOWN FOR NOT VIVID AT ALL
        vividness{trial} = 'NOT VIVID AT ALL';
    elseif (x<=-.75) && (y>=-.75)&&(y<=.75); %LEFT FOR SOMEWHAT VIVID
        vividness{trial} = 'SOMEWHAT VIVID';
    elseif (x>=-.75)&&(x<=.75) && (y<=-.75) % UP FOR FAIRLY VIVID
        vividness{trial} = 'FAIRLY VIVID';
    elseif (x>=.75) && (y>=-.75)&&(y<=.75) % RIGHT FOR VERY VIVID
        vividness{trial} = 'VERY VIVID';
    else
        vividness{trial} = 'UNCLEAR'; % if not in any region, saved as unclear
    end    
    %update trial
    trial= trial+1;
end
% throw up a final ITI
timing.plannedOnsets.lastITI = timing.plannedOnsets.vividness(end) + config.nTRs.vividness*config.TR;
timespec = timing.plannedOnsets.lastITI-slack;
timing.actualOnset.finalITI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(2);


%% END PHASE
%close some loose ends
PsychPortAudio('Close', pahandle);

% SAVE SUBJECT DATA
total_trials = trial - 1;
P3_order = scenario_sequence;
save([ppt_dir matlabSaveFile], 'SUBJ_NAME', 'stim', 'timing', 'total_trials',...
    'P3_order','vividness','X','Y');

%present closing screen
instruct = ['That completes the third phase! You may now take a brief break before phase four.' ...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end
