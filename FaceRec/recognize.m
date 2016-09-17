function varargout = recognize(varargin)
% RECOGNIZE MATLAB code for recognize.fig
%      RECOGNIZE, by itself, creates a new RECOGNIZE or raises the existing
%      singleton*.
%
%      H = RECOGNIZE returns the handle to a new RECOGNIZE or the handle to
%      the existing singleton*.
%
%      RECOGNIZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECOGNIZE.M with the given input arguments.
%
%      RECOGNIZE('Property','Value',...) creates a new RECOGNIZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before recognize_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to recognize_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help recognize

% Last Modified by GUIDE v2.5 01-Apr-2016 23:30:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @recognize_OpeningFcn, ...
                   'gui_OutputFcn',  @recognize_OutputFcn, ...
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


% --- Executes just before recognize is made visible.
function recognize_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to recognize (see VARARGIN)

% Choose default command line output for recognize
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes recognize wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = recognize_OutputFcn(hObject, eventdata, handles) 
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
handles.output = hObject;
[fn, pn] = uigetfile('*.*','Select file to compare')
complete = strcat(pn,fn);

I = imread(complete);
set(handles.axes1);
[I2,rect] = imcrop(I);

imshow(I2);
guidata(hObject, handles);


% --- Executes on button press in recognize1.
function recognize1_Callback(hObject, eventdata, handles)
% hObject    handle to recognize1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I3= getimage(handles.axes1);
load('classifier2.mat');
% I3= getimage(handles.axes1);
iip = rgb2gray(imresize(I3, [86,126]));
iip = im2double(iip);
  % % calculate the similarity of the input to each training image
feature_vec = evectors' * (iip(:) - mean_face);
matched = predict(classifier,feature_vec');
figure;

booleanIndex = strcmp(matched, personIndex);
integerIndex = find(booleanIndex);
subplot(1,2,1);imshow(I3);title('Query Face');
subplot(1,2,2);imshow(read(faceGallery(integerIndex),1));title('Matched Class');

% hObject    handle to crop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in frontfacebutton.
function frontfacebutton_Callback(hObject, eventdata, handles)
% hObject    handle to frontfacebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input_image= getimage(handles.axes1);
addpath ('Frontalize/');
input_image = demo(input_image);

set(handles.axes1);
imshow(input_image);
% guidata(hObject, handles);
