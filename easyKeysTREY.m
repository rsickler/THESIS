% syntax: datastruct = EASYKEYS(datastruct [, onset]  ['cresp_keycode'] ['cresp_map'] 
%                    ['valid_keycode'], ['valid_map'],
%               [, respmap] [, stim] [, cond] [, cresp] [, prompt_dur]
%               [, nesting] [, next_window] [,info] [,simulated_key])
%
%   [] = optional parameters
%
% DESCRIPTION
%
%   easyKeys is intended as a quick way to gather and organize keypress 
%   response data. Each call to the function is a 'trial' in which more
%   data are collected. It builds and logs a structure prepared by 
%   initEasyKeys that can be easily saved and later analyzed in matlab, and 
%   which contains much of the important information you would normally
%   hope to collect upon prompting for a response. It also attempts to
%   reduce the burden of gathering a response by assuming the format of
%   your test question will remain the same across instances: most
%   parameters are set once using initEasyKeys and can then be forgotten.
%
%   The function saves all of its information after each resposn and is
%   logged (to both a matlab and text file) in case disaster strikes in
%   your matlab session. It can also optionally report helpful output to
%   the console so you can see how your paripant is doing.
% 
%   If you did not set a default cresp when initializing the datastruct,
%   then this function is going to insist that you provide a trial-wise
%   cresp here.
% 
%
% USAGE
%
%   D = EASYKEYS(S) returns a datastruct using EASYKEYS default values. S 
%   is a test-specific data structure prepared by running initEasyKeys to 
%   specify test-related parameters like valid keys, maximum time duration,
%   etc.
%
%   D = EASYKEYS(S,PARAM1,VAL1,PARAM2,VAL2...) sets various optional
%   parameters. Parameters are case-insensitive, and each string parameter
%   must be followed by a value as indicated:
%
%   'onset'     Numeric Scalar.
%               Start time of the trial. It is better to use the time
%               returned by, e.g., your draw command than the onset of this
%               function for more accurate measurement. However, if you
%               leave this field empty, the duration will begin from the
%               time this function is launched.
%
%               Default: output of GetSecs command
%
%  
%
%   'respmap'   Table mapping keys to numeric values.
%               Defines the semantic and numerical "meaning" of each key
%               specified in 'keys'. Use makeMap to generate this map. This
%               could be useful e.g., to facilitate interpretation of key
%               presses, or for use with a scale where the user ultimately
%               plans to perform computations on response values. If you do
%               not specify a respmap, keys will be described by their
%               names and numerical values will reflect their position in
%               "keys". If you did not provide a default_respmap during
%               initialization, you will be required to enter one here.
%
%               Default: empty table
%
%   'stim'      String.
%               A string describing the stimulus presented in this trial.
%               Specify here to store the information in your datastruct
%               and enhance console and text-file data-logging. If omitted
%               or repeated, a generated string containing repeat count
%               will be used in its place. stim is used as a row name for
%               the trial table.
%
%               Default: '---'
%
%   'cond'      Scalar positive integer.
%               A positive integer specifying the condition to which the
%               current trial belongs. If omitted or left empty, condition
%               -1 will be recorded. If a condmap was specified in
%               initEasyKeys, a corresponding condition string will be
%               reported. Alternatively, a condition can be entered by
%               name. If no condition in the condmap matches the string,
%               the condition will be appended to the condmap.
%
%               Default: -1
%
%   'cresp'     Cell array of strings or NaN's.
%               The key labels or keys that should be treated as being 
%               correct responses (NOT their respmap value). If there is no 
%               one correct answer, omit this parameter, and all valid
%               responses will be treated as correct (unless you specified
%               a default_cresp with initEasyKeys). NaN indicates that a 
%               null response is correct. If there is more than one correct
%               key, specify cresp as a cell array of strings (with NaN as
%               a valid element as well).
%
%               Default: {}
%
%   'prompt_dur' Numeric positive scalar.
%               The maximum period, specified in seconds, for which you 
%               would like to present participants with the initial
%               promptscreen while waiting for a response. Specify a
%               duration of 0 to sample for a current keypress and then
%               exit. If you did not provide a default prompt_dur during
%               initialization, you will be required to enter one here.
%
%               Default: []
%
%   'nesting'   Numeric vector of positive integers.
%               Used to specify the nested structure of trials in an
%               experiment. The supplied vector can be of any length, but
%               the nesting vector must be of consistent length across all
%               trials of an experiment. If the nesting structure has more
%               than one layer (i.e. more than one element in the nesting
%               vector), this parameter must be explicitly supplied for
%               each trial in the experiment. If a single-element nesting
%               vector is supplied to the first trial, this parameter does
%               not need to be supplied with each call, and will be instead
%               incremented by one automatically from the previous trial
%               nesting value.
%
%               Default: trial number
%
%   'next_window' Window pointer.
%               If a pre-drawn psychtoolbox window is supplied to the
%               function, then easyKeys will present it immediately after 
%               the specified prompt/trial duration has elapsed. If a 
%               listen_dur was specified in initEasyKeys, then easyKeys 
%               will continue to listen for responses during that interval 
%               (while this next_window is on the screen) before exiting, 
%               and a pre-drawn window will be a required argument.
%
%               Default: []
%
%   'simulated_key' Char or NaN.
%               A key entered using this parameter is treated as a keypress
%               submitted immediately upon calling easyKeys. This could be
%               useful for testing your experiment code, recording a
%               response at a different time than it is collected, or
%               logging things that are happening in your experiment
%               that do not involve a user response.
%
%               Default: []
%
%   'info' Any data type.
%               Populate this field with any kind of meta-data about the
%               trial. It will be associated with that trial and remain 
%               available for later reference in the datastruct. Unlike
%               simulated_key, it will not be processed using a "key"
%               framework (e.g., checked against valid keys, evaluated for
%               accuracy, etc.
%
%               Default: {}
%
%
% OUTPUT
%
%   datastruct: a data structure containing the various parameters that
%               were provided to the initEasyKeys initialization function, 
%               as well as response data from each call to easyKeys. Fields
%               corresponding to absent optional parameters are set to
%               default values.
%
%
% DEPENDENCIES
%
%   Requires PsychToolbox and SuperPsychToolbox.
%
% 
% Written by J. Poppenk May 23, 2013 @ Princeton University

function datastruct = easyKeysTREY(datastruct, varargin)

% check inputs
p = inputParser;
p.FunctionName = 'easyKeys'; % name of function included in error messages
p.PartialMatching = true; % leading substrings of paramater names are accepted
p.StructExpand = true; % can interpret structure array

% check datastruct
%checkEasyObj(datastruct,p.FunctionName);

if ~any(strcmp(varargin, 'onset'))
    onset = GetSecs;
else
    ind = find(strcmp(varargin, 'onset'));
    onset = varargin{ind + 1};
end
if ~any(strcmp(varargin, 'respmap')) %if you didn't specify respmap
    if ~isempty(datastruct.params.default_respmap{1}) % was there already specified one?
        respmap = datastruct.params.default_respmap{1};
    else
        respmap = table();
    end
else %if you're using what you just specified
    ind = find(strcmp(varargin, 'respmap'));
    respmap = varargin{ind + 1};
    respmap = makeMap([], [], [], respmap); %if it exists make it into a rep map
end
if ~any(strcmp(varargin, 'stim'))
    stim = '---';
else
    ind = find(strcmp(varargin, 'stim'));
    stim = varargin{ind + 1};
end

if ~any(strcmp(varargin, 'cond'))
    cond = -1;
else
    ind = find(strcmp(varargin, 'cond'));
    cond = varargin{ind + 1};
end

if ~any(strcmp(varargin, 'cresp'))
    cresp = {};
else
    ind = find(strcmp(varargin, 'cresp'));
    cresp = varargin{ind + 1};
end
if ~any(strcmp(varargin, 'prompt_dur'))
    prompt_dur = [];
else
    ind = find(strcmp(varargin, 'prompt_dur'));
    prompt_dur = varargin{ind + 1};
end
if ~any(strcmp(varargin, 'nesting'))
    nesting = [];
else
    ind = find(strcmp(varargin, 'nesting'));
    nesting = varargin{ind + 1};
end
if ~any(strcmp(varargin, 'next_window'))
    next_window = [];
else
    ind = find(strcmp(varargin, 'next_window'));
    next_window = varargin{ind + 1};
end
if ~any(strcmp(varargin, 'simulated_key'))
    simulated_key = [];
else
    ind = find(strcmp(varargin, 'simulated_key'));
    simulated_key = varargin{ind + 1};
end
if ~any(strcmp(varargin, 'info'))
    info = {};
else
    ind = find(strcmp(varargin, 'info'));
    info = varargin{ind + 1};
end

ind = find(strcmp(varargin, 'cresp_map'));
cresp_map = varargin{ind+1};

ind = find(strcmp(varargin, 'valid_map'));
valid_map = varargin{ind+1};
%    [, onset]  ['cresp_map'] 
%                   ['valid_map'],
%               [, respmap] [, stim] [, cond] [, cresp] [, prompt_dur]
%               [, nesting] [, next_window] [,info] [,simulated_key])
    

    
    %% prepare current trial parameters
    
    % identify current trial
    n = height(datastruct.trials) + 1;
    
    % assign the subject name to the trialstruct
    trialstruct.ppt_name{1} = datastruct.params.ppt_name{1};

    % add onset to datastruct
    trialstruct.onset = round(1000 * (onset - datastruct.params.exp_onset(1))) / 1000;
    
    % log respmap for each trial
    trialstruct.respmap{1} = respmap;
    
     
    % find index of elements which are not NaN in cresp
    not_nan = cellfun(@(x) ~all(isnan(x)), cresp);
    
    % prepare cresp
    if ~isempty(datastruct.params.default_cresp{1})
        if trueDat(cresp)
            disp('SPTB-INFO: overriding default cresp specified in initEasyKeys.');
        else cresp = datastruct.params.default_cresp{1};
        end
    end
    
    trialstruct.cresp_key{1} = cresp;

    
    % resp field for manual scoring later on
    trialstruct.resp_man = NaN;
    if ~iscell(info)
        trialstruct.info{1} = {info};
    else trialstruct.info{1} = info;
    end
    
    % prepare trial duration
            
    if ~isnan(datastruct.params.prompt_dur) %if already specfied duration
        if trueDat(prompt_dur) %if also specified here
            duration = prompt_dur;
        else duration = datastruct.params.prompt_dur;
        end
    else
        duration = prompt_dur;
    end
    % no matter where you got it, take out 50 ms
    duration = duration - 0.05;
    % check for unspecified nesting vectors, or inconsistent lengths. Also
    % reshape the nesting vector to ensure consistency as a row vector
    if isempty(nesting)
        if n == 1
            % this is the first trial of the experiment
            nesting = 1;
        elseif length(datastruct.trials.nesting{end}) == 1
            % increment the nesting vector by one from previous value
            nesting = datastruct.trials.nesting{end} + 1;
        else
            error(['nesting vector must be specified explicitly when ' ...
                'there is more than one layer of trial nesting.']);
        end
    elseif n ~= 1
        if length(nesting) ~= length(datastruct.trials.nesting{end})
            error(['nesting vector must have equal length across all trials ' ...
                'of an experiment.']);
        end
    end
    trialstruct.nesting{1} = reshape(nesting, 1, length(nesting));

    
    % find a suitable name for stim in case of empty or duplicate stim
    orig_stim = stim;
    if strcmp(stim, '---') || isempty(stim), stim = 'empty stim'; end
    stim_match = @(x) length(x) >= length(stim) && ...              % matching stim could be shorter in case of repeat
                strcmp(stim, x(1:min(length(x),length(stim)))) && ... % compare first portion
                (length(stim)==length(x) || ...                       % they should be the same length, or
                (length(x)>length(stim)+10 && strcmp(x(length(stim)+1:length(stim)+9),' (repeat '))); % different followed by "repeat"
    matches = cellfun(stim_match, datastruct.trials.Properties.RowNames);
    if sum(matches)>0, stim = [stim ' (repeat ' num2str(sum(matches)) ')']; end
    
    % log stimulus string input
    if ~strcmp(stim, '---') % stim was provided if true
        
        % check whether there is a corresponding stimulus id available
        if isempty(datastruct.stimmap), stimpos = [];
        else stimpos = find(strcmp(datastruct.stimmap.descriptors,orig_stim),1,'first');
        end
        
        if ~isempty(stimpos)
            trialstruct.stim_id = datastruct.stimmap.values(stimpos);
        % if it's not in our existing stimmap, append a new entry for
        % this stimulus map
        else
            if isempty(datastruct.stimmap)
                newID = 1;
            else
                newID = max(datastruct.stimmap.values) + 1;
            end
            row = cell2table({stim}, 'VariableNames', {'descriptors'}, 'RowNames', {stim});
            row = [row array2table(newID, 'VariableNames', {'values'})];
            datastruct.stimmap = [datastruct.stimmap; row]; % append new row to stimmap
            trialstruct.stim_id = newID;
        end
    % handle empty stim
    else
        % check whether an empty stimuli is in the stimmap already
        if isempty(datastruct.stimmap)
            stimpos = [];
        else
            stimpos = find(strcmp(datastruct.stimmap.descriptors, stim), 1, 'first');
        end
        
        trialstruct.stim_id = -1;
        
        % update stimmap if necessary
        if isempty(stimpos)
            row = cell2table({stim}, 'VariableNames', {'descriptors'}, 'RowNames', {stim});
            row = [row array2table(trialstruct.stim_id, 'VariableNames', {'values'})];
            
            % append the empty stim entry to stimmap
            datastruct.stimmap = [datastruct.stimmap; row];
        end
    end
    
    % assign condition input
    if cond ~=-1 % cond was provided if true
        
        % handle numeric values for cond
        if isnumeric(cond)
            if (round(cond)~=cond) || cond <= 0
                error('if a numeric cond is specified, it must be a positive integer');
            end
            trialstruct.cond = cond;

            % check whether there is a corresponding condition map entry available
            if isempty(datastruct.condmap)
                pos = [];
            else
                pos = find(datastruct.condmap.values == cond,1,'first');
            end
                
        % handle string cond
        elseif ischar(cond)
            % check whether there is a corresponding condition map entry available
            if isempty(datastruct.condmap)
                pos = [];
            else
                pos = find(strcmp(datastruct.condmap.descriptors,cond),1,'first');
            end
        else
            error('invalid condition parameter (if specified, must be either a positive integer or string)');
        end

        % gather values
        if ~isempty(pos)
            trialstruct.cond = datastruct.condmap.values(pos);
            trialstruct.cond_str{1} = datastruct.condmap.descriptors{pos};
        
        % handle new condition
        else
            % update condmap
            if isnumeric(cond)
                row = cell2table({num2str(cond)}, 'VariableNames', {'descriptors'}, ...
                    'RowNames', {num2str(cond)});
                row = [row array2table(cond, 'VariableNames', {'values'})];
            elseif ischar(cond)
                if isempty(datastruct.condmap)
                    oldmax = 0;
                else
                    oldmax = max(datastruct.condmap.values);
                end
                if isempty(oldmax), oldmax = 0; end
                row = cell2table({cond}, 'VariableNames', {'descriptors'}, ...
                    'RowNames', {cond});
                row = [row array2table(oldmax+1, 'VariableNames', {'values'})];
            end
            % append new entry to condmap
            datastruct.condmap = [datastruct.condmap; row];
            
            % record data
            trialstruct.cond = datastruct.condmap.values(end);
            trialstruct.cond_str{1} = datastruct.condmap.descriptors{end};
        end
            
    % handle empty cond
    else
        % check whether an empty condition is in the condmap already
        if isempty(datastruct.condmap)
            pos = [];
        else
            pos = find(datastruct.condmap.values == cond, 1, 'first');
        end
        
        trialstruct.cond = cond;
        trialstruct.cond_str{1} = '---';
        
        % update condmap if necessary
        if isempty(pos)
            row = cell2table(trialstruct.cond_str(1), 'VariableNames', {'descriptors'}, ...
                'RowNames', trialstruct.cond_str(1));
            row = [row array2table(trialstruct.cond, 'VariableNames', {'values'})];

            % append the empty condition entry to condmap
            datastruct.condmap = [datastruct.condmap; row];
        end
    end

    
    %% begin multiple choice data collection
    [trialstruct.acc, trialstruct.resp, trialstruct.rt, trialstruct.acc_str{1}, ...
        trialstruct.resp_str{1}, trialstruct.resp_key{1}, trialstruct.rt_str{1}, trialstruct.exit_code{1}] = ...
        multiChoice(duration, respmap.inputs, respmap, trialstruct.cresp_key{1}, onset, datastruct.params.device, simulated_key,  ...
        cresp_map, valid_map);

    % delay offset if we get an early response but duration period is fixed
    if ~datastruct.params.trigger_next
        % check if there is a second supplied window
        if ~isempty(next_window)% next_window was supplied if true
            inter_frame_interval = Screen('GetFlipInterval', next_window); % flip interval time
            adjustment = inter_frame_interval / 2;
            while (GetSecs() - datastruct.params.exp_onset) - (trialstruct.onset) - adjustment < duration
                WaitSecs(adjustment);
            end
        else WaitSecs(duration - ((GetSecs() - datastruct.params.exp_onset) - trialstruct.onset));
        end
    end
    
    % clear the window and record onscreen stimulus duration
    if ~isempty(next_window) % window_next was supplied if true
        offset = Screen('Flip',next_window);
    else offset = GetSecs;
    end
    trialstruct.prompt_offset = round(1000 * (offset - datastruct.params.exp_onset(1))) / 1000;
    trialstruct.dur = round(1000 * (offset - onset)) / 1000;
    trialstruct.dur_err = round(1000 * (duration - (offset - onset))) / 1000;
    
    % for logging purposes, translate cresp into equivalent respmap values
    foundKeys = [];
    if length(cresp) == 1 && all(isnan(cresp{1}))
        trialstruct.cresp{1} = NaN;
        trialstruct.cresp_str{1} = 'NR';
    else
        for i=1:length(cresp)
            foundKeys = [foundKeys find(strcmp(respmap.inputs,cresp{i}))];
        end
        sorted_cresp = sort(foundKeys);
        trialstruct.cresp{1} = respmap.values(sorted_cresp);
        trialstruct.cresp_str{1} = [];
        for i = 1:length(trialstruct.cresp{1})
            if (i > 1) && (i < length(trialstruct.cresp{1}) + 1)
                trialstruct.cresp_str{1} = [trialstruct.cresp_str{1} ', '];
            end
            trialstruct.cresp_str{1} = [trialstruct.cresp_str{1} respmap.descriptors{sorted_cresp(i)}];
        end
    end
    
    % if instructed, listen for a little longer
    if trueDat(datastruct.params.listen_dur)

        if strcmp(trialstruct.resp_str{1},'NR')
            % resume listening
            [trialstruct.acc, trialstruct.resp, trialstruct.rt, trialstruct.acc_str{1}, ...
        trialstruct.resp_str{1}, trialstruct.resp_key{1}, trialstruct.rt_str{1}, trialstruct.exit_code{1}] = ...
                multiChoice(datastruct.params.listen_dur, respmap.inputs, respmap, ...
                    trialstruct.cresp_key{1}, GetSecs, datastruct.params.device, simulated_key, cresp_map, valid_map);

            % correct output for extra listening time
            if ~strcmp(trialstruct.resp_str{1},'NR')
                trialstruct.rt = trialstruct.rt + trialstruct.dur;
                trialstruct.rt_str{1} = num2str(round(trialstruct.rt));
            end
        end

        % delay return to calling function in case of an early response to ensure a constant listening window
        while (GetSecs() - datastruct.params.exp_onset) - (trialstruct.onset) < (duration + datastruct.params.listen_dur)
            WaitSecs(0.0005);
        end
    end
    
    
    %% revise offset and duration info if we still haven't flipped yet
    trialstruct.offset2 = round(1000 * (GetSecs - datastruct.params.exp_onset(1))) / 1000;
    trialstruct.total_dur = round(1000 * (trialstruct.offset2 - trialstruct.onset)) / 1000;
    trialstruct.total_dur_err = round(1000 * (duration - trialstruct.total_dur)) / 1000;
    
    % initialize resp_auto fields
    trialstruct.resp_auto = {[]};
    trialstruct.resp_auto_labels = {{}};
    
    % append trial data to the datastruct table
    trialtable = struct2table(trialstruct, 'RowNames', stim);
    datastruct.trials = [datastruct.trials; trialtable];
        
    % save result
    if any(strcmp('fn_matlab', datastruct.params.Properties.VariableNames)) ...
            && trueDat(datastruct.params.fn_matlab{1}) && ischar(datastruct.params.fn_matlab{1})
        save(datastruct.params.fn_matlab{1},'datastruct');
    end

    
    %% append result to text file

    % open file
    if trueDat(datastruct.params.fn_text{1}) && ischar(datastruct.params.fn_text{1})
        fid = fopen(datastruct.params.fn_text{1},'a');

        % write header
        header_str = '''trial'',''ons(s)'',''stim_id'',''stim'',''cond'',''dur'',''rt'',''acc'',''resp'',''cresp''';
        format_str = ['%-4s\t' '%-6s\t' '%-4s\t' '%-10s\t' '%-8s\t' '%-4s\t' '%-4s\t' '%-4s\t' '%-8s\t' '%-8s\n'];
        if n==1
            if datastruct.params.console
                eval(['fprintf(''' format_str ''',' header_str ');']);
            end
            if fid ~= -1
                eval(['fprintf(fid,''' format_str ''',' header_str ');']);
            end
        end

        % write trial data
        dataStr =  ['num2str(n), '... %trial
                    'num2str(round(trialstruct.onset*10)/10), ' ... % onset
                    'num2str(trialstruct.stim_id), ' ... % stim_id
                    'stim{1}, ' ... % stim
                    'trialstruct.cond_str{1}, ' ... % cond
                    'num2str(trialstruct.dur), ' ... % dur
                    'trialstruct.rt_str{1}, ' ... % rt
                    'trialstruct.acc_str{1},' ...  % acc
                    'trialstruct.resp_str{1}, ' ... % resp
                    'trialstruct.cresp_str{1}']; % cresp
        if isfield(datastruct,'console') && trueDat(datastruct.params.console)
            eval(['fprintf(''' format_str ''',' dataStr ');']);
        end
        if fid ~= -1
            eval(['fprintf(fid,''' format_str ''',' dataStr ');']);
            fclose(fid);
        end
    end
    
return