function INTRO_CLASS_IMAGERY(SUBJECT, SUBJ_NAME, SESSION, ROUND)

%SETUP 
class_SETUP; 
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
%save intro data
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' num2str(ROUND) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end


% present experiment summary
start_time = GetSecs;
instruct = ['You will now begin the second half of the experiment. \n\n' ...
    'In this half, you will be presented with the same images as before,'...
    'following the same basic procedure of one image trial being followed by three iterations of the number task.'...
    '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end

%instructions for visualization change
instruct = ['However, during this half of the experiment, you will no longer be '...
    'actually moving the joystick during the "Go!" phase of each trial. Instead, you should '...
    'mentally imagine moving the joystick in the proper direction specified above each image, '...
    'but should not actually move the joystick. \n\n As you do so, IMAGINE MOVING AND HOLDING '...
    'the joystick in the proper position, in real time over the same 4 second window as you did before. '...
    'Try to mentally simulate the sensation of initiating, making, and holding each specific movement '...
    'of the joystick as vividly as you can- the more effort you put into this here, the better our data!'...
        '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end

%instructions for visualization change
instruct = ['To aid you in this visualization phase, we will present you with auditory "beep" cues ' ...
    'to tell you when to close and open your eyes. You should close your eyes on the first beep, which starts ' ...
    'right after the image and directions are done being presented, and leave them closed while you perform the mental imagery ' ...
    'of the specified movement. You will then be presented with a second beep after the 4 second visualization phase is up, ' ...
    'letting you know it is time to open your eyes. Please close your eyes right away at the sound of the first beep, and keep them ' ...
    'closed the whole time until you here the second beep!'...
        '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end

%instructions for feedback rating
instruct = ['Lastly, following this imagery phase, instead of seeing the outcome of your '...
    'imagined joystick movement as you did before, you will be asked to provide feedback '...
    'on the quality and vividness of the mental image you constructed during that specific trial'...
    'It is at this point where you will be using the joystick to report this feedback, moving in the direction '...
    'that corresponds to the imagery vivIdness. You will have only 2 seconds to report this feedback, so please try '...
    'to respond quickly, and make sure you hold the joystick in the chosen direction until the end of the 2 seconds. '...
    '\n The feedback prompt you will see during this window will be shown on the next screen. '...
    'Please take the time to familiarize yourself with it so that you can report answers efficiently from the start.'...
    '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end


%show vividness screen
Screen('DrawTexture', mainWindow, vividness_texture,[0 0 v_PICDIMS],[v_topLeft v_topLeft+v_PICDIMS.*v_RESCALE_FACTOR]);
cont = ['-- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,cont,'center',cont_textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while (x < .75) x=axis(joy, 1); end

%end screen
instruct = ['That completes the intro! Remember, you will be IMAGINING moving the joystick during the "Go" phase now instead, '...
    'and you should close/open your eyes to the sound of the beep. You should only move the joystick when reporting your imagery feedback ' ...
    'NOT while doing the mental imagery! '...
    '\n\n You may now take a brief break before beginning the next round. Move right when you are ready to begin.' ...
    '\n\n\n\n -- move the joystick RIGHT to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
WaitSecs(5); 
x = 0; 
while x < .75 x=axis(joy, 1); end


total_time = GetSecs - start_time;
save([ppt_dir matlabSaveFile],'SUBJ_NAME','total_time');  

end