%Use the start and end joints distance to calculate a normalized
%position matix C, as shown in the lab manual
% (Normalized mean more of the form of matrix A -> [Cx, Cy]T)

% Use the helper function above to construct Matrix A
function [A] = dimToVector(startJoints, endJoints, uniqueJoints)
    Cx = C_constructor(startJoints,endJoints,uniqueJoints);
    Cy = C_constructor(startJoints,endJoints,uniqueJoints)


    A = [Cx;Cy];
end    


function [C] = C_constructor(startJoints, endJoints, uniqueJoints)
    n = size(uniqueJoints,1);
    m = size(startJoints,1);
    C = zeros(n,m);
    for i = 1:m
        for j = 1:size(uniqueJoints,1)
            C(j,i) = isequal(startJoints(i,:),uniqueJoints(j,:)) | isequal(endJoints(i,:),uniqueJoints(j,:));
        end    
    end
end
