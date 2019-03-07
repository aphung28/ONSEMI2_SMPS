function [comp_name] = joseph(b1_x, b1_y, b1_lx, b1_ly, ...
    t5_x, t5_y, t5_lx, t5_ly, l1, l2, l3, l4, l5, l6, ...
    l7, l8, l9, l10, l11, l12, l13, t1, t2, t3, t4, ...
    t5, t6, t7, t8, t9, t10, t11, t12, e1, e2, e3, ...
    e4, e5, e6, e7, e8, e9, e10, e11, e12, Rosc, ...
    Rvccext, Vin, Q1, Q2, L, L_ESR, D1, Rsense, ...
    Rsf2, Co1, Co1_ESR, Co2, Co2_ESR, Rout, Temperature);
       
    comp_name = "";
    
    set(gcf, 'WindowButtonDownFcn', @mouseClick);
    set(gcf, 'WindowButtonMotionFcn', @mouseMove);

    % Create a pushbutton.
    b1 = uicontrol('Style','pushbutton', 'String', 'Update Values');
    b1.FontSize = 11;
    b1.Units = 'normalized';
    b1.Position = [t5_x t5_y t5_lx t5_ly];
    b1.Callback = @b1Pushed;
    
    function mouseClick(object, eventdata)
        C = get (gca, 'CurrentPoint');
        x = C(1,1);
        y = C(1,2);
        [comp_name] = isaiah(x, y, Rosc, Rvccext, Vin, Q1, Q2, L, D1, ...
            Rsense, Rsf2, Co1, Co2, Rout, Temperature);
        component = char(comp_name);
        t1.String = 'Component Name';
        t2.String = 'Component Value';
        
        if(comp_name == "")
            e1.String = '';    
            e2.String = '';
            e3.String = '';
            type = 'X';
        elseif(component(1) == 'R')
            t1.String = 'Resistor Name';
            t2.String = strcat('Resistance (',char(hex2dec('03A9')),')');
            e1.String = comp_name;    
            e2.String = eval(comp_name);
            e3.String = '';
            type = char(comp_name);
        elseif(component(1) == 'C')
            t1.String = 'Capacitor Name';
            t2.String = 'Capacitance (F)';
            e1.String = comp_name;    
            e2.String = eval(comp_name);
            e3.String = eval(strcat(comp_name, "_ESR"));
            type = char(comp_name);
        elseif(component(1) == 'L')
            t1.String = 'Inductor Name';
            t2.String = 'Inductance (H)';
            e1.String = comp_name;    
            e2.String = eval(comp_name);
            e3.String = eval(strcat(comp_name, "_ESR"));
            type = char(comp_name);
        elseif(component(1) == 'Q')
            e1.String = comp_name;    
            e2.String = eval(comp_name);
            e3.String = '';
            type = char(comp_name);
        else
            e1.String = comp_name;    
            e2.String = eval(comp_name);
            e3.String = '';
            type = char(comp_name);
        end
        
        if((type(1) == 'C') || (type(1) == 'L'))
            t3.Visible = 'on';
            e3.Visible = 'on';
            t4.Visible = 'off';
            e4.Visible = 'off';
            t5.Visible = 'off';
            e5.Visible = 'off';
            t6.Visible = 'off';
            e6.Visible = 'off';
            t7.Visible = 'off';
            e7.Visible = 'off';
            t8.Visible = 'off';
            e8.Visible = 'off';
            t9.Visible = 'off';
            e9.Visible = 'off';
            t10.Visible = 'off';
            e10.Visible = 'off';
            t11.Visible = 'off';
            e11.Visible = 'off';
            t12.Visible = 'off';
            e12.Visible = 'off';
            b1.Position = [t5_x t5_y t5_lx t5_ly];
        elseif(type(1) == 'Q')
            t3.Visible = 'on';
            e3.Visible = 'on';
            t4.Visible = 'on';
            e4.Visible = 'on';
            t5.Visible = 'on';
            e5.Visible = 'on';
            t6.Visible = 'on';
            e6.Visible = 'on';
            t7.Visible = 'on';
            e7.Visible = 'on';
            t8.Visible = 'on';
            e8.Visible = 'on';
            t9.Visible = 'on';
            e9.Visible = 'on';
            t10.Visible = 'on';
            e10.Visible = 'on';
            t11.Visible = 'on';
            e11.Visible = 'on';
            t12.Visible = 'on';
            e12.Visible = 'on';
            b1.Position = [b1_x b1_y b1_lx b1_ly];
        else
            t3.Visible = 'off';
            e3.Visible = 'off';
            t4.Visible = 'off';
            e4.Visible = 'off';
            t5.Visible = 'off';
            e5.Visible = 'off';
            t6.Visible = 'off';
            e6.Visible = 'off';
            t7.Visible = 'off';
            e7.Visible = 'off';
            t8.Visible = 'off';
            e8.Visible = 'off';
            t9.Visible = 'off';
            e9.Visible = 'off';
            t10.Visible = 'off';
            e10.Visible = 'off';
            t11.Visible = 'off';
            e11.Visible = 'off';
            t12.Visible = 'off';
            e12.Visible = 'off';
            b1.Position = [t5_x t5_y t5_lx t5_ly];
        end
    end

    function mouseMove(object, eventdata)
        C = get (gca, 'CurrentPoint');
        x = C(1,1);
        y = C(1,2);
        set(gcf,'pointer','arrow');
        
        % Rosc
        if((x > 55) && (x < 80) && (y > 200) && (y < 250))
            set(gcf,'pointer','hand');
            return
        end

        % Rvccext
        if((x > 395) && (x < 420) && (y > 330) && (y < 380))
            set(gcf,'pointer','hand');
            return
        end

        % Vin
        if((x > 440) && (x < 470) && (y > 100) && (y < 150))
            set(gcf,'pointer','hand');
            return
        end

        % Q1
        if((x > 520) && (x < 550) && (y > 150) && (y < 190))
            set(gcf,'pointer','hand');
            return
        end

        % Q2
        if((x > 520) && (x < 550) && (y > 260) && (y < 300))
            set(gcf,'pointer','hand');
            return
        end

        % L
        if((x > 550) && (x < 620) && (y > 190) && (y < 220))
            set(gcf,'pointer','hand');
            return
        end

        % D1
        if((x > 605) && (x < 630) && (y > 250) && (y < 300))
            set(gcf,'pointer','hand');
            return
        end

        % Rsense
        if((x > 635) && (x < 680) && (y > 200) && (y < 240))
            set(gcf,'pointer','hand');
            return
        end

        % Rsf2
        if((x > 675) && (x < 700) && (y > 140) && (y < 185))
            set(gcf,'pointer','hand');
            return
        end

        % Co1
        if((x > 675) && (x < 715) && (y > 250) && (y < 300))
            set(gcf,'pointer','hand');
            return
        end

        % Co2
        if((x > 730) && (x < 770) && (y > 250) && (y < 300))
            set(gcf,'pointer','hand');
            return
        end

        % Rout    
        if((x > 800) && (x < 825) && (y > 250) && (y < 300))
            set(gcf,'pointer','hand');
            return
        end

        % Temperature    
        if((x > 740) && (x < 780) && (y > 100) && (y < 195))
            set(gcf,'pointer','hand');
            return
        end
    
    end

    function b1Pushed(src,event)
        type = char(comp_name);
        
        if((comp_name ~= "") && ((type(1) == 'C') || (type(1) == 'L')))
            assignin('base',comp_name,str2num(e2.String))
            assignin('base',strcat(comp_name,"_ESR"),str2num(e3.String))
            % Assign the user's value to the base workspace
            % which is seen by the main script.
            
            eval([convertStringsToChars(comp_name) '=' 'str2num(e2.String)' ';'])
            eval([convertStringsToChars(strcat(comp_name,"_ESR")) '=' 'str2num(e3.String)' ';'])
            % Assign the user's value to the function workspace.
            
            l1.String = Rosc;
            l2.String = Rvccext;
            l3.String = Vin;
            l4.String = Q1;
            l5.String = Q2;
            l6.String = L;
            l7.String = D1;
            l8.String = Rsense;
            l9.String = Rsf2;
            l10.String = Co1;
            l11.String = Co2;
            l12.String = Rout;
            l13.String = Temperature;
            % Update all of the labels on the schematic.
        elseif(comp_name ~= "")
            assignin('base',comp_name,str2num(e2.String))
            % Assign the user's value to the base workspace
            % which is seen by the main script.
            
            eval([convertStringsToChars(comp_name) '=' 'str2num(e2.String)' ';'])
            % Assign the user's value to the function workspace.
            
            l1.String = Rosc;
            l2.String = Rvccext;
            l3.String = Vin;
            l4.String = Q1;
            l5.String = Q2;
            l6.String = L;
            l7.String = D1;
            l8.String = Rsense;
            l9.String = Rsf2;
            l10.String = Co1;
            l11.String = Co2;
            l12.String = Rout;
            l13.String = Temperature;
            % Update all of the labels on the schematic.
        end
        
    end

end