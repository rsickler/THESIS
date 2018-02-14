

% WALK THROUGH REAL SCENARIOS
%make image textures
SETUP; 
N_images = length(og_scenarios);
for i = 1:N_images
    og_scenario_matrix = double(imread(fullfile(og_scenario_Folder,og_scenarios{i})));
    og_scenario_texture(i) = Screen('MakeTexture', mainWindow, og_scenario_matrix);
    og_correct_matrix = double(imread(fullfile(og_correct_Folder,og_corrects{i})));
    og_correct_texture(i) = Screen('MakeTexture', mainWindow, og_correct_matrix);
    og_inc1_matrix = double(imread(fullfile(og_inc1_Folder,og_inc1s{i})));
    og_inc1_texture(i) = Screen('MakeTexture', mainWindow, og_inc1_matrix);
    og_inc2_matrix = double(imread(fullfile(og_inc2_Folder,og_inc2s{i})));
    og_inc2_texture(i) = Screen('MakeTexture', mainWindow, og_inc2_matrix);
end

instruct = ['You will now go through a practice round using the actual scenarios. '...
    'You will be given directions for which way to hit and be shown the feedback you would see in the real experiment. . '...
    '\n\nNote that this is only a training round, and that the movements you will be instructed to do here are not necessarily the correct movements during the real experiment!'...
    '\n\n\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
intro_press1 = waitForKeyboard(trigger,device);


% 1. single blocker left- hit line
instruct = ['Here is an example of a single blocker scenario.\n Try hitting toward the leftmost person! '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, og_scenario_texture(1), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    goal = (x<=-.75) && (y<=-.75); %full diagnal line
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        Screen('Flip',mainWindow, INSTANT);s
    end
end
WaitSecs(2); 

% 2. single blocker left- hit cross court
instruct = ['Here is another example of a single blocker scenario.\n Try hitting toward the leftmost person. '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, og_scenario_texture(1), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
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
        DrawFormattedText(mainWindow,good,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        Screen('Flip',mainWindow, INSTANT);s
    end
end
WaitSecs(2); 

% 3. single blocker right- hit line
instruct = ['Here is an example of a single blocker scenario.\n Try hitting toward the leftmost person. '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, og_scenario_texture(1), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    %switch diagnal movements if antenna on right side
    if this_pic(2) == 'R'
        x = -x;
    end
    goal = (x<=-.75) && (y<=0.5); %full diagnal line
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        Screen('Flip',mainWindow, INSTANT);s
    end
end
WaitSecs(2); 

% 4. single blocker right- hit straight middle
instruct = ['Here is an example of a single blocker scenario.\n Try hitting toward the leftmost person. '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, og_scenario_texture(1), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    %switch diagnal movements if antenna on right side
    if this_pic(2) == 'R'
        x = -x;
    end
    goal = (x<=-.75) && (y<=0.5); %full diagnal line
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        Screen('Flip',mainWindow, INSTANT);s
    end
end
WaitSecs(2); 

% 5. double blocker left- shwype
instruct = ['Here is an example of a single blocker scenario.\n Try hitting toward the leftmost person. '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, og_scenario_texture(1), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
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
        DrawFormattedText(mainWindow,good,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        Screen('Flip',mainWindow, INSTANT);s
    end
end
WaitSecs(2); 

% 6. double blocker left- hit cross
instruct = ['Here is an example of a single blocker scenario.\n Try hitting toward the leftmost person. '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, og_scenario_texture(1), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
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
        DrawFormattedText(mainWindow,good,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        Screen('Flip',mainWindow, INSTANT);s
    end
end
WaitSecs(2); 

% 7. double blocker right- shwype
instruct = ['Here is an example of a single blocker scenario.\n Try hitting toward the leftmost person. '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, og_scenario_texture(1), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    %switch diagnal movements if antenna on right side
    if this_pic(2) == 'R'
        x = -x;
    end
    goal = (x<=-.75) && (y<=0.5); %full diagnal line
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        Screen('Flip',mainWindow, INSTANT);s
    end
end
WaitSecs(2); 

% 8. double blocker right- tip
instruct = ['Here is an example of a single blocker scenario.\n Try hitting toward the leftmost person. '...
   '\n (Hint: move joystick all the way forward and to the left)']; 
DrawFormattedText(mainWindow,instruct,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('DrawTexture', mainWindow, og_scenario_texture(1), [0 0 s_PICDIMS],[s_topLeft s_topLeft+s_PICDIMS.*s_RESCALE_FACTOR]);
Screen('Flip',mainWindow, INSTANT);
done = 0; 
good = 'Good!';
while ~done 
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    %switch diagnal movements if antenna on right side
    if this_pic(2) == 'R'
        x = -x;
    end
    goal = (x<=-.75) && (y<=0.5); %full diagnal line
    if goal
        done = 1; 
        DrawFormattedText(mainWindow,good,'center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, og_correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],10);
        Screen('Flip',mainWindow, INSTANT);s
    end
end
WaitSecs(2); 




%%
% oldies

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
WaitSecs(2); 
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
WaitSecs(2); 
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
WaitSecs(2); 
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
test = '1. Try hitting the ball off the block out of bounds off the block by moving (and holding) the joystick all the way toward the left.';
DrawFormattedText(mainWindow,test,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(2); 
done = 0; 
while ~done
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    goal = (x<=-.75) && (y>=-.5) && (y<=.5); %shwype
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
WaitSecs(2); 
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
test = '3. Try hitting the ball sharp across the court by moving (and holding) the joystick all the way toward the right.';
DrawFormattedText(mainWindow,test,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(2); 
done = 0; 
while ~done
    tEnd=GetSecs+2;
    while GetSecs<tEnd
        x=axis(joy, 1);
        y=axis(joy, 2);
        pause(.05)
    end
    goal = (x>=.75) && (y>=-.5) && (y<=.5); %sharp cross
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
