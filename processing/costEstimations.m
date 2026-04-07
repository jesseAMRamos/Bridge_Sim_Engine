% COST = C_L*L_total + C_j * J 
function [COST] = costs(startJoints, endJoints, uniqueJoints)
    COST = 10 * size(uniqueJoints,1)
    for i = 1:size(startJoints,1)
        COST = COST + sqrt((endJoints(i,1)-startJoints(i,1))^2 + (endJoints(i,2) - startJoints(i,2))^2);
    end
    
end   

