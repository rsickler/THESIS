% (1) regressor
% dimension: 3 x #TRS
% - each row is a different category (left/right/middle)
% - each column is a TR (1 if it's that)
% - make sure you shift EVERY LABEL BY 2 TR's (4 seconds)

%% load all data
workingDir = '/Users/treysickler/Documents/MATLAB/THESIS/BehavioralData';
subj_folder = {};
DirList1_1 = {};
DirList1_2 = {};
DirList2_1 = {};
DirList2_2 = {};
data1_2 = {};
data1_2 = {};
data2_1 = {};
data2_2 = {};
for i = 1:48
    subj = num2str(i);
    subj_folder_1{i} = fullfile(workingDir, subj);
    DirList{i} = dir(fullfile(subj_folder_1{i}, 'DATA_*_1_*.mat'));
    p1_data{i} = load(fullfile(subj_folder_1{i},DirList{i}.name));
end
for i = 1:4
    subj = num2str(i+100);
    subj_folder{i} = fullfile(workingDir, subj);
    DirList1_1{i} = dir(fullfile(subj_folder{i}, 'DATA_10*_1_1_*.mat'));
    DirList1_2{i} = dir(fullfile(subj_folder{i}, 'DATA_10*_1_2_*.mat'));
    DirList2_1{i} = dir(fullfile(subj_folder{i}, 'DATA_10*_2_1_*.mat'));
    DirList2_2{i} = dir(fullfile(subj_folder{i}, 'DATA_10*_2_2_*.mat'));
    data1_1{i} = load(fullfile(subj_folder{i},DirList1_1{i}.name));
    data1_2{i} = load(fullfile(subj_folder{i},DirList1_2{i}.name));
    data2_1{i} = load(fullfile(subj_folder{i},DirList2_1{i}.name));
    data2_2{i} = load(fullfile(subj_folder{i},DirList2_2{i}.name));
end

%% find training round sequence and responses, imagery round sequence
for i = 1:4 %training
    round_seq1_1{i} = data1_1{1, i}.round_sequence;
    round_seq1_2{i} = data1_2{1, i}.round_sequence;
    train_responses1_1{i} = data1_1{1, i}.train_responses;
    train_responses1_2{i} = data1_2{1, i}.train_responses;
    round_seq2_1{i} = data2_1{1, i}.scenario_sequence;
    round_seq2_2{i} = data2_2{1, i}.scenario_sequence;
    X1_1{i} = data1_1{1, i}.X;
    X1_2{i} = data1_2{1, i}.X;
    Y1_1{i} = data1_1{1, i}.Y;
    Y1_2{i} = data1_2{1, i}.Y;
end

%% find which ones they got correct in each (using criterion at scan time)
correct1_1 = zeros(4,24);
correct1_2 = zeros(4,24);
for i = 1:4
    current_subj1_1 = train_responses1_1{i};
    current_subj1_2 = train_responses1_2{i};
    rights_1 = 0;
    rights_2 = 0;
    for j = 1:length(current_subj1_1)
        if current_subj1_1{j}(1) == 'c'
            rights_1 =rights_1+1;
            correct1_1(i,j) = 1;
        end
        if current_subj1_2{j}(1) == 'c'
            rights_2 =rights_2+1;
            correct1_2(i,j) = 1;
        end
    end
    correct_totals1_1(i) = rights_1;
    correct_totals1_2(i) = rights_2;
end

%% USE MORE LENIANT CRITERION FOR CORRECTS
Lcorrect1_1 = zeros(4,24);
Lcorrect1_2 = zeros(4,24);
for i = 1:4
    Lcurrent_X1_1 = X1_1{i};
    Lcurrent_X1_2 = X1_2{i};
    Lcurrent_Y1_1 = Y1_1{i};
    Lcurrent_Y1_2 = Y1_2{i};
    Lrights_1 = 0;
    Lrights_2 = 0;
    Lround1_1 = round_seq1_1{i};
    Lround1_2 = round_seq1_2{i};
    for j = 1:length(Lcurrent_X1_1)
        if (Lround1_1{j}(2) == 'L') && (Lcurrent_X1_1(j)<0)
            Lrights_1 =Lrights_1+1;
            Lcorrect1_1(i,j) = 1;
        elseif (Lround1_1{j}(2) == 'M') && (Lcurrent_Y1_1(j)<=-.5)
            Lrights_1 =Lrights_1+1;
            Lcorrect1_1(i,j) = 1;
        elseif (Lround1_1{j}(2) == 'R') && (Lcurrent_X1_1(j)> 0)
            Lrights_1 =Lrights_1+1;
            Lcorrect1_1(i,j) = 1;
        end
        if (Lround1_2{j}(2) == 'L') && (Lcurrent_X1_2(j)<0)
            Lrights_2 =Lrights_2+1;
            Lcorrect1_2(i,j) = 1;
        elseif (Lround1_2{j}(2) == 'M') && (Lcurrent_Y1_2(j) <=-.5)
            Lrights_2 =Lrights_2+1;
            Lcorrect1_2(i,j) = 1;
        elseif (Lround1_2{j}(2) == 'R') && (Lcurrent_X1_2(j)> 0)
            Lrights_2 =Lrights_2+1;
            Lcorrect1_2(i,j) = 1;
        end
    end
    Lcorrect_totals1_1(i) = Lrights_1;
    Lcorrect_totals1_2(i) = Lrights_2;
end
number_added1_1 = Lcorrect_totals1_1 - correct_totals1_1;
number_added1_2 = Lcorrect_totals1_2 - correct_totals1_2;

%% find times where "Go" presents for TRAINING REGRESSOR
% trial: 2s --> 4s --> 4s --> 2s -------> [2s --> 4s --> 4s -->4s] = 26 seconds
% 1 round = 2 trials for all 12 images = 8 rights, 8 lefts, 8 middles  = 24 trials
% 624 seconds + 20 second delay + 10 second shutdown = 654 sec = 327 TR
% so when wait = correct, first 1O TR --> delay, last 5 --> shutdown
TR_length = 2;
TRwait_correct = 10;
TRwait_incorrect = 0;
nTrials = 24;
TR_perRound = 327;

% find time where "go" is dispayed across both imagery and training
for i = 1:4
    planned_start_1_1{i} = data1_1{1, i}.timing.plannedOnsets.preISI(1);
    planned_start_1_2{i} = data1_2{1, i}.timing.plannedOnsets.preISI(1);
    actual_start_1_1{i} = data1_1{1, i}.timing.actualOnsets.preISI(1);
    actual_start_1_2{i} = data1_2{1, i}.timing.actualOnsets.preISI(1);
    planned_GO_1_1{i} = data1_1{1, i}.timing.plannedOnsets.go - planned_start_1_1{i};
    planned_GO_1_2{i} = data1_2{1, i}.timing.plannedOnsets.go - planned_start_1_2{i};
    actual_GO_1_1{i} = data1_1{1, i}.timing.actualOnsets.go - actual_start_1_1{i};
    actual_GO_1_2{i} = data1_2{1, i}.timing.actualOnsets.go - actual_start_1_2{i};
    planned_start_2_1{i} = data2_1{1, i}.timing.plannedOnsets.preISI(1);
    planned_start_2_2{i} = data2_2{1, i}.timing.plannedOnsets.preISI(1);
    actual_start_2_1{i} = data2_1{1, i}.timing.actualOnsets.preISI(1);
    actual_start_2_2{i} = data2_2{1, i}.timing.actualOnsets.preISI(1);
    planned_GO_2_1{i} = data2_1{1, i}.timing.plannedOnsets.go - planned_start_2_1{i};
    planned_GO_2_2{i} = data2_2{1, i}.timing.plannedOnsets.go - planned_start_2_2{i};
    actual_GO_2_1{i} = data2_1{1, i}.timing.actualOnsets.go - actual_start_2_1{i};
    actual_GO_2_2{i} = data2_2{1, i}.timing.actualOnsets.go - actual_start_2_2{i};
end

%check times
for i = 1:length(planned_GO_1_1)
    off1_1{i} = planned_GO_1_1{i} - actual_GO_1_1{i};
    off1_2{i} = planned_GO_1_2{i} - actual_GO_1_2{i};
    total_off1_1(i) = sum(off1_1{i});
    total_off1_2(i) = sum(off1_2{i});
    off2_1{i} = planned_GO_2_1{i} - actual_GO_2_1{i};
    off2_2{i} = planned_GO_2_2{i} - actual_GO_2_2{i};
    total_off2_1(i) = sum(off2_1{i});
    total_off2_2(i) = sum(off2_2{i});
end

%see where things actually start for training round 2 for subjects 1 + 2 
%answer ===== 1st TR!!!!!
for i =1:4
    for j = 1:24
        number = actual_GO_1_2{i}(j);
        rounded_actuals{j} = round(number, 0);
        TR_list{j} = convertTR(0,rounded_actuals{j},TR_length); 
    end
    rounded_actuals_1_2{i} = rounded_actuals;
    TR_list_1_2{i} = TR_list; 
end

%% build training regressors  (ignoring corrects / incorrects)

%reg for 1st round for all 4  subjects
for i = 1:4
    REG = zeros(3,TR_perRound);
    sequence = round_seq1_1{i};
    gos = planned_GO_1_1{i};
    for j = 1:length(sequence)
        if sequence{j}(2) == 'L'
            REG(1,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark lefts (with delay + shift)(+1)
            REG(1,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        elseif sequence{j}(2) == 'M'
            REG(2,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark middles (with delay + shift)
            REG(2,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        elseif sequence{j}(2) == 'R'
            REG(3,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark rights (with dely + shift)
            REG(3,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        end
    end
    reg1_1{i} = REG;
end

% reg for 2nd round for subjects 3 and 4 (CORRECT WAIT)
for i = 3:4
    REG = zeros(3,TR_perRound);
    sequence = round_seq1_2{i};
    gos = planned_GO_1_2{i};
    for j = 1:length(sequence)
        if sequence{j}(2) == 'L'
            REG(1,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark lefts (with delay + shift)
            REG(1,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        elseif sequence{j}(2) == 'M'
            REG(2,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark middles (with delay + shift)
            REG(2,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        elseif sequence{j}(2) == 'R'
            REG(3,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark rights (with dely + shift)
            REG(3,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        end
    end
    reg1_2{i} = REG;
end

% reg for 2nd round for subjects 1 and 2 (INCORRECT WAIT)
for i = 1:2
    REG = zeros(3,TR_perRound);
    sequence = round_seq1_2{i};
    TRs = TR_list_1_2{i};
    for j = 1:length(sequence)
        displayed = TRs{j};
        if sequence{j}(2) == 'L'
            REG(1,displayed +2) = 1; % mark lefts (with shift)
            REG(1,displayed +2+1) = 1;
        elseif sequence{j}(2) == 'M'
            REG(2,displayed +2) = 1; % mark middles (with shift)
            REG(2,displayed +2+1) = 1;
        elseif sequence{j}(2) == 'R'
            REG(3,displayed +2) = 1; % mark rights (with shift)
            REG(3,displayed +2+1) = 1;
        end
    end
    reg1_2{i} = REG;
end

%% build imagery regressors  (ignoring corrects / incorrects)

%reg for 1st round for all 4  subjects
for i = 1:4
    REG = zeros(3,TR_perRound);
    sequence = round_seq2_1{i};
    gos = planned_GO_2_1{i};
    for j = 1:length(sequence)
        if sequence{j}(2) == 'L'
            REG(1,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark lefts (with delay + shift)
            REG(1,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        elseif sequence{j}(2) == 'M'
            REG(2,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark middles (with delay + shift)
            REG(2,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        elseif sequence{j}(2) == 'R'
            REG(3,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark rights (with dely + shift)
            REG(3,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        end
    end
    reg2_1{i} = REG;
end
%reg for 2nd round for all 4  subjects
for i = 1:4
    REG = zeros(3,TR_perRound);
    sequence = round_seq2_2{i};
    gos = planned_GO_2_2{i};
    for j = 1:length(sequence)
        if sequence{j}(2) == 'L'
            REG(1,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark lefts (with delay + shift)
            REG(1,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        elseif sequence{j}(2) == 'M'
            REG(2,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark middles (with delay + shift)
            REG(2,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        elseif sequence{j}(2) == 'R'
            REG(3,gos(j)/TR_length + TRwait_correct +2 +1) = 1; % mark rights (with dely + shift)
            REG(3,gos(j)/TR_length + TRwait_correct +3 +1) = 1;
        end
    end
    reg2_2{i} = REG;
end

%% TRAINING SELECTOR
% dimension: 1 x #TRS
% - label each of the blocks by the block identity
% (a block is the set of trials that have every condition shown once)
% so like [1 1 1 1 1 1 2 2 2 2 2 2 2 3 3 3 3 3 3 ] etc.
% - you should also shift this by 2 TR's

nTR_perTrial = 13;
nTrials_perBlock = 12;
nTR_perBlock = nTR_perTrial*nTrials_perBlock;

%selector for 1st round for all 4 subjects
for i = 1:4
    selector = zeros(1,TR_perRound);
    for j = 0:nTR_perBlock
        selector(1,TRwait_correct +2 + j +1) = 1; % mark 1st round (with delay + shift)
        selector(1,TRwait_correct +2 + j +1 + nTR_perBlock) = 2; % mark 2nd round (with delay + shift)
    end
    selector1_1{i} = selector;
end
%selector for 2nd round for subjects 3 and 4 (CORRECT WAIT)
for i = 3:4
    selector = zeros(1,TR_perRound);
    for j = 0:nTR_perBlock
        selector(1,TRwait_correct +2 + j +1) = 3; % mark 1st round (with delay + shift)
        selector(1,TRwait_correct +2 + j +1 + nTR_perBlock) = 4; % mark 2nd round (with delay + shift)
    end
    selector1_2{i} = selector;
end

% selector for 2nd round for subjects 1 and 2 (INCORRECT WAIT)
for i = 1:2
    selector = zeros(1,TR_perRound);
    TRs = TR_list_1_2{i};
    for j = 0:nTR_perBlock
        selector(1,1 +2 + j) = 3; % mark 1st round (with delay + shift)
        selector(1,1 +2 + j + nTR_perBlock) = 4; % mark 2nd round (with delay + shift)
    end
    selector1_2{i} = selector;
end

%% IMAGERY  SELECTOR

%selector for 1st round for all 4 subjects
for i = 1:4
    selector = zeros(1,TR_perRound);
    for j = 0:nTR_perBlock
        selector(1,TRwait_correct +2 + j+1) = 1; % mark 1st round (with delay + shift)
        selector(1,TRwait_correct +2 + j+1 + nTR_perBlock) = 2; % mark 2nd round (with delay + shift)
    end
    selector2_1{i} = selector;
end
%selector for 2nd round for all subjects
for i = 1:4
    selector = zeros(1,TR_perRound);
    for j = 0:nTR_perBlock
        selector(1,TRwait_correct +2 + j +1) = 3; % mark 1st round (with delay + shift)
        selector(1,TRwait_correct +2 + j +1 + nTR_perBlock) = 4; % mark 2nd round (with delay + shift)
    end
    selector2_2{i} = selector;
end

%% save everything!

sub1.go1.reg = reg1_1{1}; 
sub1.go1.sel = selector1_1{1}; 
sub1.go2.reg = reg1_2{1}; 
sub1.go2.sel = selector1_2{1}; 
sub1.imag1.reg = reg2_1{1};
sub1.imag1.sel = selector2_1{1}; 
sub1.imag2.reg = reg2_2{1};
sub1.imag2.sel = selector2_2{1}; 

sub2.go1.reg = reg1_1{2}; 
sub2.go1.sel = selector1_1{2}; 
sub2.go2.reg = reg1_2{2}; 
sub2.go2.sel = selector1_2{2}; 
sub2.imag1.reg = reg2_1{2}; 
sub2.imag1.sel = selector2_1{2}; 
sub2.imag2.reg = reg2_2{2}; 
sub2.imag2.sel = selector2_2{2}; 

sub3.go1.reg = reg1_1{3}; 
sub3.go1.sel = selector1_1{3}; 
sub3.go2.reg = reg1_2{3}; 
sub3.go2.sel = selector1_2{3}; 
sub3.imag1.reg = reg2_1{3};
sub3.imag1.sel = selector2_1{3}; 
sub3.imag2.reg = reg2_2{3};
sub3.imag2.sel = selector2_2{3}; 

sub4.go1.reg = reg1_1{4}; 
sub4.go1.sel = selector1_1{4}; 
sub4.go2.reg = reg1_2{4}; 
sub4.go2.sel = selector1_2{4}; 
sub4.imag1.reg = reg2_1{4};
sub4.imag1.sel = selector2_1{4}; 
sub4.imag2.reg = reg2_2{4};
sub4.imag2.sel = selector2_2{4}; 

% matlab save file
matlabSaveFile = ['REGRESSOR.mat'];
data_dir = fullfile(workingDir, 'class_reg');
if ~exist(data_dir,'dir'), mkdir(data_dir); end
ppt_dir = [data_dir filesep 'regressor' filesep];
if ~exist(ppt_dir,'dir'), mkdir(ppt_dir); end

save([ppt_dir matlabSaveFile],'sub1','sub2','sub3','sub4');  
