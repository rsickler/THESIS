function INTRO_CLASS_TRAIN(SUBJECT, SUBJ_NAME, SESSION, ROUND)

%SETUP 
class_SETUP;

%load intro joystick training photo
otherFolder = fullfile(workingDir, 'stimuli/CLASSIFIER');
class_intro_matrix = double(imread(fullfile(otherFolder,'classifier_intro.jpeg')));
class_intro_texture = Screen('MakeTexture', mainWindow, class_intro_matrix);
% load incorrect movement image
classFolder = fullfile(workingDir, 'stimuli/CLASSIFIER');
incorrect_matrix = double(imread(fullfile(classFolder,'class_incorrect.jpeg')));
incorrect_texture = Screen('MakeTexture', mainWindow, incorrect_matrix);
% load demo photo
scenario_matrix = double(imread(fullfile(class_scenario_Folder,class_scenarios{1})));
scenario_texture = Screen('MakeTexture', mainWindow, scenario_matrix);

% present experiment summary
start_time = GetSecs;
instruct = ['Hello! \n\n' ...
    'In this first half of the experiment, you will be presented with different images of a scenario ' ...
    'from a volleyball game. Your goal is to score a point by "hitting" ' ...
    'the ball toward the correct defender as specified by the directions given above the image. '...
    '\n\n For each image, you will have three different potential '...
    'response options- each corresponding to one of the three different defenders. ' ...
    '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end

%instructions for no blocker scenario
instruct = ['These three response options are:'...
    '\n  1.    Hit the ball towards the leftmost defender.'...
    '\n  2.    Hit the ball towards the middle defender.' ...
    '\n  3.    Hit the ball towards the rightmost defender.'...
    '\n\n The joystick movements associated with each of these three options are shown below.'];
DrawFormattedText(mainWindow,instruct,intro_textRow,intro_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,class_intro_texture,[0 0 intro_PICDIMS],[intro_topLeft intro_topLeft+intro_PICDIMS.*intro_RESCALE_FACTOR]);
cont = ['-- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end

% back to explaining
Screen('TextSize',mainWindow,MAINFONTSIZE);
instruct = ['When presented with each scenario, you will see directions above the image corresponding ' ...
    'to which person you should hit the ball toward. You will have 4 seconds to process '...
    'the image and directions. During this 4 second window, you should figure out which movement to make, '...
    'but do not move the joystick yet. '...
    '\n\n After the 4 seconds are up, '...
    'you will then be given a "GO" cue, after which you will have 4 seconds to make the proper movement. '...
    ' You should then move and HOLD the joystick in the position you are directed until the 4 seconds are up- '...
    ' do not stop holding the joystick in place until these 4 seconds are over!'...
    '\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end

instruct = ['You will then be shown the outcome of your decision. Making the correct movement as given by the directions will earn you one point. '...
    '\n If you do not make the proper designated movement, you will be given a recap of the joystick movement options, '...
    'and you will not earn any points.'...
    '\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while x < .75 x=axis(joy, 1); end

instruct = ['After receiving this feedback, you will then be required to perform a number task three times. '...
    'Each time, you will be presented with three numbers on the screen and have 4 seconds to determine '...
    'whether the sum of those three numbers is odd or even. '...
    '\n\n  If the sum is odd, you should move the joystick to the LEFT. \n If the sum is even, you should move the joystick to the RIGHT.'...
    '\n Make sure to sumbit your answer before the 4 seconds are up! '...
    '\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while x < .75 x=axis(joy, 1); end

instruct = ['You will now practice the three movements using real stimuli images. '...
    'You will be given directions for which way to hit for each photo, and should perform the motion specified by them. '...
    '\n\n Feedback will be given once you successfully complete each motion.'...
    '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while x < .75 x=axis(joy, 1); end

% 1. no blocker right- hit left
instruct = ['Try hitting toward the leftmost person! '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, scenario_texture, [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
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

% 2. no blocker right- hit middle 
instruct = ['Try hitting toward the middle person!'...
   '\n (Hint: move joystick all the way forward and centered)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, scenario_texture, [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    x=axis(joy, 1);
    y=axis(joy, 2);
    goal = (y<=-.75) && (x>=-.75)&&(x<=.75); %full straight
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('Flip',mainWindow, INSTANT);
    end
    pause(.05)
end
WaitSecs(2); 

% 3. no blocker right- hit right
instruct = ['Try hitting toward the rightmost person. '...
   '\n (Hint: move joystick all the way forward and to the right)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.5);
Screen('DrawTexture', mainWindow, scenario_texture, [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
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

%make sure they actually did it
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' num2str(ROUND) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

%save how long intro took
total_time = GetSecs - start_time;
save([ppt_dir matlabSaveFile],'SUBJ_NAME','total_time');  

%end screen
instruct = ['That completes the intro! You may now take a brief break before beginning the first round. Move right when you are ready to begin.' ...
    '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while x < .75 x=axis(joy, 1); end

end