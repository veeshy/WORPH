function [] = WORPH_MCNP_Fuel_Cells(fileID,MCNP,geom)


for kkk = 1:length(MCNP.FuelCell)
    
    Fuelspec=MCNP.FuelCell{kkk}.Fuel;
    In_Cladspec=MCNP.FuelCell{kkk}.In_Clad;
    Out_Cladspec=MCNP.FuelCell{kkk}.Out_Clad;
    Coolantspec=MCNP.FuelCell{kkk}.Coolant;
    
    
    if strcmp(MCNP.FuelCell{kkk}.Type,'normal')
        Hex_Size=geom.Hex_Size;
        Fuelgeom=geom;
        
    elseif strcmp(MCNP.FuelCell{kkk}.Type,'poisoned')
        Hex_Size=geom.poisoned.Hex_Size;
        Fuelgeom=geom.poisoned;
        
    else
        error('not a fuel type')
    end
    
    
    [edge_nums,corner_nums] = edge_and_corner_numbers(Hex_Size);
    
    % cells for outside clad both pointed and nonpointed
    if strcmp(Fuelgeom.Hex_Corner,'rounded') || strcmp(Fuelgeom.Hex_Corner,'Rounded');
        fprintf(fileID,'%% outside clad rounded \n');
        fprintf(fileID,'cell %i %i %i -%i (-%i %i):(%i ',Out_Cladspec.Out_Clad_Cell_Number, ...
            MCNP.FuelCell{kkk}.Universe, Out_Cladspec.Out_Clad_Cell_Number,Out_Cladspec.Outside_Plane_Number, ...
            Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number,Out_Cladspec.Fuel_Plane_Number, ...
            Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number);
        
        for kk =1:6
            fprintf(fileID,'%i ',Out_Cladspec.Rounded_Planes_Circles_Number{kk});
        end
        fprintf(fileID,') \n');
    elseif strcmp(Fuelgeom.Hex_Corner,'pointed') || strcmp(Fuelgeom.Hex_Corner,'Pointed')
        fprintf(fileID,'%% outside clad pointed \n');
        fprintf(fileID,'cell %i %i %i %i \n',Out_Cladspec.Out_Clad_Cell_Number, ...
            MCNP.FuelCell{kkk}.Universe, Out_Cladspec.Out_Clad_Cell_Number, ...
            Out_Cladspec.Fuel_Plane_Number);
        
    end
    
    
    %fuel meat
    for kk=1:length(Fuelspec.Cell_Number)
        
        
        if 0 < sum(kk==corner_nums) %% if it is in a corner it needs to round out the endge
            if strcmp(Fuelgeom.Hex_Corner,'rounded') || strcmp(Fuelgeom.Hex_Corner,'Rounded')
                fprintf(fileID,'%% fuel corners rounded \n');
                fprintf(fileID,'cell %i %i %i -%i %i (',Fuelspec.Cell_Number{kk},MCNP.FuelCell{kkk}.Universe, ...
                    Fuelspec.Mat_Number(kk),Out_Cladspec.Fuel_Plane_Number,In_Cladspec.Fuel_Plane_Number{kk});
                for qq=1:length(Fuelspec.Cell_Specs{kk})
                    fprintf(fileID,' %i',Fuelspec.Cell_Specs{kk}(qq));
                end
                fprintf(fileID,' -%i):',Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number);
                fprintf(fileID,'(%i -%i)\n',Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number,Out_Cladspec.Rounded_Planes_Circles_Number{kk==corner_nums});
                
                % all other edges
                
            elseif strcmp(Fuelgeom.Hex_Corner,'pointed') || strcmp(Fuelgeom.Hex_Corner,'Pointed')
                fprintf(fileID,'%% fuel corners pointed \n');
                fprintf(fileID,'cell  %i %i %i -%i %i (',Fuelspec.Cell_Number{kk},MCNP.FuelCell{kkk}.Universe, ...
                    Fuelspec.Mat_Number(kk),Out_Cladspec.Fuel_Plane_Number,In_Cladspec.Fuel_Plane_Number{kk});
                for qq=1:length(Fuelspec.Cell_Specs{kk})
                    fprintf(fileID,' %i',Fuelspec.Cell_Specs{kk}(qq));
                end
                fprintf(fileID,' ) \n');
            else
                error('edge type not supported')
            end
            
            
        else
            fprintf(fileID,'%% fuel \n');
            fprintf(fileID,'cell %i %i %i -%i %i',Fuelspec.Cell_Number{kk},MCNP.FuelCell{kkk}.Universe, ...
                Fuelspec.Mat_Number(kk),Out_Cladspec.Fuel_Plane_Number,In_Cladspec.Fuel_Plane_Number{kk});
            for qq=1:length(Fuelspec.Cell_Specs{kk})
                fprintf(fileID,' %i',Fuelspec.Cell_Specs{kk}(qq));
            end
            fprintf(fileID,' \n');
        end
    end
    
    %clad inside channels
    fprintf(fileID,'%% fuel clad channel \n');
    for kk=1:length(In_Cladspec.Fuel_Plane_Number)
        fprintf(fileID,'cell %i %i %i %i -%i \n',In_Cladspec.Cell_Number{kk},MCNP.FuelCell{kkk}.Universe, ...
            In_Cladspec.Mat_Number(kk), In_Cladspec.Coolant_Plane_Number{kk},In_Cladspec.Fuel_Plane_Number{kk});
    end
    
    
    %Coolant
    fprintf(fileID,'%% channel \n');
    for kk=1:length(Coolantspec.Cell_Number)
        fprintf(fileID,'cell %i %i %i -%i \n',Coolantspec.Cell_Number{kk},MCNP.FuelCell{kkk}.Universe,Coolantspec.Cell_Number{kk},In_Cladspec.Coolant_Plane_Number{kk});
    end
    
end
end
