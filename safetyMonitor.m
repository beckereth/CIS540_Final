function [ flag ] = safetyMonitor( in1, in2, in1p, in2p )
% in1, in2: Data Structure that stores information about the aircraft
%       (x, y): Current Location of the aircraft
%       (xd, yd): Destination of aircraft
%       theta: Current direction of motion
%       m: Message from neighbouring aircraft 
%           - empty if aircraft not in neighbourhood
%           - (x, y, xd, yd, theta) of other aircraft if non-empty
%
% flag: true if the safety is voilated and false otherwise.

flag = false;
disp(in1)
disp(in2p)
if(in1.x == in2.x && in1.y == in2.y)
    flag = true;
elseif(in1.x == in2p.x && in1.y == in2p.y && in2.x == in1p.x && in2.y == in1p.y)
    flag = true;
else
    flag = false;
end

end

