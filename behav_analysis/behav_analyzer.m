%% data analyzer for behavioral experiment

%% load all data
workingDir = '/Users/treysickler/Documents/MATLAB/THESIS/BehavioralData';
subj_folder = {};
DirList = {};
intro_data = {};
% intro data
for i = 1:48
    subj = num2str(i);
    subj_folder{i} = fullfile(workingDir, subj);
    DirList{i} = dir(fullfile(subj_folder{i}, 'DATA_*_0_*.mat'));
    intro_data{i} = load(fullfile(subj_folder{i},DirList{i}.name));
end
% round 1 data
for i = 1:48
    subj = num2str(i);
    subj_folder{i} = fullfile(workingDir, subj);
    DirList{i} = dir(fullfile(subj_folder{i}, 'DATA_*_1_*.mat'));
    p1_data{i} = load(fullfile(subj_folder{i},DirList{i}.name));
end
% round 2 data
for i = 1:48
    subj = num2str(i);
    subj_folder{i} = fullfile(workingDir, subj);
    DirList{i} = dir(fullfile(subj_folder{i}, 'DATA_*_2_*.mat'));
    p2_data{i} = load(fullfile(subj_folder{i},DirList{i}.name));
end
% round 3 data
for i = 1:48
    subj = num2str(i);
    subj_folder{i} = fullfile(workingDir, subj);
    DirList{i} = dir(fullfile(subj_folder{i}, 'DATA_*_3_*.mat'));
    p3_data{i} = load(fullfile(subj_folder{i},DirList{i}.name));
end
% round 4 data
for i = 1:48
    subj = num2str(i);
    subj_folder{i} = fullfile(workingDir, subj);
    DirList{i} = dir(fullfile(subj_folder{i}, 'DATA_*_4_*.mat'));
    p4_data{i} = load(fullfile(subj_folder{i},DirList{i}.name));
end

%% take mean and standard devation across all phases
%% phase 1
for i = 1:16 %training
    Aratio_t1(i) = p1_data{1, i}.Aratio;
    Bratio_t1(i) = p1_data{1, i}.Bratio;
end
p1_t_Aratio = mean(Aratio_t1);
p1_t_Bratio = mean(Bratio_t1);
p1_t_Aratio_std = std(Aratio_t1);
p1_t_Bratio_std = std(Bratio_t1);
p1_t_O = cat(2, Aratio_t1, Bratio_t1);
p1_t_O_RATIO = mean(p1_t_O);
p1_t_O_RATIO_STD = std(p1_t_O);

for i = 17:32 %imagery
    Aratio_i1(i-16) = p1_data{1, i}.Aratio;
    Bratio_i1(i-16) = p1_data{1, i}.Bratio;
end
p1_i_Aratio = mean(Aratio_i1);
p1_i_Bratio = mean(Bratio_i1);
p1_i_Aratio_std = std(Aratio_i1);
p1_i_Bratio_std = std(Bratio_i1);
p1_i_O = cat(2, Aratio_i1, Bratio_i1);
p1_i_O_RATIO = mean(p1_i_O);
p1_i_O_RATIO_STD = std(p1_i_O);

for i = 33:48 %distractor
    Aratio_d1(i-32) = p1_data{1, i}.Aratio;
    Bratio_d1(i-32) = p1_data{1, i}.Bratio;
end
p1_d_Aratio = mean(Aratio_d1);
p1_d_Bratio = mean(Bratio_d1);
p1_d_Aratio_std = std(Aratio_d1);
p1_d_Bratio_std = std(Bratio_d1);
p1_d_O = cat(2, Aratio_d1, Bratio_d1);
p1_d_O_RATIO = mean(p1_d_O);
p1_d_O_RATIO_STD = std(p1_d_O);

%% phase 2
for i = 1:16 %training
    Ao_ratio_t2(i) = p2_data{1, i}.Ao_ratio;
    Av_ratio_t2(i) = p2_data{1, i}.Av_ratio;
    Bo_ratio_t2(i) = p2_data{1, i}.Bo_ratio;
    Bv_ratio_t2(i) = p2_data{1, i}.Bv_ratio;
end
p2_t_Ao_ratio = mean(Ao_ratio_t2);
p2_t_Av_ratio = mean(Av_ratio_t2);
p2_t_Bo_ratio = mean(Bo_ratio_t2);
p2_t_Bv_ratio = mean(Bv_ratio_t2);
p2_t_Ao_ratio_std = std(Ao_ratio_t2);
p2_t_Av_ratio_std = std(Av_ratio_t2);
p2_t_Bo_ratio_std = std(Bo_ratio_t2);
p2_t_Bv_ratio_std = std(Bv_ratio_t2);
p2_t_O = cat(2, Ao_ratio_t2, Bo_ratio_t2);
p2_t_V = cat(2, Av_ratio_t2, Bv_ratio_t2);
p2_t_O_RATIO = mean(p2_t_O);
p2_t_V_RATIO = mean(p2_t_V);
p2_t_O_RATIO_STD = std(p2_t_O);
p2_t_V_RATIO_STD = std(p2_t_V);

for i = 17:32 %imagery
    Ao_ratio_i2(i-16) = p2_data{1, i}.Ao_ratio;
    Av_ratio_i2(i-16) = p2_data{1, i}.Av_ratio;
    Bo_ratio_i2(i-16) = p2_data{1, i}.Bo_ratio;
    Bv_ratio_i2(i-16) = p2_data{1, i}.Bv_ratio;
end
p2_i_Ao_ratio = mean(Ao_ratio_i2);
p2_i_Av_ratio = mean(Av_ratio_i2);
p2_i_Bo_ratio = mean(Bo_ratio_i2);
p2_i_Bv_ratio = mean(Bv_ratio_i2);
p2_i_Ao_ratio_std = std(Ao_ratio_i2);
p2_i_Av_ratio_std = std(Av_ratio_i2);
p2_i_Bo_ratio_std = std(Bo_ratio_i2);
p2_i_Bv_ratio_std = std(Bv_ratio_i2);
p2_i_O = cat(2, Ao_ratio_i2, Bo_ratio_i2);
p2_i_V = cat(2, Av_ratio_i2, Bv_ratio_i2);
p2_i_O_RATIO = mean(p2_i_O);
p2_i_V_RATIO = mean(p2_i_V);
p2_i_O_RATIO_STD = std(p2_i_O);
p2_i_V_RATIO_STD = std(p2_i_V);

for i = 33:48 % distractor
    Ao_ratio_d2(i-32) = p2_data{1, i}.Ao_ratio;
    Av_ratio_d2(i-32) = p2_data{1, i}.Av_ratio;
    Bo_ratio_d2(i-32) = p2_data{1, i}.Bo_ratio;
    Bv_ratio_d2(i-32) = p2_data{1, i}.Bv_ratio;
end
p2_d_Ao_ratio = mean(Ao_ratio_d2);
p2_d_Av_ratio = mean(Av_ratio_d2);
p2_d_Bo_ratio = mean(Bo_ratio_d2);
p2_d_Bv_ratio = mean(Bv_ratio_d2);
p2_d_Ao_ratio_std = std(Ao_ratio_d2);
p2_d_Av_ratio_std = std(Av_ratio_d2);
p2_d_Bo_ratio_std = std(Bo_ratio_d2);
p2_d_Bv_ratio_std = std(Bv_ratio_d2);
p2_d_O = cat(2, Ao_ratio_d2, Bo_ratio_d2);
p2_d_V = cat(2, Av_ratio_d2, Bv_ratio_d2);
p2_d_O_RATIO = mean(p2_d_O);
p2_d_V_RATIO = mean(p2_d_V);
p2_d_O_RATIO_STD = std(p2_d_O);
p2_d_V_RATIO_STD = std(p2_d_V);

%% phase 3
for i = 1:16 %--- continued trianing
    Ao_ratio_t3(i) = p3_data{1, i}.Ao_ratio;
    Av_ratio_t3(i) = p3_data{1, i}.Av_ratio;
    Bo_ratio_t3(i) = p3_data{1, i}.Bo_ratio;
    Bv_ratio_t3(i) = p3_data{1, i}.Bv_ratio;
end
p3_t_Ao_ratio = mean(Ao_ratio_t3);
p3_t_Av_ratio = mean(Av_ratio_t3);
p3_t_Bo_ratio = mean(Bo_ratio_t3);
p3_t_Bv_ratio = mean(Bv_ratio_t3);
p3_t_Ao_ratio_std = std(Ao_ratio_t3);
p3_t_Av_ratio_std = std(Av_ratio_t3);
p3_t_Bo_ratio_std = std(Bo_ratio_t3);
p3_t_Bv_ratio_std = std(Bv_ratio_t3);
p3_t_O = cat(2, Ao_ratio_t3, Bo_ratio_t3);
p3_t_V = cat(2, Av_ratio_t3, Bv_ratio_t3);
p3_t_O_RATIO = mean(p3_t_O);
p3_t_V_RATIO = mean(p3_t_V);
p3_t_O_RATIO_STD = std(p3_t_O);
p3_t_V_RATIO_STD = std(p3_t_V);

%% phase 4
for i = 1:16 %training
    Ao_ratio_t4(i) = p4_data{1, i}.Ao_ratio;
    Av_ratio_t4(i) = p4_data{1, i}.Av_ratio;
    Bo_ratio_t4(i) = p4_data{1, i}.Bo_ratio;
    Bv_ratio_t4(i) = p4_data{1, i}.Bv_ratio;
end
p4_t_Ao_ratio = mean(Ao_ratio_t4);
p4_t_Av_ratio = mean(Av_ratio_t4);
p4_t_Bo_ratio = mean(Bo_ratio_t4);
p4_t_Bv_ratio = mean(Bv_ratio_t4);
p4_t_Ao_ratio_std = std(Ao_ratio_t4);
p4_t_Av_ratio_std = std(Av_ratio_t4);
p4_t_Bo_ratio_std = std(Bo_ratio_t4);
p4_t_Bv_ratio_std = std(Bv_ratio_t4);
p4_t_O = cat(2, Ao_ratio_t4, Bo_ratio_t4);
p4_t_V = cat(2, Av_ratio_t4, Bv_ratio_t4);
p4_t_O_RATIO = mean(p4_t_O);
p4_t_V_RATIO = mean(p4_t_V);
p4_t_O_RATIO_STD = std(p4_t_O);
p4_t_V_RATIO_STD = std(p4_t_V);

for i = 17:32 %imagery
    Ao_ratio_i4(i-16) = p4_data{1, i}.Ao_ratio;
    Av_ratio_i4(i-16) = p4_data{1, i}.Av_ratio;
    Bo_ratio_i4(i-16) = p4_data{1, i}.Bo_ratio;
    Bv_ratio_i4(i-16) = p4_data{1, i}.Bv_ratio;
end
p4_i_Ao_ratio = mean(Ao_ratio_i4);
p4_i_Av_ratio = mean(Av_ratio_i4);
p4_i_Bo_ratio = mean(Bo_ratio_i4);
p4_i_Bv_ratio = mean(Bv_ratio_i4);
p4_i_Ao_ratio_std = std(Ao_ratio_i4);
p4_i_Av_ratio_std = std(Av_ratio_i4);
p4_i_Bo_ratio_std = std(Bo_ratio_i4);
p4_i_Bv_ratio_std = std(Bv_ratio_i4);
p4_i_O = cat(2, Ao_ratio_i4, Bo_ratio_i4);
p4_i_V = cat(2, Av_ratio_i4, Bv_ratio_i4);
p4_i_O_RATIO = mean(p4_i_O);
p4_i_V_RATIO = mean(p4_i_V);
p4_i_O_RATIO_STD = std(p4_i_O);
p4_i_V_RATIO_STD = std(p4_i_V);

for i = 33:48 % distractor
    Ao_ratio_d4(i-32) = p4_data{1, i}.Ao_ratio;
    Av_ratio_d4(i-32) = p4_data{1, i}.Av_ratio;
    Bo_ratio_d4(i-32) = p4_data{1, i}.Bo_ratio;
    Bv_ratio_d4(i-32) = p4_data{1, i}.Bv_ratio;
end
p4_d_Ao_ratio = mean(Ao_ratio_d4);
p4_d_Av_ratio = mean(Av_ratio_d4);
p4_d_Bo_ratio = mean(Bo_ratio_d4);
p4_d_Bv_ratio = mean(Bv_ratio_d4);
p4_d_Ao_ratio_std = std(Ao_ratio_d4);
p4_d_Av_ratio_std = std(Av_ratio_d4);
p4_d_Bo_ratio_std = std(Bo_ratio_d4);
p4_d_Bv_ratio_std = std(Bv_ratio_d4);
p4_d_O = cat(2, Ao_ratio_d4, Bo_ratio_d4);
p4_d_V = cat(2, Av_ratio_d4, Bv_ratio_d4);
p4_d_O_RATIO = mean(p4_d_O);
p4_d_V_RATIO = mean(p4_d_V);
p4_d_O_RATIO_STD = std(p4_d_O);
p4_d_V_RATIO_STD = std(p4_d_V);

%% analyze mental practice imagery and digit acc as they relate to accuracy

ind_accs = {};
for i = 1:16 %imagery
    ind_accs{i} = p3_data{1, i+32}.digitAcc;
    overall_accs(i) = mean(ind_accs{i});
end

ratings = {};
for i = 1:16 %imagery
    ratings{i} = p3_data{1, i+16}.vividness;
    total = 0;
    unclears = 0;
    for i = 1:length(ratings)
        this_rating = ratings{i}(i);
        if this_rating{1}(1) == 'N'
            value = 0;
        elseif this_rating{1}(1) == 'S'
            value = 1;
        elseif this_rating{1}(1) == 'F'
            value = 2;
        elseif this_rating{1}(1) == 'V'
            value = 3;
        elseif this_rating{1}(1) == 'U'
            unclears = unclears +1;
        end
        total = total + value;
    end
    GPA(i) = total / (length(ratings)-unclears);
end

%% compute P4-P2 data

for i = 1:16
    difference_Ao_t(i) = Ao_ratio_t4(i) - Ao_ratio_t2(i);
    difference_Bo_t(i) = Bo_ratio_t4(i) - Bo_ratio_t2(i);
    difference_Av_t(i) = Av_ratio_t4(i) - Av_ratio_t2(i);
    difference_Bv_t(i) = Bv_ratio_t4(i) - Bv_ratio_t2(i);
end
O_diffs_t = cat(2, difference_Ao_t, difference_Bo_t);
V_diffs_t = cat(2, difference_Av_t, difference_Bv_t);

mean_O_diffs_t = mean(O_diffs_t);
mean_V_diffs_t = mean(V_diffs_t);
std_O_diffs_t = std(O_diffs_t);
std_V_diffs_t = std(V_diffs_t);

for i = 1:16
    difference_Ao_i(i) = Ao_ratio_i4(i) - Ao_ratio_i2(i);
    difference_Bo_i(i) = Bo_ratio_i4(i) - Bo_ratio_i2(i);
    difference_Av_i(i) = Av_ratio_i4(i) - Av_ratio_i2(i);
    difference_Bv_i(i) = Bv_ratio_i4(i) - Bv_ratio_i2(i);
end
O_diffs_i = cat(2, difference_Ao_i, difference_Bo_i);
V_diffs_i = cat(2, difference_Av_i, difference_Bv_i);

mean_O_diffs_i = mean(O_diffs_i);
mean_V_diffs_i = mean(V_diffs_i);
std_O_diffs_i = std(O_diffs_i);
std_V_diffs_i = std(V_diffs_i);

for i = 1:16
    difference_Ao_d(i) = Ao_ratio_d4(i) - Ao_ratio_d2(i);
    difference_Bo_d(i) = Bo_ratio_d4(i) - Bo_ratio_d2(i);
    difference_Av_d(i) = Av_ratio_d4(i) - Av_ratio_d2(i);
    difference_Bv_d(i) = Bv_ratio_d4(i) - Bv_ratio_d2(i);
end
O_diffs_d = cat(2, difference_Ao_d, difference_Bo_d);
V_diffs_d = cat(2, difference_Av_d, difference_Bv_d);

mean_O_diffs_d = mean(O_diffs_d);
mean_V_diffs_d = mean(V_diffs_d);
std_O_diffs_d = std(O_diffs_d);
std_V_diffs_d = std(V_diffs_d);

%% p2 A,A',B,B' means across n = 48

all_Ao = cat(2, Ao_ratio_t2, Ao_ratio_i2,Ao_ratio_d2);
all_Av = cat(2, Av_ratio_t2, Av_ratio_i2,Av_ratio_d2);
all_Bo = cat(2, Bo_ratio_t2, Bo_ratio_i2,Bo_ratio_d2);
all_Bv = cat(2, Bv_ratio_t2, Bv_ratio_i2,Bv_ratio_d2);

mean_all_Ao = mean(all_Ao);
mean_all_Av = mean(all_Av);
mean_all_Bo = mean(all_Bo);
mean_all_Bv = mean(all_Bv);
std_all_Ao = std(all_Ao);
std_all_Av = std(all_Av);
std_all_Bo = std(all_Bo);
std_all_Bv = std(all_Bv);

%% volley skill analyzer

all_experienced = [11 12 23 24 30 31 37 39 40];
volley = zeros(1,48);
for j = 1:length(all_experienced)
    subject = all_experienced(j);
    volley(subject) = 1;
end

%phase 2 accuracies
v_Ao_ratio_t2= [];
v_Av_ratio_t2= [];
v_Bo_ratio_t2= [];
v_Bv_ratio_t2= [];
nv_Ao_ratio_t2= [];
nv_Av_ratio_t2= [];
nv_Bo_ratio_t2= [];
nv_Bv_ratio_t2= [];
for i = 1:48
    current = volley(i);
    if current
        v_Ao_ratio_t2(end+1) = p2_data{1, i}.Ao_ratio;
        v_Av_ratio_t2(end+1) = p2_data{1, i}.Av_ratio;
        v_Bo_ratio_t2(end+1) = p2_data{1, i}.Bo_ratio;
        v_Bv_ratio_t2(end+1) = p2_data{1, i}.Bv_ratio;
    else
        nv_Ao_ratio_t2(end+1) = p2_data{1, i}.Ao_ratio;
        nv_Av_ratio_t2(end+1) = p2_data{1, i}.Av_ratio;
        nv_Bo_ratio_t2(end+1) = p2_data{1, i}.Bo_ratio;
        nv_Bv_ratio_t2(end+1) = p2_data{1, i}.Bv_ratio;
    end
end
v_Ao_mean2 = mean(v_Ao_ratio_t2);
v_Bo_mean2 = mean(v_Bo_ratio_t2);
v_Av_mean2 = mean(v_Av_ratio_t2);
v_Bv_mean2 = mean(v_Bv_ratio_t2);
nv_Ao_mean2 = mean(nv_Ao_ratio_t2);
nv_Bo_mean2 = mean(nv_Bo_ratio_t2);
nv_Av_mean2 = mean(nv_Av_ratio_t2);
nv_Bv_mean2 = mean(nv_Bv_ratio_t2);
v_Ao_std2 = std(v_Ao_ratio_t2);
v_Bo_std2 = std(v_Bo_ratio_t2);
v_Av_std2 = std(v_Av_ratio_t2);
v_Bv_std2 = std(v_Bv_ratio_t2);
nv_Ao_std2 = std(nv_Ao_ratio_t2);
nv_Bo_std2 = std(nv_Bo_ratio_t2);
nv_Av_std2 = std(nv_Av_ratio_t2);
nv_Bv_std2 = std(nv_Bv_ratio_t2);

%comparing phase 4 accuracies
experienced_t = [11 12];
experienced_i = [23 24 30 31];
experienced_d = [37 39 40];


%% p1 80% above percentage
trial_counter = zeros(1,48);
for i = 1:48
    trials(i) = p1_data{1, i}.trial;
    if trials(i) < 40
        trial_counter(i) = 1;
    end
end
total_smart = sum(trial_counter);

total_acc_bad = 0;
for i = 1:48
    acc(i) = (p1_data{1, i}.Aratio + p1_data{1, i}.Bratio) / 2;
    if ~trial_counter(i)
        total_acc_bad = total_acc_bad + acc(i);
    end
end
accuracy = total_acc_bad / 48;

trial_number = [];
for i = 1:48
    trials(i) = p1_data{1, i}.trial;
    if trials(i) < 40
        trial_number(end+1) = trials(i);
    end
end
avg_trials_good = mean(trial_number);


%%  improper response analysis
for i = 1:48
    response_array_p1{i} = p1_data{1, i}.P1_response;
    response_array_p2{i} = p2_data{1, i}.P2_response;
    response_array_p4{i} = p4_data{1, i}.P4_response;
    
end
for i = 1:48
    subject_p1 = response_array_p1{i};
    subject_p2 = response_array_p2{i};
    subject_p4 = response_array_p4{i};
    impropers_p1 = 0;
    impropers_p2 = 0;
    impropers_p4 = 0;
    for j = 1:length(subject_p1)
        p1_response{j} = subject_p1{j};
        if p1_response{j}(2) == 'm'
            impropers_p1 = impropers_p1 +1;
        end
    end
    for j = 1:length(subject_p2)
        p2_response{j} = subject_p2{j};
        if p2_response{j}(2) == 'm'
            impropers_p2 = impropers_p2 +1;
        end
    end
    for j = 1:length(subject_p4)
        p4_response{j} = subject_p4{j};
        if p4_response{j}(2) == 'm'
            impropers_p4 = impropers_p4 +1;
        end
    end
    total_impropers_p1(i) = impropers_p1;
    total_impropers_p2(i) = impropers_p2;
    total_impropers_p4(i) = impropers_p4;
end
avg_impropers_p1 = mean(total_impropers_p1);
std_impropers_p1 = std(total_impropers_p1);
avg_impropers_p2 = mean(total_impropers_p2);
std_impropers_p2 = std(total_impropers_p2);
avg_impropers_p4 = mean(total_impropers_p4);
std_impropers_p4 = std(total_impropers_p4);

impropers_outliers_p1 = 0;
impropers_outliers_p2 = 0;
impropers_outliers_p4 = 0;
for i = 1:48
    if total_impropers_p1(i) > 40 / 2 % p1 trials / 2
        impropers_outliers_p1 = impropers_outliers_p1+1;
    end
    if total_impropers_p2(i) > 40 / 2 % p1 trials / 2
        impropers_outliers_p2 = impropers_outliers_p2+1;
    end
    if total_impropers_p4(i) > 32 / 2 % p1 trials / 2
        impropers_outliers_p4 = impropers_outliers_p4+1;
    end
end