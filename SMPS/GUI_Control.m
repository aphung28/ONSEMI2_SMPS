%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%         Create the main figure.         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure(1);
NCV = imread('NCV891930.png');
imshow(NCV,'Border','tight');
% fig.MenuBar = 'none';
% fig.ToolBar = 'none';
fig.Resize = 'on';
daspect auto;
ButtonsVisible = 'on';

sheet = "Elements";
table = readtable(filename,'Sheet',sheet);
H = height(table);
W = width(table);
name = table{1:H, {'Name'}};
x = table{1:H, {'x'}};
y = table{1:H, {'y'}};
lx = table{1:H, {'lx'}};
ly = table{1:H, {'ly'}};
label = table{1:H, {'Label'}};
% Determine the height and width of the table.
% Then import the name, label, x, y, lx, ly columns.
   
for n = 1:H
    eval([strcat(cell2mat(name(n)),'_x') '=' 'x(n)' ';'])
    eval([strcat(cell2mat(name(n)),'_y') '=' 'y(n)' ';'])
    eval([strcat(cell2mat(name(n)),'_lx') '=' 'lx(n)' ';'])
    eval([strcat(cell2mat(name(n)),'_ly') '=' 'ly(n)' ';'])
    % Set each variable equal to the actual number.
end

norm = 'normalized';
% This variable makes it easier in the 
% 'eval loop' because it requires two 
% levels of quotes.

% Create a title. (Not editable.)
title = uicontrol('Style','text', 'String', filename(1:end-5));
title.FontSize = 28;
title.Units = norm;
title.Position = [title_x title_y title_lx title_ly];
% title.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t1 = uicontrol('Style','text', 'String', 'Component Name:');
t1.FontSize = 14;
t1.Units = norm;
t1.Position = [t1_x t1_y t1_lx t1_ly];
% t1.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t2 = uicontrol('Style','text', 'String', 'Component Value:');
t2.FontSize = 14;
t2.Units = norm;
t2.Position = [t2_x t2_y t2_lx t2_ly];
% t2.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t3 = uicontrol('Style','text', 'String', 'Parasitic Value:');
t3.FontSize = 14;
t3.Units = norm;
t3.Position = [t3_x t3_y t3_lx t3_ly];
% t3.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t4 = uicontrol('Style','text', 'String', 'Box #4');
t4.FontSize = 14;
t4.Units = norm;
t4.Position = [t4_x t4_y t4_lx t4_ly];
% t4.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t5 = uicontrol('Style','text', 'String', 'Box #5');
t5.FontSize = 14;
t5.Units = norm;
t5.Position = [t5_x t5_y t5_lx t5_ly];
% t5.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t6 = uicontrol('Style','text', 'String', 'Box #6');
t6.FontSize = 14;
t6.Units = norm;
t6.Position = [t6_x t6_y t6_lx t6_ly];
% t6.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t7 = uicontrol('Style','text', 'String', 'Box #7');
t7.FontSize = 14;
t7.Units = norm;
t7.Position = [t7_x t7_y t7_lx t7_ly];
% t7.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t8 = uicontrol('Style','text', 'String', 'Box #8');
t8.FontSize = 14;
t8.Units = norm;
t8.Position = [t8_x t8_y t8_lx t8_ly];
% t8.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t9 = uicontrol('Style','text', 'String', 'Box #9');
t9.FontSize = 14;
t9.Units = norm;
t9.Position = [t9_x t9_y t9_lx t9_ly];
% t9.BackgroundColor = [1 1 1];

% Create a textbox.
e1 = uicontrol('Style','edit');
e1.FontSize = 14;
e1.Units = norm;
e1.Position = [e1_x e1_y e1_lx e1_ly];

% Create a textbox.
e2 = uicontrol('Style','edit');
e2.FontSize = 14;
e2.Units = norm;
e2.Position = [e2_x e2_y e2_lx e2_ly];

% Create a textbox.
e3 = uicontrol('Style','edit');
e3.FontSize = 14;
e3.Units = norm;
e3.Position = [e3_x e3_y e3_lx e3_ly];

% Create a textbox.
e4 = uicontrol('Style','edit');
e4.FontSize = 14;
e4.Units = norm;
e4.Position = [e4_x e4_y e4_lx e4_ly];

% Create a textbox.
e5 = uicontrol('Style','edit');
e5.FontSize = 14;
e5.Units = norm;
e5.Position = [e5_x e5_y e5_lx e5_ly];

% Create a textbox.
e6 = uicontrol('Style','edit');
e6.FontSize = 14;
e6.Units = norm;
e6.Position = [e6_x e6_y e6_lx e6_ly];

% Create a textbox.
e7 = uicontrol('Style','edit');
e7.FontSize = 14;
e7.Units = norm;
e7.Position = [e7_x e7_y e7_lx e7_ly];

% Create a textbox.
e8 = uicontrol('Style','edit');
e8.FontSize = 14;
e8.Units = norm;
e8.Position = [e8_x e8_y e8_lx e8_ly];

% Create a textbox.
e9 = uicontrol('Style','edit');
e9.FontSize = 14;
e9.Units = norm;
e9.Position = [e9_x e9_y e9_lx e9_ly];

b1 = uicontrol('Style','pushbutton', 'String', 'Update Values');
b1.FontSize = 14;
b1.Units = 'normalized';
b1.Position = [b1_x b1_y b1_lx b1_ly];
b1.Callback = @b1Pushed;

[component_name] = joseph(e1, e2, e3, Rosc, Rvccext, Vin, Q1, Q2, L, D1, Rsense, Rsf2, Co1, Co2, Rout, Temperature);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%            Live Coordinates            %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set (gcf, 'WindowButtonDownFcn', @mouseClick);
% 
% function mouseClick(object, eventdata)
%     C = get (gca, 'CurrentPoint');
%     x = C(1,1);
%     y = C(1,2);
%     clc
%     disp([x y])
% end

function b1Pushed(src,event)
    disp('Hello there')
    Rosc = 200;
end

