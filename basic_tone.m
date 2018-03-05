function basic_tone(start_time,duration, pahandle)

% start it immediately
PsychPortAudio('UseSchedule',pahandle,1); 
PsychPortAudio('AddToSchedule',pahandle,0); 
begin_time = PsychPortAudio('Start', pahandle, [], start_time);

end