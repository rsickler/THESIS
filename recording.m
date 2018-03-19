function recording(timespec,audio)

nrchannels = 1;
freq = 44100;

%read in audio file
[audiodata, ~] = audioread(audio);
pahandle = PsychPortAudio('Open', [], [], 1, freq, nrchannels);
PsychPortAudio('FillBuffer',pahandle, audiodata');

% start it immediately
PsychPortAudio('UseSchedule',pahandle,1); 
PsychPortAudio('AddToSchedule',pahandle); 
begin_time = PsychPortAudio('Start', pahandle, [], timespec);
end