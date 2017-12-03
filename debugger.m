% PHASE 1
% try
%     % PHASE 2
%     SUBJECT = 1;
%     SUBJ_NAME = 'Trey';
%     SESSION = 2;
%     phase2(SUBJECT, SUBJ_NAME, SESSION);
% catch ME
%     disp(['ID: ' ME.identifier])
%     rethrow(ME)
% end


SETUP; 
instruct = 'Loading Phase 2...';
displayText(mainWindow, instruct, INSTANT, 'center',COLORS.MAINFONTCOLOR, WRAPCHARS);

% PSEUD0-RANDOMIZE
scenario_sequence = [];
correct_sequence = [];
inc1_sequence = [];
inc2_sequence = [];
correct_u_sequence = [];
inc1_u_sequence = [];
inc2_u_sequence = [];
used_variants = zeros(1,N_v_images);

% make series of 4 bundles (each variant image shown 1 time)
for i =1:4
    %add a variant scenario to all 4 orignals to make bundle of 5
    ran1 = randi(4);
    ran2 = 5+randi(4)-1;
    done = 0;
    while ~done
        if used_variants(ran1) < 1 
            if used_variants(ran2) < 1
                scenario_bundle = cat(2,og_scenarios, v_scenarios(ran1));
                scenario_bundle = cat(2,scenario_bundle, v_scenarios(ran2));
                correct_bundle = cat(2,og_corrects, v_corrects(ran1));
                correct_bundle = cat(2,correct_bundle, v_corrects(ran2));
                inc1_bundle = cat(2,og_inc1s, v_inc1s(ran1));
                inc1_bundle = cat(2,inc1_bundle, v_inc1s(ran2));
                inc2_bundle = cat(2,og_inc2s, v_inc2s(ran1));
                inc2_bundle = cat(2,inc2_bundle, v_inc2s(ran2));
                correct_u_bundle = cat(2,og_corrects_u, v_corrects_u(ran1));
                correct_u_bundle = cat(2,correct_u_bundle, v_corrects_u(ran2));
                inc1_u_bundle = cat(2,og_inc1s_u, v_inc1s_u(ran1));
                inc1_u_bundle = cat(2,inc1_u_bundle, v_inc1s_u(ran2));
                inc2_u_bundle = cat(2,og_inc2s_u, v_inc2s_u(ran1));
                inc2_u_bundle = cat(2,inc2_u_bundle, v_inc2s_u(ran2));
                shuffler = randperm(10);
                for i= 1:10
                    new_scenario_bundle(i) = scenario_bundle(shuffler(i));
                    new_correct_bundle(i) = correct_bundle(shuffler(i));
                    new_inc1_bundle(i) = inc1_bundle(shuffler(i));
                    new_inc2_bundle(i) = inc2_bundle(shuffler(i));
                    new_correct_u_bundle(i) = correct_u_bundle(shuffler(i));
                    new_inc1_u_bundle(i) = inc1_u_bundle(shuffler(i));
                    new_inc2_u_bundle(i) = inc2_u_bundle(shuffler(i));
                end
                scenario_sequence = cat(2,scenario_sequence, new_scenario_bundle);
                correct_sequence = cat(2,correct_sequence,new_correct_bundle);
                inc1_sequence = cat(2,inc1_sequence, new_inc1_bundle);
                inc2_sequence = cat(2,inc2_sequence, new_inc2_bundle);
                correct_u_sequence = cat(2,correct_u_sequence,new_correct_u_bundle);
                inc1_u_sequence = cat(2,inc1_u_sequence, new_inc1_u_bundle);
                inc2_u_sequence = cat(2,inc2_u_sequence, new_inc2_u_bundle);
                % tally use of variants
                used_variants(ran1) = used_variants(ran1)+1;
                used_variants(ran2) = used_variants(ran2)+1;
                done = 1;
            else
                ran2 = 5+randi(4)-1;
            end
        else
            ran1 = randi(4);
        end
    end
end
