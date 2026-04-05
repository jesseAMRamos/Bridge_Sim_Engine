% COST = C_L*L_total + C_j * J 
function [COST] = costs(startJoints, endJoints, uniqueJoints)
    COST = length(uniqueJoints,1)
    for i = 1:length(uniqueJoints,1)
        COST = COST + (startJoints(i)-endJoints(i));
    end
    
end   

