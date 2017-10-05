% PSEUDO-RANDOMIZE
all_orig = [1:N_og_images];
used = zeros(1,N_og_images);
nDoubles = 2;
scenario_sequence = cell(1,N_og_images);
correct_sequence = cell(1,N_og_images);
inc1_sequence = cell(1,N_og_images);
inc2_sequence = cell(1,N_og_images);
correct_u_sequence = cell(1,N_og_images);
inc1_u_sequence = cell(1,N_og_images);
inc2_u_sequence = cell(1,N_og_images);

for T = 1:nDoubles
    ABorder = randperm(2);
    for i = 1:2
        sitch = ABorder(i);  
        TRIAL = (T-1)*2 + i;
        start = (sitch-1)*2 + 1;
        index = start + randi(1:2) -1;
        found = 0;
        while ~found
            if ~used(index)
                scenario_sequence{TRIAL} = og_scenarios{index};
                correct_sequence{TRIAL} = og_corrects{index};
                inc1_sequence{TRIAL} = og_inc1s{index};
                inc2_sequence{TRIAL} = og_inc2s{index};
                correct_u_sequence{TRIAL} = og_corrects_u{index};
                inc1_u_sequence{TRIAL} = og_inc1s_u{index};
                inc2_u_sequence{TRIAL} = og_inc2s_u{index};
                found = 1;
                used(index) = 1;
            else
                index = start + randi(2) -1;
            end
        end
    end
end
%make original textures in the pseudo-randomized order
for i = 1:N_og_images
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
