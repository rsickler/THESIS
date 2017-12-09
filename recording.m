function recording(trigger,situation)

% Perform basic initialization of the sound driver:
InitializePsychSound(1);
freq = 44100;
nrchannels = 1;
%pick audio file
if situation ==1
    [audiodata, infreq] = audioread('imagine.mp3');
else 
    [audiodata, infreq] = audioread('go.mp3');
end

pahandle = PsychPortAudio('Open', [], [], 1, freq, nrchannels);
PsychPortAudio('FillBuffer',pahandle, audiodata');

% start it immediately
PsychPortAudio('UseSchedule',pahandle,1); 
PsychPortAudio('AddToSchedule',pahandle); 
begin_time = PsychPortAudio('Start', pahandle, [], trigger);
end