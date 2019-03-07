for n = 1:buttons
    
    eval([strcat('b',num2str(n)) '=' convertStringsToChars("uicontrol('Style','pushbutton','String',num2str(n))") ';'])
    
    eval([strcat('b',num2str(n),'.FontSize') '=' '10' ';'])
    
    eval([strcat('b',num2str(n),'.Units') '=' 'norm' ';'])
    
    eval([strcat('b',num2str(n),'.Position') '=' convertStringsToChars("[eval(strcat('b',num2str(n),'_x')),eval(strcat('b',num2str(n),'_y')),eval(strcat('b',num2str(n),'_lx')),eval(strcat('b',num2str(n),'_ly'))]") ';'])
    
    eval([strcat('b',num2str(n),'.Callback') '=' strcat('@b','Pushed') ';'])
    
    eval([strcat('b',num2str(n),'.Visible') '=' 'ButtonsVisible' ';'])
    
end