% Will be master command to bring computations together
% layer to interacts directly with files
% generate the design_file.mat that will be submitted
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
    
    %create mapping array to assign indexes for all joints
    uniqueJoints = [];
    coords = tableData(:, 1:2);       % extract coordinates
    %coords = cell2mat(coords);        % convert cell to numeric array if needed

    jointMap = zeros(n,1);            % array to store the index mapping
    index = 0;                         % counter for unique joints
    for i = 1:n
    % Check if current coordinate is already in uniqueJoints
    [isFound, loc] = ismember(coords(i,:), uniqueJoints, 'rows');
        if isFound
            jointMap(i) = loc;        % use existing index
        else
            index = index + 1;
            uniqueJoints(index,:) = coords(i,:);  % add new unique joint
            jointMap(i) = index;
        end
    end



    joints
    jointMap