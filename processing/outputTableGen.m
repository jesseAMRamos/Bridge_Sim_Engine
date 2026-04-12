function [outputLines] = outputTableGen(memberForces, reactionForces, names, maxLoad,failJoint,load, cost)
    memberForces;
    reactionForces;
    outputLines = strings(size(memberForces,1) + size(reactionForces,1)) ;
    % Header
    %fprintf('EK301, Section A1, Group X: Name1, Name2, Name3, Date\n');
    %fprintf('Load: %g oz\n\n', load);
    outputLines(1) = 'EK301, Section A1, Group X: Jesse, Chaoming, Danny, Date: 12 April 2026';
    outputLines(2) = sprintf('Load: %g oz', load);
    % Member forces
    outputLines(3) = sprintf('Member forces in oz:');
    outputLines(4) = sprintf('Member %s will fail at %.3foz',failJoint,maxLoad);
    currentIndex = 5;
    n = size(memberForces,1);
    for i = currentIndex:currentIndex+n-1
        if memberForces(i-4) < 0
            label = 'C';
        else
            label = 'T';
        end
        outputLines(currentIndex) =sprintf('m%d(%s): %.3f (%s)', i-4,names(i-4), abs(memberForces(i-4)), label);
        currentIndex = currentIndex +1;
    end
    % Reaction forces
    outputLines(currentIndex) = sprintf('\nReaction forces in oz:');
    reactionLabels = {'Sx1', 'Sy1', 'Sy2'};
    currentIndex = currentIndex+1;
    for i = 1:3
        outputLines(currentIndex) = sprintf('%s: %.3f', reactionLabels{i}, reactionForces(i));
        currentIndex = currentIndex +1;
    end
    % Cost and ratio
    outputLines(currentIndex+1) = sprintf('\nCost of truss: $%.2f', cost);
    
    %Theoretical max load/cost ratio in oz/$: 0.0031
    outputLines(currentIndex+2) = sprintf('Load/cost ratio: %.4f oz/$', maxLoad/cost);
    
    outputLines = strjoin(outputLines, '\n');

end 
