%Use the start and end joints distance to calculate a normalized
%position matix C, as shown in the lab manual
% (Normalized mean more of the form of matrix A -> [Cx, Cy]T)
function [A, r] = dimToVector(startJoints, endJoints, uniqueJoints)
    n = size(uniqueJoints, 1);
    m = size(startJoints, 1);
    Cx = zeros(n, m);
    Cy = zeros(n, m);
    r  = zeros(m, 1);

    for i = 1:m
        x1 = startJoints(i,1);  y1 = startJoints(i,2);
        x2 = endJoints(i,1);    y2 = endJoints(i,2);
        r(i) = sqrt((x2-x1)^2 + (y2-y1)^2);

        for j = 1:size(uniqueJoints, 1)
            if isequal(startJoints(i,:), uniqueJoints(j,:))
                Cx(j,i) = (x2-x1)/r(i);
                Cy(j,i) = (y2-y1)/r(i);
            elseif isequal(endJoints(i,:), uniqueJoints(j,:))
                Cx(j,i) = (x1-x2)/r(i);
                Cy(j,i) = (y1-y2)/r(i);
            end
        end
    end

    A = [Cx; Cy];
end