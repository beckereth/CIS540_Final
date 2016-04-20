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

[out, state] = findPath(in, state);


%if currently recieving a message from other plane, search for possible
%collisons and activate avoidance maneuver
if(not(isempty(in.m)))
    [other_out, other_state] = findPath(in.m, state);
    [self_next_x, self_next_y] = nextPosition(in.x, in.y, in.theta, out.val);
    [other_next_x, other_next_y] = nextPosition(in.m.x, in.m.y, in.m.theta, other_out.val);
    
    if(self_next_x == other_next_x && self_next_y == other_next_y)
        out = avoidCollision(out);
    elseif(self_next_x == in.m.x && self_next_y == in.m.y && other_next_x == in.x && other_next_y == in.y)
        out = avoidCollision(out);
    end

end
 
 end
 
function [ out ] = avoidCollision( out )
    if (out.val == -1)
        out.val = 1;
    else
        out.val = -1;
    end
end
 
function [ out, state ] = findPath( in, state )
%Basic path finding algorithm
%Plane follows current trajectory if target is further along current
%direction of flight. If it is at or past target along current direction it
%will turn in the direction necessayr to head to target along perpindicular
%axis.
out.val = 0;
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
    elseif(in.y < in.yd)
        out.val = -1;
    end
end
 end

 function[x,y] = nextPosition(in_x, in_y, theta, out)
    
    theta = out*90 + theta;
    if(theta >= 360)
        theta = theta - 360;
    elseif (theta < 0)
        theta = theta + 360;
    end

    if(theta == 0)
        x = in_x + 1;
        y = in_y;
    elseif(theta == 90)
        x = in_x;
        y = in_y + 1;
    elseif(theta == 180)
        x = in_x - 1;
        y = in_y;
    elseif(theta == 270)
        x = in_x;
        y = in_y - 1;
    end
    
 end
 