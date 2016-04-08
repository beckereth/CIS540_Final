 function [ out, state ] = controller( in, state )
% Takes flight parameters of an aircraft and outputs the direction control

% in: Data Structure that stores input information for the aircraft
% controller. 
%       (in.x, in.y): Current Location of the aircraft
%       (in.xd, in.yd): Destination of aircraft
%       in.theta: Current direction of motion
%       in.m: Message from neighbouring aircraft 
%           - empty if aircraft not in neighbourhood
%           - (x, y, xd, yd, theta) of other aircraft if non-empty
%           - To access data (say x) from in.m, use in.m.x
%
% out : Data Structure that stores the output information from the aircraft
%       out.val: +1, 0, -1 ( +1 - turn left, 0 - go straight, -1 - turn right)
% 
% state: 
%       any state used by the controller


% Initialize state
if (isempty(state))
    state.mode = 0; 
end
%need this statement otherwise it throws and error
out.val = 0;

%Basic path finding algorithm
%Plane follows current trajectory if target is further along current
%direction of flight. If it is at or past target along current direction it
%will turn in the direction necessayr to head to target along perpindicular
%axis.
if(in.theta == 0)
    if(in.x < in.xd)
        out.val = 0;
    elseif(in.y < in.yd)
        out.val = 1;
    elseif(in.y > in.yd)
        out.val = -1;
    elseif(in.x > in.xd)
        out.val = -1;
    end
elseif(in.theta == 90)
    if(in.y < in.yd)
        out.val = 0;
    elseif(in.x < in.xd)
        out.val = -1;
    elseif(in.x > in.xd)
        out.val = 1;
    elseif(in.y > in.yd)
        out.val = -1;
    end
elseif(in.theta == 180)
    if(in.x > in.xd)
        out.val = 0;
    elseif(in.y < in.yd)
        out.val = -1;
    elseif(in.y > in.yd)
        out.val = 1;
    elseif(in.x < in.xd)
        out.val = -1;
    end
elseif(in.theta == 270)
    if(in.y > in.yd)
        out.val = 0;
    elseif(in.x < in.xd)
        out.val = 1;
    elseif(in.x > in.xd)
        out.val = -1;
    elseif(in.y > in.yd)
        out.val = -1;
    end
end

% code for collision avoidance

    