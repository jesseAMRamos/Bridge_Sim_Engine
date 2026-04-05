%Use the start and end joints distance to calculate a normalized
%position matix C, as shown in the lab manual
% (Normalized mean more of the form of matrix A -> [Cx, Cy]T)

function [C,Sx,Sy,L] = dimToComponent(startJoints, endJoints, uniqueJoints, jointMap)
    C = [];
    
    for i = 1:length(startJoints)
        end_start = (endJoints(i) - start_end(i)) / sqrt(startJoints(i)^2 + endJoints(i)^2);
        start_end = (startJoints(i) - endJoints(i)) / sqrt(startJoints(i)^2 + endJoints(i)^2);
        C(i,jointMap(i)) = end_start;
        C(i,jointMap())
        
        

    end 
end

% Use the helper function above to construct Matrix A
function [A] = dimToVector(startJoints, endJoints, uniqueJoints)

end    