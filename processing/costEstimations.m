% COST = C_L*L_total + C_j * J 
function [COST] = costs(startJoints, endJoints, uniqueJoints)
    COST = length(startJoints,1)
    for i = 1:length(startJoints,1)
        COST = COST + sqrt((startJoints(i)^2-endJoints(i)^2));
    end
    
end   

