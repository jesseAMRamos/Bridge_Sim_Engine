function varargout = gui_rename(varargin)
%gui_rename MATLAB code file for gui_rename.fig
%      gui_rename, by itself, creates a new gui_rename or raises the existing
%      singleton*.
%
%      H = gui_rename returns the handle to a new gui_rename or the handle to
%      the existing singleton*.
%
%      gui_rename('Property','Value',...) creates a new gui_rename using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to gui_rename_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      gui_rename('CALLBACK') and gui_rename('CALLBACK',hObject,...) call the
%      local function named CALLBACK in gui_rename.M with the given input
%      arguments.
%
%      *See gui_rename Options on GUIDE's Tools menu.  Choose "gui_rename allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_rename

% Last Modified by GUIDE v2.5 05-Apr-2026 16:05:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_rename_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_rename_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_rename is made visible.
function gui_rename_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for gui_rename
handles.output = hObject;

% Load table data on startup if file exists
    savePath = fullfile(fileparts(which('gui_rename.m')), 'processing', 'dim_table.mat');
    if isfile(savePath)
        loaded = load(savePath);
        set(handles.posTable, 'Data', loaded.tableData);
        set(handles.posTable, 'ColumnName', loaded.columnNames);
    end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_rename wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_rename_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%get sider scale
p = get(handles.slider1,'Value');
%calculated Force to apply and displays it
weight = 30;
FORCE = weight*p;
set(handles.FORCEOUTPUT,'String',sprintf('Result:%.1f Oz.',FORCE));

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in SaveTable.
function SaveTable_Callback(hObject, eventdata, handles)
% hObject    handle to SaveTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tableData = get(handles.posTable,'Data');
columnNames = get(handles.posTable,'ColumnName');
jointToLoad = get(handles.loadedJoint,'String');

% save table to file
savePath = fullfile(fileparts(which('gui_rename.m')),'processing', 'dim_table.mat');
save(savePath, 'tableData', 'columnNames');

msgbox(['Data saved to: ' savePath], 'Save Successful');

addpath(genpath('processing'));
bridgePlotter(handles.axes1,jointToLoad);
drawnow;


% 2. Create a container for the gauges inside your existing GUIDE figure
% We place it at the bottom of the figure. [left bottom width height]
%{numGauges = 4; 
%gaugePanel = uipanel(handles.output, 'Units', 'pixels', 'Position', [0 0 440 130]);
%gaugeWidth = 110;
%spacing = 10;

%for i = 1:numGauges
    % Calculate X position for each gauge
 %   xPos = (i-1) * (gaugeWidth + spacing) + 10;
    
    % IMPORTANT: Create the gauge directly as a child of the panel
    % If it still appears white, your version of MATLAB may require a 'uifigure'
  %  g = uigauge(gaugePanel, 'circular', 'Position', [xPos, 10, gaugeWidth, gaugeWidth]); 
    
   % g.Label = sprintf('Joint %d', i);
    %g.ScaleColors = {'yellow', 'green', 'red'};
    %g.ScaleColorLimits = [0 30; 30 70; 70 100];
%end
%}




function loadedJoint_Callback(hObject, eventdata, handles)
% hObject    handle to loadedJoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loadedJoint as text
%        str2double(get(hObject,'String')) returns contents of loadedJoint as a double


% --- Executes during object creation, after setting all properties.
function loadedJoint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadedJoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
