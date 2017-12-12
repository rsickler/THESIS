%%
nest_info = [SESSION i]; 
old_keys = [1 2];
triggerNext = false;
console = false;
files = false;

acc = nan; rt = nan;
CORRECT_COLOR = COLORS.GREEN;
INCORRECT_COLOR = COLORS.RED;
keys1 = keyCell([1 2]);
% loop over digit probes
for digit_q = 1:num_qs
    
    % prepare trial data
    digit_picks = [randi(9) randi(9) randi(9)];
    is_odd = mod(sum(digit_picks),2);
    cresp = is_odd + 1;
    digit_prompt = [num2str(digit_picks(1)) '  +  ' num2str(digit_picks(2)) '  +  ' num2str(digit_picks(3)) '\n\n'];
    prompt_white = '\n\nEVEN                              ODD';
    
    % execute
    DrawFormattedText(window,digit_prompt,'center','center',COLORS.MAINFONTCOLOR,0);
    if digit_q == 1
        onset = Screen('Flip',mainWindow,INSTANT);
        timefirst = onset;
    else
        timespec = ision(digit_q-1) + digits_isi - slack;
        onset = Screen('Flip',window,timespec);
    end
    digitsEK = easyKeys(digitsEK, ...
        'onset', onset, ...
        'stim', digit_prompt, ...
        'nesting', [nest_info digit_q], ...
        'cresp', keys1(cresp), 'cresp_map', keys.map(old_keys(cresp),:), 'valid_map', sum(keys.map(old_keys,:)));
    timespec = onset + digits_promptDur - slack;
    ision(digit_q) = isi_specific(window,COLORS.MAINFONTCOLOR,timespec);
end % loop over q's

% save summary stats
acc = mean(digitsEK.trials.acc);
valid_rts = ~isnan(digitsEK.trials.rt);
if sum(valid_rts) > 0
    rt = mean(digitsEK.trials.rt(valid_rts));
else rt = nan;
end
save([ppt_dir matlabSaveFile], 'acc', 'valid_rts', 'rt'); 
