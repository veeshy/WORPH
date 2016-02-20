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
            ccounter=15;
            cc=fprintf(fileID,'%i %i %.6f -%i',Out_Cladspec.Out_Clad_Cell_Number,Out_Cladspec.Out_Clad_Cell_Number,Out_Cladspec.Density,Out_Cladspec.Outside_Plane_Number);
            ccounter=ccounter+cc;
            cc=fprintf(fileID,'(-%i %i):(%i ',Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number,Out_Cladspec.Fuel_Plane_Number,Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number);
            ccounter=ccounter+cc;


            %rounded endeges
             for kk =1:6
             if ccounter > 60
                 %make sure we do no go over 80 char limit
            cc=fprintf(fileID,' & \n');
            ccounter=10;
             end
             fprintf(fileID,'%i ',Out_Cladspec.Rounded_Planes_Circles_Number{kk});
             end
             fprintf(fileID,') ');
             fprintf(fileID,' & \n');
             fprintf(fileID,'imp:n=1 u=%i tmp=%.6e \n',MCNP.FuelCell{kkk}.Universe,Out_Cladspec.Temp);
 
              elseif strcmp(Fuelgeom.Hex_Corner,'pointed') || strcmp(Fuelgeom.Hex_Corner,'Pointed')
            
              fprintf(fileID,'%i %i %.6f ',Out_Cladspec.Out_Clad_Cell_Number,Out_Cladspec.Out_Clad_Cell_Number,Out_Cladspec.Density);
              fprintf(fileID,'-%i %i',Out_Cladspec.Outside_Plane_Number,Out_Cladspec.Fuel_Plane_Number);
               fprintf(fileID,' & \n');
              fprintf(fileID,'imp:n=1 u=%i tmp=%.6e \n',MCNP.FuelCell{kkk}.Universe,Out_Cladspec.Temp);
              end
 
 %Graveyard
fprintf(fileID,'%i 0 %i ',Out_Cladspec.Graveyard,Out_Cladspec.Outside_Plane_Number);
fprintf(fileID,'imp:n=0 u=%i \n',MCNP.FuelCell{kkk}.Universe);



%fuel meat
for kk=1:length(Fuelspec.Cell_Number)
    
    
    if 0 < sum(kk==corner_nums) %% if it is in a corner it needs to round out the endge
              if strcmp(Fuelgeom.Hex_Corner,'rounded') || strcmp(Fuelgeom.Hex_Corner,'Rounded')
                  
            fprintf(fileID,'%i %i %.6f -%i %i (',Fuelspec.Cell_Number{kk},Fuelspec.Mat_Number(kk),Fuelspec.Density,Out_Cladspec.Fuel_Plane_Number,In_Cladspec.Fuel_Plane_Number{kk});
          for qq=1:length(Fuelspec.Cell_Specs{kk})
          fprintf(fileID,' %i',Fuelspec.Cell_Specs{kk}(qq));
          end
        fprintf(fileID,' -%i):',Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number);
        fprintf(fileID,'(%i -%i)',Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number,Out_Cladspec.Rounded_Planes_Circles_Number{kk==corner_nums});
        fprintf(fileID,' & \n');
        fprintf(fileID,'imp:n=1 u=%i tmp=%.6e vol=1\n',MCNP.FuelCell{kkk}.Universe,Fuelspec.Temp);
    % all other endeges
    
              elseif strcmp(Fuelgeom.Hex_Corner,'pointed') || strcmp(Fuelgeom.Hex_Corner,'Pointed')
                  
          fprintf(fileID,'%i %i %.6f -%i %i (',Fuelspec.Cell_Number{kk},Fuelspec.Mat_Number(kk),Fuelspec.Density,Out_Cladspec.Fuel_Plane_Number,In_Cladspec.Fuel_Plane_Number{kk});
          for qq=1:length(Fuelspec.Cell_Specs{kk})
          fprintf(fileID,' %i',Fuelspec.Cell_Specs{kk}(qq));
          end
        fprintf(fileID,' )');
        fprintf(fileID,' & \n');
        fprintf(fileID,'imp:n=1 u=%i tmp=%.6e vol=1\n',MCNP.FuelCell{kkk}.Universe,Fuelspec.Temp);
              else
                  error('edge type not supported')
              end
                  
                  
    else
        
      fprintf(fileID,'%i %i %.6f -%i %i',Fuelspec.Cell_Number{kk},Fuelspec.Mat_Number(kk),Fuelspec.Density,Out_Cladspec.Fuel_Plane_Number,In_Cladspec.Fuel_Plane_Number{kk});
       for qq=1:length(Fuelspec.Cell_Specs{kk})
      fprintf(fileID,' %i',Fuelspec.Cell_Specs{kk}(qq));
       end
       fprintf(fileID,' & \n');
       fprintf(fileID,'imp:n=1 u=%i tmp=%.6e vol=1\n',MCNP.FuelCell{kkk}.Universe,Fuelspec.Temp);
    end
end 

%clad inside channels
for kk=1:length(In_Cladspec.Fuel_Plane_Number)
    fprintf(fileID,'%i %i %.6f %i -%i',In_Cladspec.Cell_Number{kk},In_Cladspec.Mat_Number(kk),In_Cladspec.Density,In_Cladspec.Coolant_Plane_Number{kk},In_Cladspec.Fuel_Plane_Number{kk});
    fprintf(fileID,' & \n');
    fprintf(fileID,'imp:n=1 u=%i tmp=%.6e vol=1\n',MCNP.FuelCell{kkk}.Universe,In_Cladspec.Temp);
end


%Coolant
for kk=1:length(Coolantspec.Cell_Number)
    fprintf(fileID,'%i %i %.6f -%i',Coolantspec.Cell_Number{kk},Coolantspec.Cell_Number{kk},Coolantspec.Density,In_Cladspec.Coolant_Plane_Number{kk});
    fprintf(fileID,' & \n');
    fprintf(fileID,'imp:n=1 u=%i tmp=%.6e vol=1\n',MCNP.FuelCell{kkk}.Universe,In_Cladspec.Temp);
end

end
end
