function play_tone(timespec)
%
% This  plays a 1 second beep tones emitted at time of function call. The
% trigger event here is a key press. 
%%

% Select playback sampling rate of 44100 Hz:
freq = 44100;

% Select one channel mono playback:
nrchannels = 1;

% Open sound device 'pahandle' with specified freq'ency and number of audio
% channels for playback in timing precision mode on the default audio
% device:
InitializePsychSound(1);
pahandle = PsychPortAudio('Open', [], [], [], freq, nrchannels);

% Fill default audio buffer with a 378 Hz beep sound of 1 second duration:
snddata = MakeBeep(378, 1, freq);
PsychPortAudio('FillBuffer', pahandle, snddata);

% Enable use of sound schedules to define "playlists" of sounds to play:
PsychPortAudio('UseSchedule', pahandle, 1);

% Define relative sound onset times, relative to 'Start' of playback:
% Play sound immediately after 'triggerTime':
soundTime = [0];

% Define use of timed delays, relative to requested start of previous sound:
delayCmd = -(1+8);

% Play sound in audio buffer delaySound(1) seconds after base time:
PsychPortAudio('AddToSchedule', pahandle, delayCmd, delaysound(1));
PsychPortAudio('AddToSchedule', pahandle, 0);



    % Wait for some trigger signal, could be also Screen('flip',...) for
    % visual onset, define its occurence as baseline time 'triggerTime':
    triggerTime = timespec;
    
    % Start audio schedule, with times relative to 'triggerTime':
    PsychPortAudio('Start', pahandle, [], triggerTime);
    
    % Wait until sound schedule ends playing:
    fprintf('Waiting for audio schedule to finish playing.\n');
    PsychPortAudio('Stop', pahandle, 3);
    

% End of session, close down driver:
PsychPortAudio('Close', pahandle);

return;
