% The irrelevant task group will be asked to add the 
% given numbers and report whether they are even or odd. 
%  2s --> 4s --> 4s--> 4s

function phase3_distractor(SUBJECT,SUBJ_NAME,SESSION)
SETUP; 
instruct = 'Loading Phase 3...';
displayText(mainWindow, instruct, INSTANT, 'center',COLORS.MAINFONTCOLOR, WRAPCHARS);

% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'BehavioralData');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

%set button presses to for feedback
ONE = '1';
TWO = '2';
KEYS = [ONE TWO];
keyCell = {ONE, TWO};
cresp = keyCell(1:2); 
digits_keys = keyCell;
allkeys = KEYS;
% define key names
for i = 1:length(allkeys)
    keys.code(i,:) = getKeys(allkeys(i));
    keys.map(i,:) = zeros(1,256);
    keys.map(i,keys.code(i,:)) = 1;
end

%make maps
digits_map = sum(keys.map([1:2],:)); 
digits_scale = makeMap({'even','odd'},[0 1],keyCell([1 2]));
cond_map = makeMap({'even', 'odd'});

% GIVE INTRO
%explanation of task 
instruct = ['you will be performing addition of three numbers'...
    '\n\n-- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
press1 = waitForKeyboard(trigger,device);


% SET UP PRECISE TIMING 
digits_promptDur = 4*SPEED; % length digits on screen
digits_isi = 0*SPEED; % length ISI
digits_listenDur = 0;
digits_triggerNext = false; 
runStart = GetSecs;

% initialize structure
digitsEK = initEasyKeys(['phase3_distractor' '_SUB'], SUBJ_NAME,ppt_dir, ...
    'default_respmap', digits_scale, ...
    'condmap', cond_map, ...
    'trigger_next', digits_triggerNext, ...
    'prompt_dur', digits_promptDur, ...
    'listen_dur', digits_listenDur, ...
    'exp_onset', runStart, ...
    'console', false, ...
    'device', -1);
digitsEK = startSession(digitsEK); 

%% RUN TRIALS

% 5 rounds of 3 problems each
num_rounds = 5; 
num_qs = 3;

timing.plannedOnsets.ITI(trial) = runStart;
timing.plannedOnsets.math(trial) = runStart;

for round = 1:num_rounds
    WaitSecs(2);
    [digitAcc(round), digitRT(round), actualOnsets(round)] ...
    = odd_even(digitsEK,num_qs,digits_promptDur,digits_isi,mainWindow, ...
    keyCell([1 2]),COLORS,device,SUBJ_NAME,[SESSION round],slack,INSTANT, keys);
end

%% close up shop
% put final 2s ISI
displayText(mainWindow,'+',INSTANT,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
WaitSecs(2);

% close the structure
endSession(digitsEK);

% save final variables
save([ppt_dir matlabSaveFile], 'stim', 'timing', 'digitAcc','digitRT','actualOnsets');  

%present closing screen
instruct = ['That completes the third phase! You may now take a brief break before phase four. Press enter when you are ready to continue.' ...
    '\n\n\n\n -- press "enter" to continue --'];
DrawFormattedText(mainWindow,instruct,'center','center',COLORS.MAINFONTCOLOR,WRAPCHARS);
Screen('Flip',mainWindow, INSTANT);
end_press = waitForKeyboard(trigger,device);

end

