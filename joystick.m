% Define joystick and movement variables
ID = 1;
joy=vrjoystick(ID);
ky=[];
kx=[];

%record movement in matrix for 2 seconds
tEnd=GetSecs+20;
while GetSecs<tEnd 
    %find current spot
    x=axis(joy, 1);
    y=axis(joy, 2);
    % add current location to historical data
    ky(end+1)=y;
    kx(end+1)=x;
    % Plot marker to define end of joystick
    plot(x,y,'ro','MarkerSize',10,'MarkerFaceColor','r')
    hold on
    hold off
    % define plot axes
    axis([-1 1 -1 1])
    % force the plot
    drawnow;
    % delay between plots
    pause(.05)
end

%testing full straight ahead (A=hitline, C = set outside, D = block line)
if (y(end)<=.1) && (x(end)>=-.75)&& (x(end)<=.75) 
    fprintf('\n\n DID go full straight')
else 
    fprintf('\n\n didnt go full straight ahead')
end

%testing full diagnal away (A = hit cross, B = hit cross, D = block cross)
if (x>=.75) && (y<=0.1) 
    fprintf('\n\n DID go full diagnal away')
else 
    fprintf('\n\n didnt go full diagnal away')
end

%testing sharply to side away from body ( A = sharp cross, B = shwype out)
if (x>=.75) && (y>=-.1) && (y<=.75)
    fprintf('\n\n DID go sharp to side ')
else 
    fprintf('\n\n didnt go sharp to side')
end

%testing small move straight (A/B = tip ahead, C = set middle)
if (x(end)>=-.75)&& (x(end)<=.75) && (y(end)>=.1) && (y(end)<=.6)
    fprintf('\n\n DID make small move straight ahead')
else 
    fprintf('\n\n didnt make small move straight ahead')
end

%testing move back (C = set Dball, D = pull block back) 
if (x(end)>=-.75)&& (x(end)<=.75) && (y(end)>=.75)
    fprintf('\n\n DID move back ')
else 
    fprintf('\n\n didnt move back')
end

fprintf('\n\n')

correct_movement = (x<=-.75) && (y>=.1) && (y<=.6); %shwype
