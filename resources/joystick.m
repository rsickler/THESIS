% Define joystick and movement variables
ID = 1;
joy = vrjoystick(ID);
ky=[];
kx=[];

%record movement in matrix for 2 seconds
tEnd=GetSecs+200;
while GetSecs<tEnd 
    %find current spot
    x=axis(joy, 1);
    y=axis(joy, 2);
    % add current location to historical data
    ky(end+1)=y;
    kx(end+1)=x;
    % Plot marker to define end of joystick
    plot(x,y,'ro','MarkerSize',10,'MarkerFaceColor','r');
    hold on
    hold off
    % define plot axes
    axis([-1 1 -1 1])
    % force the plot
    drawnow;
    % delay between plots
    pause(.05)
end
