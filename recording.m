function recording(trigger,situation)

% Perform basic initialization of the sound driver:
InitializePsychSound(1);
freq = 44100;
nrchannels = 1;
%pick audio file
if situation ==1 %full diagnal line
    [audiodata, infreq] = audioread('fullLine.mp3');
elseif situation == 2 %full diagnal cross
    [audiodata, infreq] = audioread('fullCross.mp3');
elseif situation == 3 %shwype
    [audiodata, infreq] = audioread('shwype.mp3');
elseif situation == 4 %tip ahead
    [audiodata, infreq] = audioread('tip.mp3');
end

pahandle = PsychPortAudio('Open', [], [], 1, freq, nrchannels);
PsychPortAudio('FillBuffer',pahandle, audiodata');

% start it immediately
PsychPortAudio('UseSchedule',pahandle,1); 
PsychPortAudio('AddToSchedule',pahandle); 
begin_time = PsychPortAudio('Start', pahandle, [], trigger);
end