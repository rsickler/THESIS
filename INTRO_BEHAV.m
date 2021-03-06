function INTRO_BEHAV(SUBJECT,SUBJ_NAME,SESSION)

%SETUP 
SETUP; 

% make nonresponse texture
stimuliFolder = fullfile(workingDir, 'stimuli');
noresponse_matrix = double(imread(fullfile(stimuliFolder,'noresponse.jpeg')));
noresponse_texture = Screen('MakeTexture', mainWindow, noresponse_matrix);

%loading intro photos
otherFolder = fullfile(workingDir, 'stimuli/other');
noBlocker_matrix = double(imread(fullfile(otherFolder,'noBlocker.jpeg')));
noBlocker_texture = Screen('MakeTexture', mainWindow, noBlocker_matrix);
twoBlocker_matrix = double(imread(fullfile(otherFolder,'twoBlocker.jpeg')));
twoBlocker_texture = Screen('MakeTexture', mainWindow, twoBlocker_matrix);
intro_PICDIMS = [735 768];
intro_pic_size = windowSize.pixels*.5;
intro_RESCALE_FACTOR = intro_pic_size./intro_PICDIMS;
intro_textRow = windowSize.pixels(2) *(.05);
intro_picRow = windowSize.pixels(2) *(.65);
cont_textRow = windowSize.pixels(2) *(.93); 
intro_topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (intro_PICDIMS(HORIZONTAL)*intro_RESCALE_FACTOR(HORIZONTAL))/2;
intro_topLeft(VERTICAL) = intro_picRow - (intro_PICDIMS(VERTICAL)*intro_RESCALE_FACTOR(VERTICAL))/2;

%create original scenario folder for intro training
for i = 1:N_og_images
    og_scenario_matrix = double(imread(fullfile(og_scenario_Folder,og_scenarios{i})));
    og_scenario_texture(i) = Screen('MakeTexture', mainWindow, og_scenario_matrix);
    og_correct_matrix = double(imread(fullfile(og_correct_Folder,og_corrects{i})));
    og_correct_texture(i) = Screen('MakeTexture', mainWindow, og_correct_matrix);
    og_inc1_matrix = double(imread(fullfile(og_inc1_Folder,og_inc1s{i})));
    og_inc1_texture(i) = Screen('MakeTexture', mainWindow, og_inc1_matrix);
    og_inc2_matrix = double(imread(fullfile(og_inc2_Folder,og_inc2s{i})));
    og_inc2_texture(i) = Screen('MakeTexture', mainWindow, og_inc2_matrix);
end

% PRESENT EXPERIMENT SUMMARY
fontSize = round(30 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS)));
Screen('TextSize',mainWindow,fontSize);
start_time = GetSecs;
instruct = ['Hello! \n\n' ...
    'In this experiment, you will be presented with images of two different scenarios ' ...
    'from a volleyball game. In both scenarios, your goal is to score a point by "hitting" ' ...
    'the ball down on the opponents side of the court. In both scenarios, you will be faced '...
    'with three defenders trying to prevent the ball from hitting the ground and keep you from scoring.'...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);
instruct = ['For each scenario, you will have three different '...
    'response options- each representing a different direction to hit the ball. ' ...
    '\n\n It is important that you learn these now, as you will need to be able ' ...
    'to choose the proper response based on which situation you are in throughout the study.'...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);



%instructions for no blocker
fontSize = round(24 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS)));
Screen('TextSize',mainWindow,fontSize);
instruct = ['When faced with just 3 defenders and open net, your three options are:'...
    '\n\n  1.    Hit the ball towards the defender on the same side of the court as you.'...
    '\n\n  2.    Hit the ball towards the center defender.' ...
    '\n\n  3.    Hit the ball towards the defender on the opposite side of the court as you.'...
    '\n\n The joystick movements associated with each of these three options are shown below. '...
    'Notice the movements are flipped depending on which side of the court you are viewing from!'];
DrawFormattedText(mainWindow,instruct,intro_textRow,intro_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.75);
Screen('DrawTexture', mainWindow,noBlocker_texture,[0 0 intro_PICDIMS],[intro_topLeft intro_topLeft+intro_PICDIMS.*intro_RESCALE_FACTOR]);
cont = ['-- press "space" to continue --'];
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press2 = waitForKeyboard(trigger,device);

%instructions for 2 blocker
fontSize = round(23 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS)));
Screen('TextSize',mainWindow,fontSize);
instruct = ['When faced with two people called blockers jumping at the net in front of you, however, these options are no longer available, so the choices change accordingly! In this case, the three options are:'...
    '\n\n  1.    Hit the ball off the blockers hands away from the court (in volleyball, it is a point if they touch it!).'...
    '\n\n  2.    Tip the ball high up and straight over the blockers.'...
    '\n\n  3.    Hit the ball off the blockers hands toward the court.'...
    '\n\n In this scenario, the joystick movements are much sharper- you should not push the joystick forward when moving to the side and should only move slightly forward when tipping!'];   
DrawFormattedText(mainWindow,instruct,intro_textRow,intro_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.75);
Screen('DrawTexture', mainWindow,twoBlocker_texture,[0 0 intro_PICDIMS],[intro_topLeft intro_topLeft+intro_PICDIMS.*intro_RESCALE_FACTOR]);
cont = ['-- press "space" to continue --'];
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press3 = waitForKeyboard(trigger,device);

% back to explaining
fontSize = round(30 * (windowSize.pixels(SIZE_AXIS) / DEFAULT_MONITOR_SIZE(SIZE_AXIS)));
Screen('TextSize',mainWindow,fontSize);
instruct = ['When presented with each scenario, you will have 6 seconds to process '...
    'the image and think about what your response will be. Remember to look at the color '... 
    'jersey the opponent team is wearing-  what color team you are playing matters! '... 
    'Different opponents will have different skill-sets, meaning that the best response for '... 
    'one color team may not be the same for a different color team. (For instance, against a blue team '...
    'you might always want to hit toward the middle person, and against a red team you might always want to tip it over the blockers.)'...
    '\n\n During this 6 second window, you should think about what '...
    'movement you will make, but do not move the joystick yet. After the 6 seconds are up, '...
    'you will then be given a "GO" cue, after which you will have 4 seconds to make your movement. '...
    'Move and HOLD the joystick in the position you want until the 4 seconds are up.'...
    '\n\n -- press "space" to continue --'];

DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press4 = waitForKeyboard(trigger,device);
instruct = ['You will then be shown the outcome of your decision. The correct choice based on what color team you are playing will earn you 1 point, '...
    'while the other choices will not earn you any points. '...
    'Choices that earned a point will be highlighted in green, '...
    'and choices that did not earn you a point will be highlighted in red. '...
    '\n\n If you do not pick one of three proper response options for the specific scenario presented, you will be given an overview of the response options for the two scenarios,'...
    'and you will not earn any points. The more points you finish with the better, '...
    'so make sure to try your best!'...
    '\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press5 = waitForKeyboard(trigger,device);
instruct_time = GetSecs - start_time;

%%
%JOYSTICK TRAINING

instruct = ['You will now practice all the movements using the real stimuli images. '...
    'You will be given directions for which way to hit for each photo, and should perform the motion specified by them. '...
    '\n\n Feedback will be given once you successfully complete each motion. Note that this feedback is dependent'...
    'only on completing the motion, not on whether or not that motion is the correct one for that specifical image!'...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);

% 1. no blocker left- hit line
instruct = ['Here is an example of the no blocker scenario against a white team.\n Try hitting toward the leftmost person! '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, og_scenario_texture(1), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    x=axis(joy, 1);
    y=axis(joy, 2);
    goal = (x<=-.75) && (y<=-.75); %full diagnal line
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
    pause(.05)
end
WaitSecs(2); 


% 2. no blocker left- hit cross court
instruct = ['Here is another example of the no blocker scenario against a white team.\n Try hitting toward the rightmost person. '...
   '\n (Hint: move joystick all the way forward and to the right)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, og_scenario_texture(2), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    x=axis(joy, 1);
    y=axis(joy, 2);
    goal = (x>=.75) && (y<=-.75); %full diagnal cross
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
    pause(.05)
end
WaitSecs(2); 

% 3. no blocker right- hit line
instruct = ['Here is another example of the no blocker scenario against a white team.\n Try hitting toward the rightmost person. '...
   '\n (Hint: move joystick all the way forward and to the right)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, og_scenario_texture(3), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    x=axis(joy, 1);
    y=axis(joy, 2);
    %switch diagnal movements if antenna on right side
    x = -x;
    goal = (x<=-.75) && (y<=-.75); %full diagnal line
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
    pause(.05)
end
WaitSecs(2); 

% 4. no blocker right- hit straight middle
instruct = ['Here is an example of the no blocker scenario against a white team.\n Try hitting toward the middle person. '...
   '\n (Hint: move joystick all the way forward and centered)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, og_scenario_texture(4), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    x=axis(joy, 1);
    y=axis(joy, 2);
    %switch diagnal movements if antenna on right side
    x = -x;
    goal = (y<=-.75) && (x>=-.75)&&(x<=.75); %full straight
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
    pause(.05)
end
WaitSecs(2); 

% 5. double blocker left- shwype
instruct = ['Here is an example of the two blocker scenario against an orange team.\n Try hitting to the left off the blockers hands. '...
   '\n (Hint: move joystick all the way to the left, but not forwards or backwards)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, og_scenario_texture(5), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    x=axis(joy, 1);
    y=axis(joy, 2);
    goal = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
    pause(.05)
end
WaitSecs(2); 

% 6. double blocker left- hit cross
instruct = ['Here is another example of the two blocker scenario against an orange team.\n Try hitting to the right off the blockers hands. '...
   '\n (Hint: move joystick all the way to the right, but not forwards or backwards)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, og_scenario_texture(6), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    x=axis(joy, 1);
    y=axis(joy, 2);
    goal = (x>=.75) && (y>=-.5) && (y<=.5); %sharp cross
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
    pause(.05)
end
WaitSecs(2); 

% 7. double blocker right- shwype
instruct = ['Here is another example of the two blocker scenario against an orange team.\n Try hitting to the right off the blockers hands. '...
   '\n (Hint: move joystick all the way to the right, but not forwards or backwards)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, og_scenario_texture(7), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    x=axis(joy, 1);
    y=axis(joy, 2);
    %switch diagnal movements if antenna on right side
    x = -x;
    goal = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
    pause(.05)
end
WaitSecs(2); 

% 8. double blocker right- tip
instruct = ['Here is another example of the two blocker scenario against an orange team.\n Try gently tipping the ball straight over the blockers. '...
   '\n (Hint: move joystick slightly forward while keeping it centered)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, og_scenario_texture(8), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    x=axis(joy, 1);
    y=axis(joy, 2);
    %switch diagnal movements if antenna on right side
    x = -x;
    goal = (x>=-.75)&&(x<=.75) && (y<=-.1) && (y>=-.75); %tip ahead
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
    pause(.05)
end
WaitSecs(2); 


%%
%FINAL STRINGS
%make sure they actually did it
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

%save how long intro took
train_time = GetSecs - instruct_time - start_time;
total_time = GetSecs - start_time;
save([ppt_dir matlabSaveFile],'SUBJ_NAME','instruct_time', 'train_time','total_time',...
    'intro_press1','intro_press2','intro_press3','intro_press4','intro_press5');  

%end screen
instruct = ['That completes the tutorial! You may now take a brief break before phase one. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);
end
