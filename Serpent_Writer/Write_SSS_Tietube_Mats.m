function [] = Write_SSS_Tietube_Mats(MCNP,fileID)

for kkk = 1:length(MCNP.TieTubeCell)
    
    Tietubespecs=MCNP.TieTubeCell{kkk};
    
    if strcmp(MCNP.TieTubeCell{kkk}.Type,'normal');
        Materialspec=MCNP.Material.normal;
        Nparts=MCNP.Burnup.Normal_TieTube_Number;
        type =1;
    elseif strcmp(MCNP.TieTubeCell{kkk}.Type,'poisoned');
        Materialspec=MCNP.Material.poisoned;
        Nparts=MCNP.Burnup.Poisoned_TieTube_Number;
        type = 2;
    else
        error('not a fuel type')
    end
    
    %In_cool
    fprintf(fileID,'mat %i %.6f tmp %i \n',Tietubespecs.In_Cool.Cell_Number, ...
        Tietubespecs.In_Cool.Density,Tietubespecs.In_Cool.Temp);
    fprintf(fileID,Materialspec.In_Cool.Material_String);
    if isfield(Materialspec.In_Cool,'Material_SAB_String');
        fprintf(fileID,'therm h%i ', Tietubespecs.In_Cool.Cell_Number);
        fprintf(fileID,Materialspec.In_Cool.Material_SAB_String);
    end
    
    %In_Metal
    if MCNP.Burnup.In_Metal_Poisoned==1 || MCNP.Burnup.In_Metal_Normal==1
        fprintf(fileID,'mat %i %.6f vol %.6f tmp %i burn 1\n',Tietubespecs.In_Metal.Cell_Number, ...
            Tietubespecs.In_Metal.Density,MCNP.TieTubeCell{type}.In_Metal.Mat_Areas*Nparts*20, Tietubespecs.In_Metal.Temp);
    else
        fprintf(fileID,'mat %i %.6f tmp %i \n',Tietubespecs.In_Metal.Cell_Number, ...
            Tietubespecs.In_Metal.Density, Tietubespecs.In_Metal.Temp);
    end
    fprintf(fileID,Materialspec.In_Metal.Material_String);
    if isfield(Materialspec.In_Metal,'Material_SAB_String');
        fprintf(fileID,'mt%i ', Tietubespecs.In_Metal.Cell_Number);
        fprintf(fileID,Materialspec.In_Metal.Material_SAB_String);
    end
    
    
    %Moderator
    % there are issues with the ZrH s(a,b) implementation in serpent ->
    % have removed it from the input writer
    if MCNP.Burnup.Moderator_Poisoned==1 || MCNP.Burnup.Moderator_Normal==1
        fprintf(fileID,'mat %i  %.6f vol %.6f moder hzr%i 1001 moder zrh%i 40094 tmp %i burn 1\n',Tietubespecs.Moderator.Cell_Number, ...
            Tietubespecs.Moderator.Density,MCNP.TieTubeCell{type}.Moderator.Mat_Areas*Nparts*20, ...
            Tietubespecs.Moderator.Cell_Number,Tietubespecs.Moderator.Cell_Number,Tietubespecs.Moderator.Temp);
    else
        fprintf(fileID,'mat %i  %.6f moder hzr%i 1001 moder zrh%i 40094 tmp %i \n',Tietubespecs.Moderator.Cell_Number, ...
            Tietubespecs.Moderator.Density,Tietubespecs.Moderator.Cell_Number,Tietubespecs.Moderator.Cell_Number, Tietubespecs.Moderator.Temp);
    end
    fprintf(fileID,Materialspec.Moderator.Material_String);
    if isfield(Materialspec.Moderator,'Material_SAB_String1');
        fprintf(fileID,'therm hzr%i ', Tietubespecs.Moderator.Cell_Number);
        fprintf(fileID,Materialspec.Moderator.Material_SAB_String1);
    end
    if isfield(Materialspec.Moderator,'Material_SAB_String2');
        fprintf(fileID,'therm zrh%i ', Tietubespecs.Moderator.Cell_Number);
        fprintf(fileID,Materialspec.Moderator.Material_SAB_String2);
    end
    
    %Out_Cool
    fprintf(fileID,'mat %i %.6f  tmp %i \n',Tietubespecs.Out_Cool.Cell_Number, ...
        Tietubespecs.Out_Cool.Density,Tietubespecs.Out_Cool.Temp);
    fprintf(fileID,Materialspec.Out_Cool.Material_String);
    if isfield(Materialspec.Out_Cool,'Material_SAB_String');
        fprintf(fileID,'therm h%i ', Tietubespecs.Out_Cool.Cell_Number);
        fprintf(fileID,Materialspec.Out_Cool.Material_SAB_String);
    end
    
    
    %Out_Metal
    if MCNP.Burnup.Out_Metal_Poisoned==1 || MCNP.Burnup.Out_Metal_Normal==1
        fprintf(fileID,'mat %i %.6f vol %.6f tmp %i burn 1\n',Tietubespecs.Out_Metal.Cell_Number, ...
            Tietubespecs.Out_Metal.Density,MCNP.TieTubeCell{type}.Out_Metal.Mat_Areas*Nparts*20,Tietubespecs.Out_Metal.Temp );
    else
        fprintf(fileID,'mat %i %.6f tmp %i \n',Tietubespecs.Out_Metal.Cell_Number, ...
            Tietubespecs.Out_Metal.Density,Tietubespecs.Out_Metal.Temp );
    end
    fprintf(fileID,Materialspec.Out_Metal.Material_String);
    if isfield(Materialspec.Out_Metal,'Material_SAB_String');
        fprintf(fileID,'therm %i ', Tietubespecs.Out_Metal.Cell_Number);
        fprintf(fileID,Materialspec.Out_Metal.Material_SAB_String);
    end
    
    
    %In_Insulator
    if MCNP.Burnup.Out_Insulator_Poisoned==1 || MCNP.Burnup.Out_Insulator_Normal==1
        fprintf(fileID,'mat %i %.6f vol %.6f tmp %i burn 1\n',Tietubespecs.In_Insulator.Cell_Number, ...
            Tietubespecs.In_Insulator.Density,MCNP.TieTubeCell{type}.Out_Insulator.Mat_Areas*Nparts*20,Tietubespecs.In_Insulator.Temp);
    else
        fprintf(fileID,'mat %i %.6f tmp %i \n',Tietubespecs.In_Insulator.Cell_Number, ...
            Tietubespecs.In_Insulator.Density,Tietubespecs.In_Insulator.Temp);
    end
    fprintf(fileID,Materialspec.In_Insulator.Material_String);
    if isfield(Materialspec.In_Insulator,'Material_SAB_String');
        fprintf(fileID,'therm zrc%  ', Tietubespecs.In_Insulator.Cell_Number);
        fprintf(fileID,Materialspec.In_Insulator.Material_SAB_String);
    end
    
    %Out_Insulator
    if MCNP.fuel.type == 1
        if MCNP.Burnup.In_Insulator_Poisoned==1 || MCNP.Burnup.In_Insulator_Normal==1
            fprintf(fileID,'mat %i %.6f vol %.6f  tmp %i burn 1 \n',Tietubespecs.Out_Insulator.Cell_Number, ...
                Tietubespecs.Out_Insulator.Density,MCNP.TieTubeCell{type}.In_Insulator.Mat_Areas*Nparts*20,Tietubespecs.Out_Insulator.Temp);
        else
            fprintf(fileID,'mat %i %.6f  tmp %i \n',Tietubespecs.Out_Insulator.Cell_Number, ...
                Tietubespecs.Out_Insulator.Density,Tietubespecs.Out_Insulator.Temp);
        end
        fprintf(fileID,Materialspec.Out_Insulator.Material_String);
        if isfield(Materialspec.Out_Insulator,'Material_SAB_String');
            fprintf(fileID,'therm graph%i ', Tietubespecs.Out_Insulator.Cell_Number);
            fprintf(fileID,Materialspec.Out_Insulator.Material_SAB_String);
        end
    elseif MCNP.fuel.type == 2
        if MCNP.Burnup.In_Insulator_Poisoned==1 || MCNP.Burnup.In_Insulator_Normal==1
            fprintf(fileID,'mat %i %.6f vol %.6f moder graph_%i 6000 tmp %i burn 1 \n',Tietubespecs.Out_Insulator.Cell_Number, ...
                Tietubespecs.Out_Insulator.Density,MCNP.TieTubeCell{type}.In_Insulator.Mat_Areas*Nparts*20,Tietubespecs.Out_Insulator.Cell_Number,Tietubespecs.Out_Insulator.Temp);
        else
            fprintf(fileID,'mat %i %.6f moder graph_%i 6000 tmp %i \n',Tietubespecs.Out_Insulator.Cell_Number, ...
                Tietubespecs.Out_Insulator.Density,Tietubespecs.Out_Insulator.Cell_Number,Tietubespecs.Out_Insulator.Temp);
        end
        fprintf(fileID,Materialspec.Out_Insulator.Material_String);
        if isfield(Materialspec.Out_Insulator,'Material_SAB_String');
            fprintf(fileID,'therm graph_%i ', Tietubespecs.Out_Insulator.Cell_Number);
            fprintf(fileID,Materialspec.Out_Insulator.Material_SAB_String);
        end
    else
        error('not a valid fuel option');
    end
    
    
    
end

