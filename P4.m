% Cheng-Han Lu 0516310
function varargout = P4_0516310(varargin)
% P4_0516310 MATLAB code for P4_0516310.fig
%      P4_0516310, by itself, creates a new P4_0516310 or raises the existing
%      singleton*.
%
%      H = P4_0516310 returns the handle to a new P4_0516310 or the handle to
%      the existing singleton*.
%
%      P4_0516310('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P4_0516310.M with the given input arguments.
%
%      P4_0516310('Property','Value',...) creates a new P4_0516310 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P4_0516310_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P4_0516310_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P4_0516310

% Last Modified by GUIDE v2.5 22-May-2017 10:31:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P4_0516310_OpeningFcn, ...
                   'gui_OutputFcn',  @P4_0516310_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before P4_0516310 is made visible.
function P4_0516310_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P4_0516310 (see VARARGIN)

% Choose default command line output for P4_0516310
handles.output = hObject;

handles.img = [];
handles.z = 1;
handles.temp = [];
handles.x = 0;
handles.y = 0;
handles.lx = 1;
handles.ly = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P4_0516310 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = P4_0516310_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.z < 16) handles.z = handles.z * 2;
else return; end
set(handles.text2, 'String', ['Zoom ' num2str(handles.z) 'x']);
handles.temp = imresize(handles.img, handles.z, 'nearest');
[x y z] = size(handles.img);
imshow(handles.temp);
set(handles.axes1,'XLim',[1 y]);
set(handles.axes1,'YLim',[1 x]);
axis on;
set(handles.slider1, 'Value', 0);
set(handles.slider2, 'Value', 1);
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.z > 1) handles.z = handles.z / 2;
else return; end
set(handles.text2, 'String', ['Zoom ' num2str(handles.z) 'x']);
handles.temp = imresize(handles.img, handles.z, 'nearest');
[x y z] = size(handles.img);
imshow(handles.temp(1:x, 1:y, :));
set(handles.axes1,'XLim',[1 y]);
set(handles.axes1,'YLim',[1 x]);
axis on;
set(handles.slider1, 'Value', 0);
set(handles.slider2, 'Value', 1);
guidata(hObject, handles);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if(handles.z == 1) return;end
l = get(hObject,'Value');
[x y z] = size(handles.img);
handles.ly = ceil(l*y*(handles.z-1));
imshow(handles.temp);
set(handles.axes1,'XLim',[handles.ly handles.ly+y]);
set(handles.axes1,'YLim',[handles.lx handles.lx+x]);
axis on;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if(handles.z == 1) return;end
l = 1-get(hObject,'Value');
[x y z] = size(handles.img);
handles.lx = ceil(l*x*(handles.z-1));
imshow(handles.temp);
set(handles.axes1,'XLim',[handles.ly handles.ly+y]);
set(handles.axes1,'YLim',[handles.lx handles.lx+x]);
axis on;
%axis([handles.lx, handles.lx+x handles.ly handles.ly+y]);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[img path] = uigetfile;
handles.img = imread([path img]);
handles.temp = handles.img;
imshow(handles.img);
handles.z = 1;
[x y z] = size(handles.img);
set(handles.axes1,'XLim',[1 y]);
set(handles.axes1,'YLim',[1 x]);
axis on;
set(handles.text2, 'String', ['Zoom ' num2str(handles.z) 'x']);
set(handles.slider1, 'Value', 0);
set(handles.slider2, 'Value', 1);
guidata(hObject, handles);
