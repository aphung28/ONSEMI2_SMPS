%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%             Clear Everything             %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all    % Close any open windows.
clear all    % Delete everything in the workspace.
clc          % Clear the command window.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%               Select File               %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filename = 'NCV891930.xlsx';
% This is where you select your part.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                Initialize                %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sheet = 'SW1';
% Select the first sheet in the Excel file.

table = readtable(filename,'Sheet',sheet);
% Read the first sheet in the selected file.

H = height(table);    % Determine the height of the table.
W = width(table);     % Determine the width of the table.

variable = table{1:H, {'Variable'}};
% Assign the Variable column in the Excel table 
% to "variable" in MATLAB.

value = table{1:H, {'Value'}};
% Assign the Value column in the Excel table
% to "value" in MATLAB.

units = table{1:H, {'Units'}};
% Assign the Units column in the Excel table
% to "units" in MATLAB.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%            Count # of Outputs            %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for n = 1:H
    if(string(variable(n)) == "outputs")
        eval([cell2mat(variable(n)) '=' cell2mat(value(n)) ';'])
    end
end
% Search the entire Variable column in the Excel table
% and obtain the "outputs" variable to determine how
% many buck (or boost) outputs are in the selected part.
% Store this number as "outputs" in MATLAB.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%       Load SW1, SW2, SW3, ..., SWN       %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for o = 1:outputs
    sheet = strcat("SW", string(o));
    table = readtable(filename,'Sheet',sheet);
    H = height(table);
    W = width(table);
    variable = table{1:H, {'Variable'}};
    value = table{1:H, {'Value'}};
    units = table{1:H, {'Units'}};
    % For each output (Switcher #1 to Switcher N),
    % navigate to the corresponding sheet,
    % determine the height and width of the table.
    % Then import the Variable, Value, and Units column.
    
    for n = 1:H
        if(string(units(n)) == "TEXT")
            eval([cell2mat(variable(n)) '=' 'string(value(n))' ';'])
            % If the variable contains a text string, import it 
            % as a text string. It should have the word "TEXT"
            % in the Units column to identify it as a text string.
            
        else
            raw = cell2mat(value(n));
            % Import the raw values as shown in Excel.
            
            if(length(raw) > 3)     % Check length of string.
                if(strcmp(raw(end-2:end),'Meg'))    % prefix = mega
                    mult = 10^(6);                  % mega = 1,000,000
                    num = str2num(raw(1:end-3));
                    actual = num * mult;
                end
            end
            
            if(strcmp(raw(end),'K'))        % prefix = kilo (uppercase)
                mult = 10^(3);                  % kilo = 1,000
                num = str2num(raw(1:end-1));
                actual = num * mult;
            elseif(strcmp(raw(end),'k'))        % prefix = kilo (lowercase)
                mult = 10^(3);                  % kilo = 1,000
                num = str2num(raw(1:end-1));
                actual = num * mult;
            elseif(strcmp(raw(end),'m'))        % prefix = milli
                mult = 10^(-3);                 % milli = 0.001
                num = str2num(raw(1:end-1));
                actual = num * mult;
            elseif(strcmp(raw(end),'u'))        % prefix = micro
                mult = 10^(-6);                 % micro = 0.000 001
                num = str2num(raw(1:end-1));
                actual = num * mult;
            elseif(strcmp(raw(end),'n'))        % prefix = nano
                mult = 10^(-9);                 % nano = 10^(-9)
                num = str2num(raw(1:end-1));
                actual = num * mult;
            elseif(strcmp(raw(end),'p'))        % prefix = pico
                mult = 10^(-12);                % pico = 10^(-12)
                num = str2num(raw(1:end-1));
                actual = num * mult;
            elseif(strcmp(raw(end),'f'))        % prefix = femto
                mult = 10^(-15);                % femto = 10^(-15)
                num = str2num(raw(1:end-1));
                actual = num * mult;
            else
                mult = 1;                       % No prefix found.
                num = str2num(raw(1:end));      % Multiplier = 1
                actual = num * mult;
            end
            % Strip the last character(s) to determine the prefix.
            % Match the prefix to a number.
            % Multiply the number by the prefix multiplier
            % to get the actual value.
            
            eval([cell2mat(variable(n)) '=' 'actual' ';'])
            % Set each variable equal to the actual number.
            
        end     % End of "text or number" check.
        
    end     % End of n=1:H loop for a given column.
    
end     % End of o=1:outputs loop for the switchers.

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

text_font = 11;

% Create a text string. (Not editable.)
t1 = uicontrol('Style','text', 'String', 'Component Name');
t1.FontSize = text_font;
t1.Units = norm;
t1.Position = [t1_x t1_y t1_lx t1_ly];
% t1.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t2 = uicontrol('Style','text', 'String', 'Component Value');
t2.FontSize = text_font;
t2.Units = norm;
t2.Position = [t2_x t2_y t2_lx t2_ly];
% t2.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t3 = uicontrol('Style','text', 'String', ...
    strcat('Parasitic Value (',char(hex2dec('03A9')),')'));
t3.FontSize = text_font;
t3.Units = norm;
t3.Position = [t3_x t3_y t3_lx t3_ly];
t3.Visible = 'off';
% t3.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t4 = uicontrol('Style','text', 'String', 'Box #4');
t4.FontSize = text_font;
t4.Units = norm;
t4.Position = [t4_x t4_y t4_lx t4_ly];
t4.Visible = 'off';
% t4.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t5 = uicontrol('Style','text', 'String', 'Box #5');
t5.FontSize = text_font;
t5.Units = norm;
t5.Position = [t5_x t5_y t5_lx t5_ly];
t5.Visible = 'off';
% t5.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t6 = uicontrol('Style','text', 'String', 'Box #6');
t6.FontSize = text_font;
t6.Units = norm;
t6.Position = [t6_x t6_y t6_lx t6_ly];
t6.Visible = 'off';
% t6.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t7 = uicontrol('Style','text', 'String', 'Box #7');
t7.FontSize = text_font;
t7.Units = norm;
t7.Position = [t7_x t7_y t7_lx t7_ly];
t7.Visible = 'off';
% t7.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t8 = uicontrol('Style','text', 'String', 'Box #8');
t8.FontSize = text_font;
t8.Units = norm;
t8.Position = [t8_x t8_y t8_lx t8_ly];
t8.Visible = 'off';
% t8.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t9 = uicontrol('Style','text', 'String', 'Box #9');
t9.FontSize = text_font;
t9.Units = norm;
t9.Position = [t9_x t9_y t9_lx t9_ly];
t9.Visible = 'off';
% t9.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t10 = uicontrol('Style','text', 'String', 'Box #10');
t10.FontSize = text_font;
t10.Units = norm;
t10.Position = [t10_x t10_y t10_lx t10_ly];
t10.Visible = 'off';
% t10.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t11 = uicontrol('Style','text', 'String', 'Box #11');
t11.FontSize = text_font;
t11.Units = norm;
t11.Position = [t11_x t11_y t11_lx t11_ly];
t11.Visible = 'off';
% t11.BackgroundColor = [1 1 1];

% Create a text string. (Not editable.)
t12 = uicontrol('Style','text', 'String', 'Box #12');
t12.FontSize = text_font;
t12.Units = norm;
t12.Position = [t12_x t12_y t12_lx t12_ly];
t12.Visible = 'off';
% t12.BackgroundColor = [1 1 1];

% Create a textbox.
e1 = uicontrol('Style','edit');
e1.FontSize = text_font;
e1.Units = norm;
e1.Position = [e1_x e1_y e1_lx e1_ly];

% Create a textbox.
e2 = uicontrol('Style','edit');
e2.FontSize = text_font;
e2.Units = norm;
e2.Position = [e2_x e2_y e2_lx e2_ly];

% Create a textbox.
e3 = uicontrol('Style','edit');
e3.FontSize = text_font;
e3.Units = norm;
e3.Position = [e3_x e3_y e3_lx e3_ly];
e3.Visible = 'off';

% Create a textbox.
e4 = uicontrol('Style','edit');
e4.FontSize = text_font;
e4.Units = norm;
e4.Position = [e4_x e4_y e4_lx e4_ly];
e4.Visible = 'off';

% Create a textbox.
e5 = uicontrol('Style','edit');
e5.FontSize = text_font;
e5.Units = norm;
e5.Position = [e5_x e5_y e5_lx e5_ly];
e5.Visible = 'off';

% Create a textbox.
e6 = uicontrol('Style','edit');
e6.FontSize = text_font;
e6.Units = norm;
e6.Position = [e6_x e6_y e6_lx e6_ly];
e6.Visible = 'off';

% Create a textbox.
e7 = uicontrol('Style','edit');
e7.FontSize = text_font;
e7.Units = norm;
e7.Position = [e7_x e7_y e7_lx e7_ly];
e7.Visible = 'off';

% Create a textbox.
e8 = uicontrol('Style','edit');
e8.FontSize = text_font;
e8.Units = norm;
e8.Position = [e8_x e8_y e8_lx e8_ly];
e8.Visible = 'off';

% Create a textbox.
e9 = uicontrol('Style','edit');
e9.FontSize = text_font;
e9.Units = norm;
e9.Position = [e9_x e9_y e9_lx e9_ly];
e9.Visible = 'off';

% Create a textbox.
e10 = uicontrol('Style','edit');
e10.FontSize = text_font;
e10.Units = norm;
e10.Position = [e10_x e10_y e10_lx e10_ly];
e10.Visible = 'off';

% Create a textbox.
e11 = uicontrol('Style','edit');
e11.FontSize = text_font;
e11.Units = norm;
e11.Position = [e11_x e11_y e11_lx e11_ly];
e11.Visible = 'off';

% Create a textbox.
e12 = uicontrol('Style','edit');
e12.FontSize = text_font;
e12.Units = norm;
e12.Position = [e12_x e12_y e12_lx e12_ly];
e12.Visible = 'off';

label_font = 10;

% Create a label.
l1 = uicontrol('Style','text', 'String', num2str(Rosc));
l1.FontSize = label_font;
l1.Units = norm;
l1.Position = [l1_x l1_y l1_lx l1_ly];
% l1.BackgroundColor = [1 1 1];

% Create a label.
l2 = uicontrol('Style','text', 'String', num2str(Rvccext));
l2.FontSize = label_font;
l2.Units = norm;
l2.Position = [l2_x l2_y l2_lx l2_ly];
% l2.BackgroundColor = [1 1 1];

% Create a label.
l3 = uicontrol('Style','text', 'String', num2str(Vin));
l3.FontSize = label_font;
l3.Units = norm;
l3.Position = [l3_x l3_y l3_lx l3_ly];
% l3.BackgroundColor = [1 1 1];

% Create a label.
l4 = uicontrol('Style','text', 'String', num2str(Q1));
l4.FontSize = label_font;
l4.Units = norm;
l4.Position = [l4_x l4_y l4_lx l4_ly];
% l4.BackgroundColor = [1 1 1];

% Create a label.
l5 = uicontrol('Style','text', 'String', num2str(Q2));
l5.FontSize = label_font;
l5.Units = norm;
l5.Position = [l5_x l5_y l5_lx l5_ly];
% l5.BackgroundColor = [1 1 1];

% Create a label.
l6 = uicontrol('Style','text', 'String', num2str(L));
l6.FontSize = label_font;
l6.Units = norm;
l6.Position = [l6_x l6_y l6_lx l6_ly];
% l6.BackgroundColor = [1 1 1];

% Create a label.
l7 = uicontrol('Style','text', 'String', num2str(D1));
l7.FontSize = label_font;
l7.Units = norm;
l7.Position = [l7_x l7_y l7_lx l7_ly];
% l7.BackgroundColor = [1 1 1];

% Create a label.
l8 = uicontrol('Style','text', 'String', num2str(Rsense));
l8.FontSize = label_font;
l8.Units = norm;
l8.Position = [l8_x l8_y l8_lx l8_ly];
% l8.BackgroundColor = [1 1 1];

% Create a label.
l9 = uicontrol('Style','text', 'String', num2str(Rsf2));
l9.FontSize = label_font;
l9.Units = norm;
l9.Position = [l9_x l9_y l9_lx l9_ly];
% l9.BackgroundColor = [1 1 1];

% Create a label.
l10 = uicontrol('Style','text', 'String', num2str(Co1));
l10.FontSize = label_font;
l10.Units = norm;
l10.Position = [l10_x l10_y l10_lx l10_ly];
% l10.BackgroundColor = [1 1 1];

% Create a label.
l11 = uicontrol('Style','text', 'String', num2str(Co2));
l11.FontSize = label_font;
l11.Units = norm;
l11.Position = [l11_x l11_y l11_lx l11_ly];
% l11.BackgroundColor = [1 1 1];

% Create a label.
l12 = uicontrol('Style','text', 'String', num2str(Rout));
l12.FontSize = label_font;
l12.Units = norm;
l12.Position = [l12_x l12_y l12_lx l12_ly];
% l12.BackgroundColor = [1 1 1];

% Create a label.
l13 = uicontrol('Style','text', 'String', num2str(Temperature));
l13.FontSize = label_font;
l13.Units = norm;
l13.Position = [l13_x l13_y l13_lx l13_ly];
% l13.BackgroundColor = [1 1 1];

[component_name] = joseph(b1_x, b1_y, b1_lx, b1_ly, ...
    t5_x, t5_y, t5_lx, t5_ly, l1, l2, l3, l4, l5, l6, ...
    l7, l8, l9, l10, l11, l12, l13, t1, t2, t3, t4, ...
    t5, t6, t7, t8, t9, t10, t11, t12, e1, e2, e3, ...
    e4, e5, e6, e7, e8, e9, e10, e11, e12, Rosc, ...
    Rvccext, Vin, Q1, Q2, L, L_ESR, D1, Rsense, ...
    Rsf2, Co1, Co1_ESR, Co2, Co2_ESR, Rout, Temperature);

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

