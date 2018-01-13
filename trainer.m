

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

