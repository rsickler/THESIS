%setup
og_correct_u_Folder = fullfile(workingDir, 'stimuli/og_correct_u');
og_correct_u_dir = dir(fullfile(og_correct_u_Folder));
og_corrects_u = {};
for i = 4:length(og_correct_u_dir)
    og_corrects_u{i-3} = og_correct_u_dir(i).name;
end

og_inc1_u_Folder = fullfile(workingDir, 'stimuli/og_inc1_u');
og_inc1_u_dir = dir(fullfile(og_inc1_u_Folder));
og_inc1s_u = {};
for i = 4:length(og_inc1_u_dir)
    og_inc1s_u{i-3} = og_inc1_u_dir(i).name;
end

og_inc2_u_Folder = fullfile(workingDir, 'stimuli/og_inc2_u');
og_inc2_u_dir = dir(fullfile(og_inc2_u_Folder));
og_inc2s_u = {};
for i = 4:length(og_inc2_u_dir)
    og_inc2s_u{i-3} = og_inc2_u_dir(i).name;
end

v_correct_u_Folder = fullfile(workingDir, 'stimuli/v_correct_u');
v_correct_u_dir = dir(fullfile(v_correct_u_Folder));
v_corrects_u = {};
for i = 4:length(v_correct_u_dir)
    v_corrects_u{i-3} = v_correct_u_dir(i).name;
end
v_inc1_u_Folder = fullfile(workingDir, 'stimuli/v_inc1_u');
v_inc1_u_dir = dir(fullfile(v_inc1_u_Folder));
v_inc1s_u = {};
for i = 4:length(v_inc1_u_dir)
    v_inc1s_u{i-3} = v_inc1_u_dir(i).name;
end
v_inc2_u_Folder = fullfile(workingDir, 'stimuli/v_inc2_u');
v_inc2_u_dir = dir(fullfile(v_inc2_u_Folder));
v_inc2s_u = {};
for i = 4:length(v_inc2_u_dir)
    v_inc2s_u{i-3} = v_inc2_u_dir(i).name;
end


%maincode
correct_u_sequence = [];
inc1_u_sequence = [];
inc2_u_sequence = [];
new_correct_u_bundle = cell(1,N_og_images);
new_inc1_u_bundle = cell(1,N_og_images);
new_inc2_u_bundle = cell(1,N_og_images);


                    new_correct_u_bundle{TRIAL} = og_corrects_u{index};
                    new_inc1_u_bundle{TRIAL} = og_inc1s_u{index};
                    new_inc2_u_bundle{TRIAL} = og_inc2s_u{index};

    correct_u_sequence = cat(2,correct_u_sequence,new_correct_u_bundle);
    inc1_u_sequence = cat(2,inc1_u_sequence, new_inc1_u_bundle);
    inc2_u_sequence = cat(2,inc2_u_sequence, new_inc2_u_bundle);

    og_correct_u_matrix = double(imread(fullfile(og_correct_u_Folder,correct_u_sequence{i})));
    og_correct_u_texture(i) = Screen('MakeTexture', mainWindow, og_correct_u_matrix);
    og_inc1_u_matrix = double(imread(fullfile(og_inc1_u_Folder,inc1_u_sequence{i})));
    og_inc1_u_texture(i) = Screen('MakeTexture', mainWindow, og_inc1_u_matrix);
    og_inc2_u_matrix = double(imread(fullfile(og_inc2_u_Folder,inc2_u_sequence{i})));
    og_inc2_u_texture(i) = Screen('MakeTexture', mainWindow, og_inc2_u_matrix);

P1_luck = {};


luck = rand;
if correct_movement
    if luck > .2
        DrawFormattedText(mainWindow,'+1','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, correct_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.GREEN,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
        P1_luck{trial} = 1;
    else
        DrawFormattedText(mainWindow,'+0','center',stim.textRow,COLORS.MAINFONTCOLOR,WRAPCHARS);
        Screen('DrawTexture', mainWindow, correct_u_texture(trial),[0 0 PICDIMS],[topLeft topLeft+PICDIMS.*RESCALE_FACTOR]);
        Screen('FrameRect', mainWindow, COLORS.RED,[topLeft topLeft+PICDIMS.*RESCALE_FACTOR],5);
        P1_luck{trial} = 0;
        
    end
end

    
