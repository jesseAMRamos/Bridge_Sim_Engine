function [outputLines] = outputTableGen(memberForces, reactionForces, names, load, cost)
    memberForces;
    reactionForces;
    outputLines = strings(size(memberForces,1) + size(reactionForces,1)) ;
    % Header
    %fprintf('EK301, Section A1, Group X: Name1, Name2, Name3, Date\n');
    %fprintf('Load: %g oz\n\n', load);
    outputLines(1) = 'EK301, Section A1, Group X: Jesse, Chaoming, Danny, Date: 12 April 2026';
    outputLines(2) = sprintf('Load: %g oz\n\n', load);
    % Member forces
    outputLines(3) = sprintf('Member forces in oz:\n');
    currentIndex = 4;
    n = size(memberForces,1);
    for i = currentIndex:currentIndex+n-1
        if memberForces(i-3) < 0
            label = 'C';
        else
            label = 'T';
        end
        outputLines(currentIndex) =sprintf('m%d(%s): %.3f (%s)', i-3,names(i-3), abs(memberForces(i-3)), label);
        currentIndex = currentIndex +1;
    end
    % Reaction forces
    outputLines(currentIndex) = sprintf('\nReaction forces in oz:\n');
    reactionLabels = {'Sx1', 'Sy1', 'Sy2'};
    currentIndex = currentIndex+1;
    for i = 1:3
        outputLines(currentIndex) = sprintf('%s: %.3f\n', reactionLabels{i}, reactionForces(i));
        currentIndex = currentIndex +1;
    end
    % Cost and ratio
    outputLines(currentIndex+1) = sprintf('\nCost of truss: $%.2f', cost);
    
    %Theoretical max load/cost ratio in oz/$: 0.0031
    outputLines(currentIndex+2) = sprintf('Load/cost ratio: %.4f oz/$', load/cost);
    
    outputLines = strjoin(outputLines, '\n');

end 
