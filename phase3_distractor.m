% The irrelevant task group will be asked to add the 
% given numbers and report whether they are even or odd. 
%  2s --> 4s --> 4s--> 4s

function phase3_distractor(SUBJECT,SUBJ_NAME,SESSION)
SETUP; 
instruct = 'Loading Phase 3...';
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);

% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

% GIVE INTRO
%explanation of task 
instruct = ['In this part of the experiment, you will be performing a numbers task '...
    'comprised of adding three numbers to determine whether their sum is odd or even. '...
    'Each time, you will be presented with three numbers on the screen and have 4 seconds to determine your answer.'...
    '\n\n  If the sum is odd, you should move the joystick to the LEFT. \n If the sum is even, you should move the joystick to the RIGHT.'...
    '\n Make sure to submit your answer before the 4 seconds are up! '...
    '\n\n-- press "space" to continue --'];

DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
press1 = waitForKeyboard(trigger,device);


%% SET UP MATH
num_qs = 3;
digits_promptDur = 4*SPEED; % length digits on screen
digits_isi = 0*SPEED; 
stim.mathISIDuration = 2*SPEED;
stim.mathDuration = 12*SPEED;
config.TR = stim.TRlength;
config.nTRs.mathISI = stim.mathISIDuration/stim.TRlength;
config.nTRs.math = stim.mathDuration/stim.TRlength;
config.nTrials = 32;
config.nTRs.perTrial = config.nTRs.mathISI + config.nTRs.math;
config.nTRs.perBlock = (config.nTRs.perTrial)*config.nTrials+ config.nTRs.ISI; %includes the last ISI

%% run trials
trial = 1; 
runStart = GetSecs;
while trial <= config.nTrials
    %set timings
    timing.plannedOnsets.mathISI(trial) = runStart;
    if trial > 1
        timing.plannedOnsets.mathISI(trial) = timing.plannedOnsets.mathISI(trial-1) + config.nTRs.perTrial*config.TR;
    end
    timing.plannedOnsets.math(trial) = timing.plannedOnsets.mathISI(trial) + config.nTRs.mathISI*config.TR;
    % pre-math ISI
    timespec = timing.plannedOnsets.mathISI(trial)-slack;
    timing.actualOnsets.mathISI(trial) = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
    % DO MATH- 1 round of 3 problems
    timespec = timing.plannedOnsets.math(trial)-slack;
    [digitAcc(trial), timing.actualOnsets.math(trial)] ...
        = odd_even_joy(num_qs,digits_promptDur,digits_isi,mainWindow,stim.textRow, ...
        COLORS,device,slack,timespec);
    %update trial
    trial= trial+1;
end
% throw up a final ISI
timing.plannedOnsets.lastISI = timing.plannedOnsets.math(end) + config.nTRs.math*config.TR;
timespec = timing.plannedOnsets.lastISI-slack;
timing.actualOnset.finalISI = start_time_func(mainWindow,'+','center',COLORS.MAINFONTCOLOR,WRAPCHARS,timespec);
WaitSecs(2); 

%% close up shop
% save final variables
save([ppt_dir matlabSaveFile], 'digitAcc','timing','config');  

%present closing screen
instruct = ['That completes the third phase! You may now take a brief break before phase four. Press space when you are ready to continue.' ...
    '\n\n\n\n -- press "space" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end
