function [comp_name] = isaiah(x, y, Rosc, Rvccext, Vin, Q1, Q2, L, D1, Rsense, Rsf2, Co1, Co2, Rout, Temperature)
    
    comp_name = "";
    
    % Rosc
    if((x > 55) && (x < 80) && (y > 200) && (y < 250))
        comp_name = "Rosc";
        return
    end
      
    % Rvccext
    if((x > 395) && (x < 420) && (y > 330) && (y < 380))
        comp_name = "Rvccext";
        return
    end
    
    % Vin
    if((x > 440) && (x < 470) && (y > 100) && (y < 150))
        comp_name = "Vin";
        return
    end
    
    % Q1
    if((x > 520) && (x < 550) && (y > 150) && (y < 190))
        comp_name = "Q1";
        return
    end
    
    % Q2
    if((x > 520) && (x < 550) && (y > 260) && (y < 300))
        comp_name = "Q2";
        return
    end
    
    % L
    if((x > 550) && (x < 620) && (y > 190) && (y < 220))
        comp_name = "L";
        return
    end
    
    % D1
    if((x > 605) && (x < 630) && (y > 250) && (y < 300))
        comp_name = "D1";
        return
    end
    
    % Rsense
    if((x > 635) && (x < 680) && (y > 200) && (y < 240))
        comp_name = "Rsense";
        return
    end
    
    % Rsf2
    if((x > 675) && (x < 700) && (y > 140) && (y < 185))
        comp_name = "Rsf2";
        return
    end
    
    % Co1
    if((x > 675) && (x < 715) && (y > 250) && (y < 300))
        comp_name = "Co1";
        return
    end
    
    % Co2
    if((x > 730) && (x < 770) && (y > 250) && (y < 300))
        comp_name = "Co2";
        return
    end
    
    % Rout    
    if((x > 800) && (x < 825) && (y > 250) && (y < 300))
        comp_name = "Rout";
        return
    end
    
    % Temperature    
    if((x > 740) && (x < 780) && (y > 100) && (y < 195))
        comp_name = "Temperature";
        return
    end
    
end