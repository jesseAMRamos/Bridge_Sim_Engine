% Will be master command to bring computations together
% layer to interacts directly with files
% generate the design_file.mat that will be submitted

function [Tension,names,condition] = design_filer(F,jointIndex)
    loaded = load('dim_table.mat');
    tableData = loaded.tableData;
    %columnNames = loaded.columnNames;
    % Strip empty rows
    mask = ~cellfun(@isempty, tableData(:,1));
    tableData = tableData(mask, :);
    n = size(tableData,1);
    joints    = zeros(n, 2);
    memberEnds = zeros(n, 2);
    %convert from strings to doubles
    for i = 1:length(tableData)
        joints(i,:) = [str2double(tableData{i,1}),str2double(tableData{i,2})];
        memberEnds(i,:) = [str2double(tableData{i,3}),str2double(tableData{i,4})];
    end
    
    [uniqueJoints,~,jointMap] = unique([joints;memberEnds], 'rows', 'stable');
    condition = size(joints,1) == 2*size(uniqueJoints,1) -3;
    %jointMap
    %jointMap
    %example on how to index map
    %{
        for i = 1:size(joints(:,1))
        disp(joints(i,:))
        disp(uniqueJoints(jointMap(i),:))
    end  
    %}
    
    [A,names,r] = dimToVector(joints,memberEnds,uniqueJoints);
    index = 0;
    big = uniqueJoints(1,1);
    for i = 2:size(uniqueJoints,1)
        if uniqueJoints(i,1) >= big
            big = uniqueJoints(i,1);
            index = i;
        end
    end
    Sx = zeros(size(uniqueJoints,1), 3);
    Sy = zeros(size(uniqueJoints,1), 3);
    Sx(1,1) = 1;
    Sy(1,2) = 1;
    Sy(index,3) = 1; 
    A =  [A [Sx;Sy]]
    
    L = zeros(2*size(uniqueJoints,1),1);
    L(size(uniqueJoints,1)+jointIndex,1) = F
    
    Tension = forceCalculations(A,L);
    function [] = display(T,N)
        num= size(N,1);
        for i = 1:num
            fprintf("Member %s experiences %.2f \n",N(i),T(i));
        end 
        fprintf("Sx1 = %.2f \n,",T(num-2));
        fprintf("Sy1 = %.2f \n",T(num-1));
        fprintf("Sy2 = %.2f \n",T(num));
    end 
end

% function printResults(memberForces, reactionForces, memberLengths, load, cost)
%     % Header
%     fprintf('EK301, Section A1, Group X: Name1, Name2, Name3, Date\n');
%     fprintf('Load: %g oz\n\n', load);
% 
%     % Member forces
%     fprintf('Member forces in oz:\n');
%     for i = 1:length(memberForces)
%         if memberForces(i) < 0
%             label = 'C';
%         else
%             label = 'T';
%         end
%         fprintf('m%d: %.3f (%s)\n', i, abs(memberForces(i)), label);
%     end
% 
%     % Reaction forces
%     fprintf('\nReaction forces in oz:\n');
%     reactionLabels = {'Sx1', 'Sy1', 'Sy2'};
%     for i = 1:length(reactionForces)
%         fprintf('%s: %.3f\n', reactionLabels{i}, reactionForces(i));
%     end
% 
%     % Cost and ratio
%     fprintf('\nCost of truss: $%.2f\n', cost);
%      [maxLoad, criticalMem] = failure(memberForces, joints, memberEnds, load);
%     fprintf('Theoretical Max load/cost ratio: %.4f oz/$\n', maxLoad/cost);
% 
%     %Theoretical max load/cost ratio in oz/$: 0.0031
% 
% end 



