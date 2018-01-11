function INTRO_BEHAV(SUBJECT,SUBJ_NAME,SESSION)

%SETUP 
SETUP; 

%loading intro photos
otherFolder = fullfile(workingDir, 'stimuli/other');
oneBlocker_matrix = double(imread(fullfile(otherFolder,'oneBlocker.jpeg')));
oneBlocker_texture = Screen('MakeTexture', mainWindow, oneBlocker_matrix);
twoBlocker_matrix = double(imread(fullfile(otherFolder,'twoBlocker.jpeg')));
twoBlocker_texture = Screen('MakeTexture', mainWindow, twoBlocker_matrix);
intro_PICDIMS = [767 767];
intro_pic_size = windowSize.pixels*.5;
intro_RESCALE_FACTOR = intro_pic_size./intro_PICDIMS;
intro_textRow = windowSize.pixels(2) *(.05);
intro_picRow = windowSize.pixels(2) *(.65);
cont_textRow = windowSize.pixels(2) *(.93); 
intro_topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (intro_PICDIMS(HORIZONTAL)*intro_RESCALE_FACTOR(HORIZONTAL))/2;
intro_topLeft(VERTICAL) = intro_picRow - (intro_PICDIMS(VERTICAL)*intro_RESCALE_FACTOR(VERTICAL))/2;

% present experiment summary
fontSize = round(30 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS)));
Screen('TextSize',mainWindow,fontSize);
start_time = GetSecs;
instruct = ['Hello! \n\n' ...
    'In this experiment, you will be presented with images of two different scenarios ' ...
    'from a volleyball game. In both scenarios, your goal is to score a point by "hitting" ' ...
    'the ball down on the opponents side of the court. You will be faced with people at '...
    'the net trying to "block" your hit, as well as three defenders trying to prevent the '...
    'ball from hitting the ground by hitting it up in the air.'...
    '\n\n\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);
instruct = ['For each scenario, you will have three different '...
    'response options- each representing a different direction to hit the ball. ' ...
    '\n\n It is important that you learn these now, as you will need to be able ' ...
    'to choose the proper response based which situation you are in throughout the study.'...
    '\n\n\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);



%instructions for 1 blocker
fontSize = round(24 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS)));
Screen('TextSize',mainWindow,fontSize);
instruct = ['When faced with a single blocker, your three options are:'...
    '\n\n  1.    Hit the ball towards the defender on the same side of the court as you.'...
    '\n\n  2.    Hit the ball towards the center defender.' ...
    '\n\n  3.    Hit the ball towards the defender on the opposite side of the court as you.'...
    '\n\n The joystick movements associated with each of these three options are shown below. '...
    'Notice the movements are flipped depending on which side of the court you are starting from!'];
DrawFormattedText(mainWindow,instruct,intro_textRow,intro_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.75);
Screen('DrawTexture', mainWindow,oneBlocker_texture,[0 0 intro_PICDIMS],[intro_topLeft intro_topLeft+intro_PICDIMS.*intro_RESCALE_FACTOR]);
cont = ['-- press "enter" to continue --'];
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press2 = waitForKeyboard(trigger,device);

%instructions for 2 blocker
fontSize = round(23 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS)));
Screen('TextSize',mainWindow,fontSize);
instruct = ['When faced with two blockers, however, these options are no longer available, so the choices change accordingly! In this case, the three options are:'...
    '\n\n  1.    Hit the ball off the blockers hands away from the court (in volleyball, it is a point if they touch it!).'...
    '\n\n  2.    Gently tip the ball straight over the blockers.'...
    '\n\n  3.    Hit the ball inside the blockers toward the defender on the other side of the court.'...
    '\n\n In this scenario, the joystick movements are much sharper, in that you should not push the joystick forward When moving to the side, and should only move slightly forward when tipping. '...
    'How far vertically you move the joystick is just as important as horizontally!'];   
DrawFormattedText(mainWindow,instruct,intro_textRow,intro_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.75);
Screen('DrawTexture', mainWindow,twoBlocker_texture,[0 0 intro_PICDIMS],[intro_topLeft intro_topLeft+intro_PICDIMS.*intro_RESCALE_FACTOR]);
cont = ['-- press "enter" to continue --'];
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press3 = waitForKeyboard(trigger,device);

% back to explaining
fontSize = round(30 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS)));
Screen('TextSize',mainWindow,fontSize);
instruct = ['When presented with each scenario, you will have 4 seconds to process '...
    'the image and think about what your response will be. Remember to look at the color '... 
    'jersey the opponent team is wearing-  what color team you are playing matters! '... 
    'Different opponents will have different skill-sets, meaning that the best response for '... 
    'one color team may not be the same for a different color team.'...
    '\n\n During this 4 second window, you should think about what '...
    'movement you will make, but do not move the joystick yet. After the 4 seconds are up, '...
    'you will then be given a "GO" cue, after which you will have 2 seconds to make your movement. '...
    'Move and HOLD the joystick in the position you want until the 2 seconds are up.'...
    '\n\n -- press "enter" to continue --'];

DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press4 = waitForKeyboard(trigger,device);
instruct = ['You will then be shown the outcome of your decision. The "best" choice will earn you one point most of the time, '...
    'while the other choices will only earn you one point a small percent of the time. '...
    'Choices that earned a point will be highlighted in green, '...
    'and choices that did not earn you a point will be highlighted in red. '...
    '\n\n \n\n If you do not pick one of three proper response options for the specific scenario presented, you will be given a recap of the response options '...
    'and you will not earn any points. The more points you finish with the better, '...
    'so make sure to try your best!'...
    '\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press5 = waitForKeyboard(trigger,device);
instruct_time = GetSecs - start_time;

%JOYSTICK TRAINING
oneTest_matrix = double(imread(fullfile(otherFolder,'oneTest.jpeg')));
oneTest_texture = Screen('MakeTexture', mainWindow, oneTest_matrix);
twoTest_matrix = double(imread(fullfile(otherFolder,'twoTest.jpeg')));
twoTest_texture = Screen('MakeTexture', mainWindow, twoTest_matrix);
test_PICDIMS = [700 400];
test_pic_size = windowSize.pixels*.5;
test_RESCALE_FACTOR = test_pic_size./test_PICDIMS;
test_picRow = windowSize.pixels(2) *(.5);
test_textRow = windowSize.pixels(2) *(.08);
cont_textRow = windowSize.pixels(2) *(.85); 
test_topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (test_PICDIMS(HORIZONTAL)*test_RESCALE_FACTOR(HORIZONTAL))/2;
test_topLeft(VERTICAL) = test_picRow - (test_PICDIMS(VERTICAL)*test_RESCALE_FACTOR(VERTICAL))/2;

%single block- left person
good = 'Good!';
instruct = ['Lets make sure you understand the joystick movements.'...
    ' Here are the three options against a single block again, starting from the left side of the court:'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,oneTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '1. Try hitting toward the leftmost defender by moving the joystick all the way forward and all the way to the left.';
DrawFormattedText(mainWindow,test,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(3); 
done = 0; 
while ~done 
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    goal = (x<=-.75) && (y<=0.5); %full diagnal line
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,oneTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
        DrawFormattedText(mainWindow,good,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
end
WaitSecs(2); 

%single block- middle person
instruct = ['Lets make sure you understand the joystick movements.'...
    ' Here are the three options against a single block again, assuming you start on the left side of the court:'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,oneTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '2. Try hitting straight ahead toward the middle defender by moving (and holding) the joystick all the way forward while keeping it centered.';
DrawFormattedText(mainWindow,test,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(3); 
done = 0; 
while ~done
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    goal = (y<=-.5) && (x>=-.75)&&(x<=.75); %full straight
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,oneTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
        good = 'Good!';
        DrawFormattedText(mainWindow,good,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
end
WaitSecs(2); 

%single block- right person
instruct = ['Lets make sure you understand the joystick movements.'...
    ' Here are the three options against a single block again, assuming you start on the left side of the court:'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,oneTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '3. Try hitting the ball to the rightmost defender by (and holding) the joystick all the way forward and all the way to the right.';
DrawFormattedText(mainWindow,test,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(3); 
done = 0; 
while ~done
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    goal = (x>=.75) && (y<=0.5); %full diagnal cross
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,oneTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
        good = 'Good!';
        DrawFormattedText(mainWindow,good,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
end
WaitSecs(2);

% double block- tool out of bounds
instruct = ['Now here are the three options against a double block, assuming you start on the left side of the court: '... 
    'Remember, here you do not move the joystick all the way forward!'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,twoTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '1. Try hitting the ball off the block out of bounds off the block by moving (and holding) the joystick slightly forward and all the way toward the left.';
DrawFormattedText(mainWindow,test,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(3); 
done = 0; 
while ~done
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    goal = (x<=-.75) && (y>=-.75) && (y<=0); %shwype
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,twoTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
        good = 'Good!';
        DrawFormattedText(mainWindow,good,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
end
WaitSecs(2);

% double block- tip over the block
instruct = ['Now here are the three options against a double block, assuming you start on the left side of the court: '... 
    'Remember, here you do not move the joystick all the way forward!'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,twoTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '2. Try tipping the ball just over the block by moving (and holding) the joystick slightly forward while keeping it centered.';
DrawFormattedText(mainWindow,test,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(3); 
done = 0; 
while ~done
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    goal = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,twoTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
        good = 'Good!';
        DrawFormattedText(mainWindow,good,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
end
WaitSecs(2);

% double block- hit cross
instruct = ['Now here are the three options against a double block, assuming you start on the left side of the court: '... 
    'Remember, here you do not move the joystick all the way forward!'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,twoTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '3. Try hitting the ball sharp across the court by moving (and holding) the joystick slightly forward and al the way toward the right.';
DrawFormattedText(mainWindow,test,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(3); 
done = 0; 
while ~done
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    goal = (x>=.75) && (y>=-.75) && (y<=0); %sharp cross
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,twoTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
        good = 'Good!';
        DrawFormattedText(mainWindow,good,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
end
WaitSecs(2);
train_time = GetSecs - instruct_time - start_time;

%make sure they actually did it
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

%save how long intro took
total_time = GetSecs - start_time;
save([ppt_dir matlabSaveFile],'SUBJ_NAME','instruct_time', 'train_time','total_time',...
    'intro_press1','intro_press2','intro_press3','intro_press4','intro_press5');  

instruct = ['That completes the tutorial! You may now take a brief break before phase one. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);
end


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
% make nonresponse texture
stimuliFolder = fullfile(workingDir, 'stimuli');
noresponse_matrix = double(imread(fullfile(stimuliFolder,'noresponse.jpeg')));
noresponse_texture = Screen('MakeTexture', mainWindow, noresponse_matrix);


% ----BEGIN PHASE 1 ----
instruct = ['Would you like to begin Phase 1?'...
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
P1_luck = {};
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
        inc1_movement = (y<=-.5) && (x>=-.75)&&(x<=.75); %full straight
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
    luck = rand;
    if correct_movement
        if luck > .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P1_luck{trial} = 1; 
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_correct_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P1_luck{trial} = 0; 
        end
        if this_pic(1) == 'A'
            Acorrect_trials = Acorrect_trials+1;
        else Bcorrect_trials = Bcorrect_trials+1;
        end
        P1_response{trial} = 'correct';
    elseif inc1_movement
        if luck < .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc1_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P1_luck{trial} = 1;
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc1_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P1_luck{trial} = 0;
        end
        P1_response{trial} = 'incorrect1';
    elseif inc2_movement
        if luck < .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc2_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P1_luck{trial} = 1;
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, og_inc2_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P1_luck{trial} = 0;
        end
        P1_response{trial} = 'incorrect2';
    else
        DrawFormattedText(mainWindow,'IMPROPER RESPONSE \n\n ---Remember to HOLD it!---','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,noresponse_texture,[0 0 NR_PICDIMS],[NR_topLeft NR_topLeft+NR_PICDIMS.*NR_RESCALE_FACTOR]);
        P1_response{trial} = 'improp response';
        P1_luck{trial} = -1;
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
    'P1_response', 'P1_luck','Atrials','Btrials','Acorrect_trials','Bcorrect_trials','Aratio','Bratio');  

%present closing screen
instruct = ['That completes the first phase! You may now take a brief break before phase two. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end

%%% phase 2 is initial addition of variants to originals, at 1:4 ratio.
% 2s --> 6s ----> 4s --> 2s
% 4 bundles of 10 => 9.3 minutes

function phase2(SUBJECT,SUBJ_NAME,SESSION)

% STARTING EXPERIMENT
SETUP;
instruct = 'Loading Phase 2...';
displayText(mainWindow, instruct, INSTANT, 'center',COLORS.MAINFONTCOLOR, WRAPCHARS);

% PSEUD0-RANDOMIZE
scenario_sequence = [];
correct_sequence = [];
inc1_sequence = [];
inc2_sequence = [];
correct_u_sequence = [];
inc1_u_sequence = [];
inc2_u_sequence = [];
used_variants = zeros(1,N_v_images);

% make series of 4 bundles of 10 (each variant image shown 1 time)
for i =1:4
    %add a variant scenario to all 4 orignals to make bundle of 5
    ran1 = randi(4);
    ran2 = 5+randi(4)-1;
    done = 0;
    while ~done
        if used_variants(ran1) < 1
            if used_variants(ran2) < 1
                scenario_bundle = cat(2,og_scenarios, v_scenarios(ran1));
                scenario_bundle = cat(2,scenario_bundle, v_scenarios(ran2));
                correct_bundle = cat(2,og_corrects, v_corrects(ran1));
                correct_bundle = cat(2,correct_bundle, v_corrects(ran2));
                inc1_bundle = cat(2,og_inc1s, v_inc1s(ran1));
                inc1_bundle = cat(2,inc1_bundle, v_inc1s(ran2));
                inc2_bundle = cat(2,og_inc2s, v_inc2s(ran1));
                inc2_bundle = cat(2,inc2_bundle, v_inc2s(ran2));
                correct_u_bundle = cat(2,og_corrects_u, v_corrects_u(ran1));
                correct_u_bundle = cat(2,correct_u_bundle, v_corrects_u(ran2));
                inc1_u_bundle = cat(2,og_inc1s_u, v_inc1s_u(ran1));
                inc1_u_bundle = cat(2,inc1_u_bundle, v_inc1s_u(ran2));
                inc2_u_bundle = cat(2,og_inc2s_u, v_inc2s_u(ran1));
                inc2_u_bundle = cat(2,inc2_u_bundle, v_inc2s_u(ran2));
                shuffler = randperm(10);
                for i= 1:10
                    new_scenario_bundle(i) = scenario_bundle(shuffler(i));
                    new_correct_bundle(i) = correct_bundle(shuffler(i));
                    new_inc1_bundle(i) = inc1_bundle(shuffler(i));
                    new_inc2_bundle(i) = inc2_bundle(shuffler(i));
                    new_correct_u_bundle(i) = correct_u_bundle(shuffler(i));
                    new_inc1_u_bundle(i) = inc1_u_bundle(shuffler(i));
                    new_inc2_u_bundle(i) = inc2_u_bundle(shuffler(i));
                end
                scenario_sequence = cat(2,scenario_sequence, new_scenario_bundle);
                correct_sequence = cat(2,correct_sequence,new_correct_bundle);
                inc1_sequence = cat(2,inc1_sequence, new_inc1_bundle);
                inc2_sequence = cat(2,inc2_sequence, new_inc2_bundle);
                correct_u_sequence = cat(2,correct_u_sequence,new_correct_u_bundle);
                inc1_u_sequence = cat(2,inc1_u_sequence, new_inc1_u_bundle);
                inc2_u_sequence = cat(2,inc2_u_sequence, new_inc2_u_bundle);
                % tally use of variants
                used_variants(ran1) = used_variants(ran1)+1;
                used_variants(ran2) = used_variants(ran2)+1;
                done = 1;
            else
                ran2 = 5+randi(4)-1;
            end
        else
            ran1 = randi(4);
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
% make nonresponse texture
stimuliFolder = fullfile(workingDir, 'stimuli');
noresponse_matrix = double(imread(fullfile(stimuliFolder,'noresponse.jpeg')));
noresponse_texture = Screen('MakeTexture', mainWindow, noresponse_matrix);

% BEGIN PHASE 2
instruct = ['Would you like to start Phase 2?' ...
    '\n\n Remember to look at the color jersey the opponent team is wearing- '...
    'the best response for one color team may not be the same as for a different color team.'...
    'What color team you are playing matters!' ...
    '\n\n --  press "enter" to begin --'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
stim.p2StartTime = waitForKeyboard(trigger,device);

%set up phase 2 timing changes
config.nTrials = N_images;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.go +config.nTRs.feedback;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI
runStart = GetSecs;
% set structure for reading responses
P2_order = scenario_sequence;
P2_response = {};
P2_luck = {};

%initiate variables
trial = 1;
Atrials =0;
Btrials =0;
Acorrect_trials = 0;
Bcorrect_trials = 0;
Aratio = 0;
Bratio = 0;

% RUN TRIALS
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
        Atrials = Atrials+1;
        %switch diagnal movements if antenna on right side
        if this_pic(2) == 'R'
            x = -x;
        end
        if this_pic(3) == 'O' % if original
            correct_movement = (x<=-.75) && (y<=-.5);   %full diagnal line
            inc1_movement = (y<=-.5) && (x>=-.75)&&(x<=.75); %full straight
            inc2_movement = (x>=.75) && (y<=-.5); %full diagnal cross
        else % if variant
            correct_movement = (x>=.75) && (y<=-.5); %full diagnal cross
            inc1_movement = (y<=-.5) && (x>=-.75)&&(x<=.75); %full straight
            inc2_movement = (x<=-.75) && (y<=-.5);  %full diagnal line
        end
    else %else in B
        Btrials = Btrials+1;
        %switch diagnal movements if antenna on right side
        if this_pic(2) == 'R'
            x = -x;
        end
        if this_pic(3) == 'O' % if original
            correct_movement = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
            inc1_movement = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
            inc2_movement = (x>=.75) && (y>=-.5) && (y<=.5); %sharp cross
        else % if variant
            correct_movement = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
            inc1_movement = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
            inc2_movement = (x>=.75) && (y>=-.5) && (y<=.5); %sharp cross
        end
    end
    luck = rand;
    if correct_movement
        if luck > .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            P1_luck{trial} = 1;
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, correct_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            P1_luck{trial} = 0;
        end
        P2_response{trial} = 'correct';
        if this_pic(1) == 'A'
            Acorrect_trials = Acorrect_trials+1;
        else Bcorrect_trials = Bcorrect_trials+1;
        end
        
    elseif inc1_movement
        if luck < .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc1_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            P1_luck{trial} = 1;
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc1_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            P1_luck{trial} = 1;
        end
        P2_response{trial} = 'incorrect1';
    elseif inc2_movement
        if luck < .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc2_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            P1_luck{trial} = 1;
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc2_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
            P1_luck{trial} = 0;
        end
        P2_response{trial} = 'incorrect2';
    else
        DrawFormattedText(mainWindow,'IMPROPER RESPONSE \n\n ---Remember to HOLD it!---','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,noresponse_texture,[0 0 NR_PICDIMS],[NR_topLeft NR_topLeft+NR_PICDIMS.*NR_RESCALE_FACTOR]);
        P2_response{trial} = 'improp response';
        P1_luck{trial} = -1;
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
    'P2_order','P2_response','P2_luck','Atrials','Btrials','Acorrect_trials','Bcorrect_trials','Aratio','Bratio');

%present closing screen
instruct = ['That completes the second phase! You may now take a brief break before phase three. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end

%%% phase 3 (in scanner) is continued training of variants and originals together,
%%% but this time at even ratios. This version has feedback.
% 2s --> 6s ----> 4s --> 2s
% all 16 once each => 3.7 minutes
function phase3_training(SUBJECT,SUBJ_NAME,SESSION)

% STARTING EXPERIMENT
SETUP; 
instruct = 'Loading Phase 3...';
displayText(mainWindow, instruct, INSTANT, 'center',COLORS.MAINFONTCOLOR, WRAPCHARS);

% PSEUDO-RANDOMIZE
%pseudorandomize all originals and variants in blocks of 4, using all 16
% images once each
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

nQuads = 4;
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
                correct_sequence{TRIAL} = all_corrects{index};
                inc1_sequence{TRIAL} = all_inc1s{index};
                inc2_sequence{TRIAL} = all_inc2s{index};
                correct_u_sequence{TRIAL} = all_corrects_u{index};
                inc1_u_sequence{TRIAL} = all_inc1s_u{index};
                inc2_u_sequence{TRIAL} = all_inc2s_u{index};
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
% make nonresponse texture
stimuliFolder = fullfile(workingDir, 'stimuli');
noresponse_matrix = double(imread(fullfile(stimuliFolder,'noresponse.jpeg')));
noresponse_texture = Screen('MakeTexture', mainWindow, noresponse_matrix);

%BEGIN PHASE 3
% give instructions, wait to begin
instruct = ['Would you like to start phase 3?' ...
    '\n\n-- press "enter" to begin --'];
displayText(mainWindow,instruct,INSTANT, 'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
stim.p3StartTime = waitForKeyboard(trigger,device);
% create structure for storing responses
P3_order = scenario_sequence;
P3_response = {};
P3_luck = {};
Atrials = 0; 
Btrials = 0; 
Acorrect_trials = 0; 
Bcorrect_trials = 0; 

%set up phase 3 specific timings
config.nTrials = N_images;
config.nTRs.perTrial =  config.nTRs.ISI + config.nTRs.scenario + config.nTRs.go +config.nTRs.feedback;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI
runStart = GetSecs;

%BEGIN!
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
            correct_movement = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
            inc1_movement = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
            inc2_movement = (x>=.75) && (y>=-.5) && (y<=.5); %sharp cross
        else
            correct_movement = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
            inc1_movement = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
            inc2_movement = (x>=.75) && (y>=-.5) && (y<=.5); %sharp cross
        end        
    end
    luck = rand;
    if correct_movement
        if luck > .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P3_luck{trial} = 1;
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, correct_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P3_luck{trial} = 0;
        end
        if this_pic(1) == 'A'
            Acorrect_trials = Acorrect_trials+1;
        else Bcorrect_trials = Bcorrect_trials+1;
        end
        P3_response{trial} = 'correct';
    elseif inc1_movement
        if luck < .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc1_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P3_luck{trial} = 1;
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc1_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P3_luck{trial} = 0;
        end
        P3_response{trial} = 'incorrect1';
    elseif inc2_movement
        if luck < .2
            DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc2_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P3_luck{trial} = 1;
        else
            DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
            Screen('DrawTexture', mainWindow, inc2_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
            Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
            P3_luck{trial} = 0;
        end
        P3_response{trial} = 'incorrect2';
    else
        DrawFormattedText(mainWindow,'IMPROPER RESPONSE \n\n ---Remember to HOLD it!---','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow,noresponse_texture,[0 0 NR_PICDIMS],[NR_topLeft NR_topLeft+NR_PICDIMS.*NR_RESCALE_FACTOR]);
        P3_response{trial} = 'improp response';
        P3_luck{trial} = -1;
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

% SAVE SUBJECT DATA 
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
    'P3_order','P3_response','P3_luck','Acorrect_trials','Bcorrect_trials','Aratio','Bratio');  

%present closing screen
instruct = ['That completes the third phase! You may now take a brief break before phase four. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end

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
noresponse_matrix = double(imread(fullfile(stimuliFolder,'noresponse.jpeg')));
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
            correct_movement = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
            inc1_movement = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
            inc2_movement = (x>=.75) && (y>=-.5) && (y<=.5); %sharp cross
        else
            correct_movement = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
            inc1_movement = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
            inc2_movement = (x>=.75) && (y>=-.5) && (y<=.5); %sharp cross
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

