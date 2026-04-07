
function [uniqueJoints] = bridgePlotter(ax,WJOINT)    
    loaded = load('dim_table.mat');

    tableData = loaded.tableData;
    columnNames = loaded.columnNames;

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
    %checks for vaild set
    valid = true;
    for i = 1:n
        if ~ismember(memberEnds(i,:), joints, 'rows')
            valid = false;
            fprintf('Row %d in memberEnds has no matching joint: [%g, %g]\n', i, memberEnds(i,1), memberEnds(i,2));
        end
    end

    if valid
        disp('All memberEnds match a joint.');
    end


    %plots
    cla(ax)
    hold(ax,'on')
    for i = 1:n
        plot(ax,[joints(i,1), memberEnds(i,1)], [joints(i,2), memberEnds(i,2)], 'b-o');
        %text(ax,joints(i,1),joints(i,2),letters(i),'FontSize', 16, 'Color', 'blue')
    end
 
    % label unique joints only
    [uniqueJoints,~,jointMap] = unique([joints;memberEnds], 'rows', 'stable');
    disp(uniqueJoints)
    letters = 'A':'Z';
    for i = 1:size(uniqueJoints, 1)
        text(ax, uniqueJoints(i,1), uniqueJoints(i,2), letters(i), 'FontSize', 16, 'Color', 'blue');
    end
    % lable weighted joint with arrow
    jointIndex = find(letters==WJOINT);
    wJoint = uniqueJoints(jointIndex,:);
    quiver(ax, wJoint(1), wJoint(2)+3, 0, -2, 'r', 'LineWidth', 2, 'MaxHeadSize', 1);


    xlim(ax, [-5 35]);
    ylim(ax, [0 20]);
    grid(ax,"on");
    axis(ax,"equal");

end


