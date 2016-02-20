function [] = Write_MCNP_Fuel_Mats(MCNP,fileID)

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
      fprintf(fileID,'m%i ',Out_Cladspec.Out_Clad_Cell_Number);
      fprintf(fileID,Materialspec.Out_Clad.Material_String);
        if isfield(Materialspec.Out_Clad,'Material_SAB_String')
          fprintf(fileID,'mt%i ', Out_Cladspec.Cell_Number);
          fprintf(fileID,Materialspec.Out_Clad.Material_SAB_String);
        end  

%In Clad
  Mat_Num=unique(In_Cladspec.Mat_Number);
for kk=1:length(Mat_Num)
      fprintf(fileID,'m%i ',  Mat_Num(kk))
      fprintf(fileID,Materialspec.In_Clad.Material_String);
        if isfield(Materialspec.In_Clad,'Material_SAB_String')
          fprintf(fileID,'mt%i ',  Mat_Num(kk));
          fprintf(fileID,Materialspec.In_Clad.Material_SAB_String);
        end  
end

%Fuel coolant
for kk=1:length(Coolantspec.Cell_Number)
      fprintf(fileID,'m%i ', Coolantspec.Cell_Number{kk});
      fprintf(fileID,Materialspec.Coolant.Material_String);
        if isfield(Materialspec.Coolant,'Material_SAB_String')
          fprintf(fileID,'mt%i ' ,Coolantspec.Cell_Number{kk});
          fprintf(fileID,Materialspec.Coolant.Material_SAB_String);
        end  
end
    

%fuel

  Mat_Num=unique(Fuelspec.Mat_Number);
for kk=1:length(unique(Fuelspec.Mat_Number))
      fprintf(fileID,'m%i ' ,Mat_Num(kk));
      fprintf(fileID,Materialspec.Fuel.Material_String);
        if isfield(Materialspec.Fuel,'Material_SAB_String')
          fprintf(fileID,'mt%i ', Mat_Num(kk));
          fprintf(fileID,Materialspec.Fuel.Material_SAB_String);
        end  
end
   

end

