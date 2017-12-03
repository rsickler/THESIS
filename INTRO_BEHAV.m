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
    '\n\n For each scenario, you will have three different '...
    'response options- each representing a different direction to hit the ball. ' ...
    '\n\n It is important that you learn these now, as you will need to be able to choose the proper response based which situation you are in throughout the study.'...
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
    '\n\n  1.    Hit the ball off the blockers hands away from the court (in volleyball, it?s a point if they touch it!).'...
    '\n\n  2.    Gently tip the ball straight over the blockers.'...
    '\n\n  3.    Hit the ball inside the blockers toward the defender on the other side of the court.'...
    '\n\n In this scenario, the joystick movements are much sharper, in that you should not push the joystick all the way forward. '...
    'How far vertically you move the joystick is just as important as horizontally!'];   
DrawFormattedText(mainWindow,instruct,intro_textRow,intro_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.75);
Screen('DrawTexture', mainWindow,twoBlocker_texture,[0 0 intro_PICDIMS],[intro_topLeft intro_topLeft+intro_PICDIMS.*intro_RESCALE_FACTOR]);
instruct2 = ['In this scenario, the joystick movements are much sharper, in that you should not push the joystick all the way forward. '...
    'How far vertically you move the joystick is just as important as horizontally!'];
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
    'Move and HOLD the joystick in the position you want until the 2 seconds are up!'...
    '\n\n -- press "enter" to continue --'];

DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press4 = waitForKeyboard(trigger,device);
instruct = ['You will then be shown the outcome of your decision. The "best" choice will earn you one point most of the time, '...
    'while the other choices will only earn you a point a small percent of the time. '...
    'Choices that earned a point will be highlighted in green, '...
    'and choices that did not earn you a point will be highlighted in red. '...
    '\n\n \n\n If you do not pick one of three proper response options for the specific scenario presented, you will be given a recap of the response options, '...
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
save(matlabSaveFile,'SUBJ_NAME','instruct_time', 'train_time','total_time',...
    'intro_press1','intro_press2','intro_press3','intro_press4','intro_press5');  
end