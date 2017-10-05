% The irrelevant task group will be asked to add the 
% given numbers and report whether they are even or odd. 
SETUP; 
%set button presses to even/odd
UNO = '1'; %even 
DOS='2'; %odd
fingers = [UNO, DOS];
keyCell = {UNO, DOS};
allkeys = fingers;

% define key names so don't have to do it later
for i = 1:length(allkeys)
    keys.code(i,:) = getKeys(allkeys(i));
    keys.map(i,:) = zeros(1,256);
    keys.map(i,keys.code(i,:)) = 1;
end

num_digit_qs = 4; % number of questions per run
digits_promptDur = 3*SPEED;
digits_isi = 1*SPEED;
digits_triggerNext = false;
digits_scale = makeMap({'even','odd'},[0 1],keyCell([1 2]));
condmap = makeMap({'even','odd'});

digitsEK = initEasyKeys('odd_even', SUBJ_NAME, ppt_dir,...
            'default_respmap', digits_scale, ...
            'condmap', condmap, ...
            'trigger_next', digits_triggerNext, ...
            'prompt_dur', digits_promptDur, ...
            'device', device);
        
i=1;
%go through run of 4 numbers
[stim.digitAcc(i), stim.digitRT(i), timing.actualOnsets.math(i)] ...
    = odd_even(digitsEK,num_digit_qs,digits_promptDur,digits_isi,mainWindow, ...
    keyCell([1 2]),COLORS,device,SUBJ_NAME,[SESSION i],slack,INSTANT, keys);
% put 5 s ISI
displayText(mainWindow,'+',INSTANT,'center',COLORS.MAINFONTCOLOR,WRAPCHARS);
WaitSecs(2);

% this closes the structure
endSession(digitsEK, 'Congratulations, you have completed the task!');
