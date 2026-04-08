% Basicly just invert A to solve for T
% Not too complicated
function [T] = forceCalculations(A,L)

    T = A \ (-L);
end

% I'm pretty sure we also need to find if members buckle
% under load (page 11 of manual)
% Talk to group to collectively understand how to do it