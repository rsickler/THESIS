function [acc rt timefirst] = odd_even(digitsEK,num_qs,q_dur,isi_dur,window,keys,COLORS,DEVICE,SUBJ_NAME, nest_info,SLACK,timespecFirst, keysObject)

% initialize
old_keys = [1 2];
triggerNext = false; %changed because presentation has to be the same!!!!
console = false;
files = false;

acc = nan; rt = nan;
CORRECT_COLOR = COLORS.GREEN;
INCORRECT_COLOR = COLORS.RED;
% loop over digit probes
for digit_q = 1:num_qs
    
    % prepare trial data
    digit_picks = [0 0];
    while sum(digit_picks) <= 10
        digit_picks = [randi(9) randi(9)];
    end
    is_odd = mod(sum(digit_picks),2);
    
    digit_prompt = [num2str(digit_picks(1)) '  +  ' num2str(digit_picks(2)) '\n\n'];
    prompt_white = '\n\nEVEN                              ODD';
    
    cresp = is_odd + 1;
    
    % execute
    DrawFormattedText(window,digit_prompt,'center','center',COLORS.MAINFONTCOLOR,0);
    if digit_q == 1
        onset = Screen('Flip',window,timespecFirst);
        timefirst = onset;
    else
        timespec = ision(digit_q-1) + isi_dur - SLACK;
        onset = Screen('Flip',window,timespec);
    end
    digitsEK = easyKeys(digitsEK, ...
        'onset', onset, ...
        'stim', digit_prompt, ...
        'nesting', [nest_info digit_q], ...
        'cresp', keys(cresp), 'cresp_map', keysObject.map(old_keys(cresp),:), 'valid_map', sum(keysObject.map(old_keys,:)));
    timespec = onset + q_dur - SLACK;
    ision(digit_q) = isi_specific(window,COLORS.MAINFONTCOLOR,timespec);
end % loop over q's

% summary stats
acc = mean(digitsEK.trials.acc);
valid_rts = ~isnan(digitsEK.trials.rt);
if sum(valid_rts) > 0
    rt = mean(digitsEK.trials.rt(valid_rts));
else rt = nan;
end

return