% Will be master command to bring computations together
kdf
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

[uniqueJoints,~,jointMap] = unique([joints], 'rows', 'stable');

%example on how to index map
%{
for i = 1:size(joints(:,1))
    disp(joints(i,:))
    disp(uniqueJoints(jointMap(i),:))
end  
%}
