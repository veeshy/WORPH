function [] = Write_SSS_Fuel_Mats(MCNP,fileID)

for kkk = 1:length(MCNP.FuelCell)
    
    
    Fuelspec=MCNP.FuelCell{kkk}.Fuel;
    In_Cladspec=MCNP.FuelCell{kkk}.In_Clad;
    Out_Cladspec=MCNP.FuelCell{kkk}.Out_Clad;
    Coolantspec=MCNP.FuelCell{kkk}.Coolant;
    if strcmp(MCNP.FuelCell{kkk}.Type,'normal')
        Materialspec=MCNP.Material.normal;
        
    elseif strcmp(MCNP.FuelCell{kkk}.Type,'poisoned')
        Materialspec=MCNP.Material.poisoned;
        
    else
        error('not a fuel type')
    end
    
    %Out clad
    if MCNP.Burnup.Out_Clad==1
        fprintf(fileID,'mat %i %.6f vol %.6f tmp %i burn 1\n',Out_Cladspec.Out_Clad_Cell_Number,Out_Cladspec.Density,MCNP.FuelCell{kkk}.Out_Clad.Mat_Areas*20,Out_Cladspec.Temp);
    else
        fprintf(fileID,'mat %i %.6f tmp %i \n',Out_Cladspec.Out_Clad_Cell_Number,Out_Cladspec.Density,Out_Cladspec.Temp);
    end
    fprintf(fileID,Materialspec.Out_Clad.Material_String);
    if isfield(Materialspec.Out_Clad,'Material_SAB_String')
        fprintf(fileID,'therm %i ', Out_Cladspec.Cell_Number);
        fprintf(fileID,Materialspec.Out_Clad.Material_SAB_String);
    end
    
    %In Clad
    In_Mat_Num=unique(In_Cladspec.Mat_Number);
    for kk=1:length(In_Mat_Num)
        if MCNP.Burnup.In_Clad==1
            fprintf(fileID,'mat %i %.6f vol %.6f tmp %i burn 1 \n',  In_Mat_Num(kk),In_Cladspec.Density,MCNP.FuelCell{kkk}.In_Clad.Mat_Areas*20,In_Cladspec.Temp);
        else
            fprintf(fileID,'mat %i %.6f tmp %i \n',  In_Mat_Num(kk),In_Cladspec.Density,In_Cladspec.Temp);
        end
        fprintf(fileID,Materialspec.In_Clad.Material_String);
        if isfield(Materialspec.In_Clad,'Material_SAB_String')
            fprintf(fileID,'therm %i ',  Mat_Num(kk));
            fprintf(fileID,Materialspec.In_Clad.Material_SAB_String);
        end
    end
    
    %Fuel coolant
    for kk=1:length(Coolantspec.Cell_Number)
        fprintf(fileID,'mat %i %.6f tmp %i \n', Coolantspec.Cell_Number{kk},Coolantspec.Density,Coolantspec.Temp);
        fprintf(fileID,Materialspec.Coolant.Material_String);
        if isfield(Materialspec.Coolant,'Material_SAB_String')
            fprintf(fileID,' therm h%i ' ,Coolantspec.Cell_Number{kk});
            fprintf(fileID,Materialspec.Coolant.Material_SAB_String);
        end
    end
    
    
    %fuel
    
    Fuel_Mat_Num=unique(Fuelspec.Mat_Number);
    if MCNP.fuel.type == 1
        for kk=1:length(unique(Fuelspec.Mat_Number))
            if 1< length(MCNP.FuelCell)
                fprintf(fileID,'mat %i %.6f vol %.6f moder uo2_%ia 92238 moder o2u_%i 8016 tmp %i burn 1\n' ,Fuel_Mat_Num(kk),Fuelspec.Density,MCNP.FuelCell{kkk}.Fuel.Mat_Areas(kk)*20,Fuel_Mat_Num(kk),Fuel_Mat_Num(kk),Fuelspec.Temp);
            else
                fprintf(fileID,'mat %i %.6f vol %.6f moder uo2_%ia 92238 moder o2u_%i 8016 tmp %i burn 1\n' ,Fuel_Mat_Num(kk),Fuelspec.Density,MCNP.FuelCell{kkk}.Fuel.Mat_Areas(kk)*20,Fuel_Mat_Num(kk),Fuel_Mat_Num(kk),Fuelspec.Temp);
            end
            fprintf(fileID,Materialspec.Fuel.Material_String);
            if isfield(Materialspec.Fuel,'Material_SAB_String1')
                fprintf(fileID,'therm uo2_%ia ', Fuel_Mat_Num(kk));
                fprintf(fileID,Materialspec.Fuel.Material_SAB_String1);
            end
            if isfield(Materialspec.Fuel,'Material_SAB_String2')
                fprintf(fileID,'therm o2u_%i ', Fuel_Mat_Num(kk));
                fprintf(fileID,Materialspec.Fuel.Material_SAB_String2);
            end
        end
    elseif MCNP.fuel.type == 2
        for kk=1:length(unique(Fuelspec.Mat_Number))
            if 1< length(MCNP.FuelCell)
                fprintf(fileID,'mat %i %.6f vol %.6f moder graph_%ia 6000 tmp %i burn 1\n' ,Fuel_Mat_Num(kk),Fuelspec.Density,MCNP.FuelCell{kkk}.Fuel.Mat_Areas(kk)*20,Fuel_Mat_Num(kk),Fuelspec.Temp);
            else
                fprintf(fileID,'mat %i %.6f vol %.6f moder graph_%ia 6000 tmp %i burn 1\n' ,Fuel_Mat_Num(kk),Fuelspec.Density,MCNP.FuelCell{kkk}.Fuel.Mat_Areas(kk)*20,Fuel_Mat_Num(kk),Fuelspec.Temp);
            end
            fprintf(fileID,Materialspec.Fuel.Material_String);
            if isfield(Materialspec.Fuel,'Material_SAB_String1')
                fprintf(fileID,'therm graph_%ia ', Fuel_Mat_Num(kk));
                fprintf(fileID,Materialspec.Fuel.Material_SAB_String1);
            end
        end
    else
        error('not a valid fuel option');
    end
    
    
end

