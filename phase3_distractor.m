% The irrelevant task group will be asked to add the 
% given numbers and report whether they are even or odd. 

function phase3_distractor(SUBJECT,SUBJ_NAME,SESSION)
SETUP; 
instruct = 'Loading Phase 3...';
displayText(mainWindow, instruct, INSTANT, 'center',COLORS.MAINFONTCOLOR, WRAPCHARS);

%set button presses to even/odd
UNO = '1'; %even 
DOS = '2'; %odd
keys = [UNO, DOS];
keyCell = {UNO, DOS};

%set up stimuli presentation conditions
num_qs = 4; % number of questions per run
digits_promptDur = 3*SPEED;
digits_isi = 1*SPEED;
digits_triggerNext = false;

%make maps
digits_scale = makeMap({'even','odd'},[0 1],keyCell([1 2]));
condmap = makeMap({'even','odd'});

%SET UP SUBJECT DATA 
% matlab save file
matlabSaveFile = ['DATA_' num2str(SUBJECT) '_' num2str(SESSION) '_' datestr(now,'ddmmmyy_HHMM') '.mat'];
data_dir = fullfile(workingDir, 'MRI_Data');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep SUBJ_NAME filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

digitsEK = initEasyKeys('odd_even', SUBJ_NAME, ppt_dir,...
            'default_respmap', digits_scale, ...
            'condmap', condmap, ...
            'trigger_next', digits_triggerNext, ...
            'prompt_dur', digits_promptDur, ...
            'device', device);
        
subjectiveEK = easyKeys(subjectiveEK, ...
    'onset', timing.actualOnsets.vis(n), ...
    'stim', stim.stim{stim.trial}, ...
    'cond', stim.cond(stim.trial), ...
    'cresp', cresp, 'cresp_map', cresp_map, 'valid_map', subj_map);


%go through i number of runs
%go through j numbers for each run
i = 1; 
j = 1;
[stim.digitAcc(i), stim.digitRT(i), timing.actualOnsets.math(i)] ...
    = odd_even(digitsEK,num_qs,digits_promptDur,digits_isi,mainWindow, ...
    keyCell([1 2]),COLORS,device,SUBJ_NAME,[SESSION i],slack,INSTANT, keys);

% put 5 s ISI
displayText(mainWindow,'+',INSTANT,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
WaitSecs(2);

% this closes the structure
endSession(digitsEK, 'Congratulations, you have completed the task!');

end

