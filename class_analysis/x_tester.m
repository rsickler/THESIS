scenario_sequence = strcat(round_sequence,'.jpg');
trial = 1; 
x = [];
y = [];
while trial <= length(scenario_sequence)
     this_pic = scenario_sequence{trial};
     if this_pic(2) == 'L' %if left
         x(end+1) = X(trial);
         y(end+1) = Y(trial);
     end
     trial = trial+1;
end

