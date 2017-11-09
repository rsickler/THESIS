function INTRO(SUBJECT,SESSION)

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
intro_textRow = windowSize.pixels(2) *(.08);
intro_picRow = windowSize.pixels(2) *(.65);
cont_textRow = windowSize.pixels(2) *(.93); 
intro_topLeft(HORIZONTAL) = CENTER(HORIZONTAL) - (intro_PICDIMS(HORIZONTAL)*intro_RESCALE_FACTOR(HORIZONTAL))/2;
intro_topLeft(VERTICAL) = intro_picRow - (intro_PICDIMS(VERTICAL)*intro_RESCALE_FACTOR(VERTICAL))/2;

% present experiment summary
instruct = ['Hello! \n\n' ...
    'In this experiment, you will be presented with images of two different scenarios ' ...
    'from a volleyball game. In both scenarios, your goal is to score a point by "hitting" ' ...
    'the ball down on the opponents side of the court. You will be faced with people at '...
    'the net trying to "block" your hit, as well as three defenders trying to prevent the '...
    'ball from hitting the ground. For each scenario, you will have three different '...
    'response options- each representing a different place to hit the ball toward. ' ...
    '\n\nIt is important that you learn these now, as you will need to be able to choose the proper response based which situation you are in throughout our study.'...
    '\n\n\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);

%instructions for 1 blocker
instruct = ['When faced with a single blocker, your three options are:'...
    '\n\n  1.    Hit deep down the line- hit the ball towards the person on the same side of the net as you.'...
    '\n\n  2.    Hit deep straight- hit the ball straight ahead towards the center person.' ...
    '\n\n  3.    Hit deep across the court- hit toward the farthest person on the other side of the court.'...
    '\n\nThe joystick movements associated with each of these three options are shown below. '...
    'Notice the movements are flipped depending on which side of the court you are hitting from!'];
introFont = 23;
Screen('TextSize',mainWindow,introFont);
DrawFormattedText(mainWindow,instruct,intro_textRow,intro_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.6);
Screen('DrawTexture', mainWindow,oneBlocker_texture,[0 0 intro_PICDIMS],[intro_topLeft intro_topLeft+intro_PICDIMS.*intro_RESCALE_FACTOR]);
cont = ['-- press "enter" to continue --'];
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.6);
Screen('Flip',mainWindow, INSTANT);
intro_press2 = waitForKeyboard(trigger,device);

%instructions for 2 blocker
instruct = ['When faced with two blockers, however, the options change accordingly! In this case, the only three options are:'...
    '\n\n  1.    "Tool" the block- hit the ball off the blockers hands away from the court.'...
    '\n\n  2.    Tip it straight over- just gently tap the ball straight ahead so that it falls right behind the blockers.' ...
    '\n\n  3.    Hit sharp across the cross- hit toward the farthest person on the other side of the court.'...
    '\n\nThe joystick movements associated with each of these three options are shown below. '...
    'In this scenario, the joystick movements extend much shorter vertically- how far forward you move the joystick is important!'];
DrawFormattedText(mainWindow,instruct,intro_textRow,intro_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.65);
Screen('DrawTexture', mainWindow,twoBlocker_texture,[0 0 intro_PICDIMS],[intro_topLeft intro_topLeft+intro_PICDIMS.*intro_RESCALE_FACTOR]);
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS*1.6);
Screen('Flip',mainWindow, INSTANT);
intro_press3 = waitForKeyboard(trigger,device);

% back to explaining
Screen('TextSize',mainWindow,MAINFONTSIZE);
instruct = ['When presented with these scenarios, you will have 4 seconds to process '...
    'the image and think about what your response will be. Remember to look at the color '... 
    'jersey of the opponent team-  who you are playing matters! '... 
    'Different opponents will have different skill-sets, meaning that the best response for '... 
    'one team may not be the same for a different team.'...
    '\n\n You should think about what '...
    'movement you will make, but do not move the joystick yet. After the 4 seconds are up, '...
    'you will then be given a "GO" cue, after which you will have 2 seconds to make your movement. '...
    'Move and hold the joystick where you want it until the 2 seconds are up!'...
    '\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS*1.2);
Screen('Flip',mainWindow, INSTANT);
intro_press4 = waitForKeyboard(trigger,device);
instruct = ['You will then be shown the outcome of your decision. The "best" choice will earn you one point most of the time, '...
    'while the other choices will only earn you the point a small percent of the time. '...
    '"Correct" choices (indicating you earned a point) will be highlighted in green, '...
    'and "incorrect" choices (indicating you did not earn a point) in red. '...
    '\n\n If you do not pick one of three proper response options, you will be given a recap of them, '...
    'and you will not earn any points. At the end of the study, you will earn cash proportional to how many points you finish with!'...
    '\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS*1.2);
Screen('Flip',mainWindow, INSTANT);
intro_press5 = waitForKeyboard(trigger,device);

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
test = '1. Try hitting down the line by moving (and holding) the joystick all the way forward and toward your body.';
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
    ' Here are the three options against a single block again, starting from the left side of the court:'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,oneTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '2. Try hitting straight ahead by moving (and holding) the joystick all the way forward and centered.';
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
    ' Here are the three options against a single block again, starting from the left side of the court:'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,oneTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '3. Try hitting the ball deep across the court by moving (and holding) the joystick straight ahead by moving (and holding) the joystick all the way forward and away from your body.';
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
instruct = ['Now here are the three options against a double block, starting from the left side of the court as well. '... 
    'Remember, here you do not move the joystick all the way forward!'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,twoTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '1. Try tooling the ball out of bounds off the block by moving (and holding) the joystick slightly forward and all the way toward your body.';
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
instruct = ['Now here are the three options against a double block, starting from the left side of the court as well. '... 
    'Remember, here you do not move the joystick all the way forward!'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,twoTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '2. Try tipping the ball just over the block by moving (and holding) the joystick slightly forward and centered.';
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
instruct = ['Now here are the three options against a double block, starting from the left side of the court as well. '... 
    'Remember, here you do not move the joystick all the way forward!'];
DrawFormattedText(mainWindow,instruct,'center',test_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow,twoTest_texture,[0 0 test_PICDIMS],[test_topLeft test_topLeft+test_PICDIMS.*test_RESCALE_FACTOR]);
test = '3. Try hitting the ball sharp across the court by moving (and holding) the joystick straight ahead by moving the joystick slightly forward and al the way away from your body.';
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

%make sure they actually did it
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end
MATLAB_SAVE_FILE = [ppt_dir matlabSaveFile];

save(matlabSaveFile, 'stim', 'timing');  

end