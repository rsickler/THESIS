% PSEUDO-RANDOMIZE
SETUP; 
all_orig = [1:N_og_images];
ROUNDS = 4;
max_sequence_rounds = 10;
scenario_sequence = [];
correct_sequence = [];
inc1_sequence = [];
inc2_sequence = [];
correct_u_sequence = [];
inc1_u_sequence = [];
inc2_u_sequence = [];

new_scenario_bundle = cell(1,N_og_images);
new_correct_bundle = cell(1,N_og_images);
new_inc1_bundle = cell(1,N_og_images);
new_inc2_bundle = cell(1,N_og_images);
new_correct_u_bundle = cell(1,N_og_images);
new_inc1_u_bundle = cell(1,N_og_images);
new_inc2_u_bundle = cell(1,N_og_images);

for j = 1:max_sequence_rounds
    used = zeros(1,N_og_images);
    for T = 1:ROUNDS
        ABorder = randperm(2);
        for i = 1:2
            sitch = ABorder(i);  
            TRIAL = (T-1)*2 + i;
            start = (sitch-1)*4 + 1;
            index = start + randi(4) -1;
            found = 0;
            while ~found
                if ~used(index)
                    new_scenario_bundle{TRIAL} = og_scenarios{index};
                    new_correct_bundle{TRIAL} = og_corrects{index};
                    new_inc1_bundle{TRIAL} = og_inc1s{index};
                    new_inc2_bundle{TRIAL} = og_inc2s{index};
                    new_correct_u_bundle{TRIAL} = og_corrects_u{index};
                    new_inc1_u_bundle{TRIAL} = og_inc1s_u{index};
                    new_inc2_u_bundle{TRIAL} = og_inc2s_u{index};
                    %update status
                    found = 1;
                    used(index) = 1;
                else
                    index = start + randi(4) -1;
                end
            end
        end
    end
    scenario_sequence = cat(2,scenario_sequence, new_scenario_bundle);
    correct_sequence = cat(2,correct_sequence,new_correct_bundle);
    inc1_sequence = cat(2,inc1_sequence, new_inc1_bundle);
    inc2_sequence = cat(2,inc2_sequence, new_inc2_bundle);
    correct_u_sequence = cat(2,correct_u_sequence,new_correct_u_bundle);
    inc1_u_sequence = cat(2,inc1_u_sequence, new_inc1_u_bundle);
    inc2_u_sequence = cat(2,inc2_u_sequence, new_inc2_u_bundle);
end

%make original textures in the pseudo-randomized order
for i = 1:N_og_images*max_sequence_rounds
    og_scenario_matrix = double(imread(fullfile(og_scenario_Folder,scenario_sequence{i})));
    og_scenario_texture(i) = Screen('MakeTexture', mainWindow, og_scenario_matrix);
    og_correct_matrix = double(imread(fullfile(og_correct_Folder,correct_sequence{i})));
    og_correct_texture(i) = Screen('MakeTexture', mainWindow, og_correct_matrix);
    og_inc1_matrix = double(imread(fullfile(og_inc1_Folder,inc1_sequence{i})));
    og_inc1_texture(i) = Screen('MakeTexture', mainWindow, og_inc1_matrix);
    og_inc2_matrix = double(imread(fullfile(og_inc2_Folder,inc2_sequence{i})));
    og_inc2_texture(i) = Screen('MakeTexture', mainWindow, og_inc2_matrix);
    og_correct_u_matrix = double(imread(fullfile(og_correct_u_Folder,correct_u_sequence{i})));
    og_correct_u_texture(i) = Screen('MakeTexture', mainWindow, og_correct_u_matrix);
    og_inc1_u_matrix = double(imread(fullfile(og_inc1_u_Folder,inc1_u_sequence{i})));
    og_inc1_u_texture(i) = Screen('MakeTexture', mainWindow, og_inc1_u_matrix);
    og_inc2_u_matrix = double(imread(fullfile(og_inc2_u_Folder,inc2_u_sequence{i})));
    og_inc2_u_texture(i) = Screen('MakeTexture', mainWindow, og_inc2_u_matrix);
end