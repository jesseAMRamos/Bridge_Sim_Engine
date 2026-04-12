% Will be master command to bring computations together
% layer to interacts directly with files
% generate the design_file.mat that will be submitted

function [Tension,names,condition,outputText] = design_filer(F,jointIndex)
    loaded = load('dim_table.mat');
    tableData = loaded.tableData;
    %columnNames = loaded.columnNames;
    % Strip empty rows
    mask = ~cellfun(@isempty, tableData(:,1));
    tableData = tableData(mask, :);
    mask = ~cellfun(@isempty, tableData(:,1));
    tableData = tableData(mask, :);
    n = size(tableData,1);
    joints    = zeros(n, 2);
    memberEnds = zeros(n, 2);
    
    %convert from strings to doubles
    for i = 1:size(tableData,1)
        joints(i,:) = [str2double(tableData{i,1}),str2double(tableData{i,2})];
        memberEnds(i,:) = [str2double(tableData{i,3}),str2double(tableData{i,4})];
    end
    
    [uniqueJoints,~,jointMap] = unique([joints;memberEnds], 'rows', 'stable');
    condition = size(joints,1) == 2*size(uniqueJoints,1) -3;
    %jointMap
    %example on how to index map
    %{
        for i = 1:size(joints(:,1))
        disp(joints(i,:))
        disp(uniqueJoints(jointMap(i),:))
    end  
    %}
    
    [A,names,r,C] = dimToVector(joints,memberEnds,uniqueJoints);
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
    A =  [A [Sx;Sy]];
    
    L = zeros(2*size(uniqueJoints,1),1);
    L(size(uniqueJoints,1)+jointIndex,1) = -F;
    X = uniqueJoints(:,1);
    Y = uniqueJoints(:,2);
    Tension = forceCalculations(A,L);
    save('TrussDesign1_JesseDanyChaoming_A3.mat','C','Sx','Sy','X','Y','L');
    reactions = Tension(end-2:end)
    reactions = [0;nonzeros(reactions)];
    Tension = Tension(1:size(Tension,1)-3);
    cost = costEstimations(joints,memberEnds,uniqueJoints);
    [maxLoad,nameFail] = failure(Tension, joints, memberEnds, F,names);
    outputText = outputTableGen(Tension,reactions,names,maxLoad,nameFail,F,cost); 
    for i = 1:size(names,1)
        fprintf("%s is %.3f inches\n",names(i),r(i));
    end
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

