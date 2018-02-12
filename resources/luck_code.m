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

    
