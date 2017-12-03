% here is the function
function startTime = start_time_func(mainWindow,text,horiz,COLOR,WRAPCHARS,timespec)
    DrawFormattedText(mainWindow,text,'center',horiz,COLOR,WRAPCHARS);
    if ~exist('timespec', 'var')
        timespec = GetSecs;
    end
    startTime = Screen('Flip',mainWindow, timespec);
return