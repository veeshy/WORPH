function [] = Write_MCNP_Tietube_Mats(MCNP,fileID)

for kkk = 1:length(MCNP.TieTubeCell)
    
Tietubespecs=MCNP.TieTubeCell{kkk}

if strcmp(MCNP.TieTubeCell{kkk}.Type,'normal')
Materialspec=MCNP.Material.normal;
    
elseif strcmp(MCNP.TieTubeCell{kkk}.Type,'poisoned')
Materialspec=MCNP.Material.poisoned;
    
else 
    error('not a fuel type')
end 

%In_cool 
fprintf(fileID,'m%i ',Tietubespecs.In_Cool.Cell_Number)
fprintf(fileID,Materialspec.In_Cool.Material_String)
        if isfield(Materialspec.In_Cool,'Material_SAB_String')
          fprintf(fileID,'mt%i ', Tietubespecs.In_Cool.Cell_Number);
          fprintf(fileID,Materialspec.In_Cool.Material_SAB_String);
        end  
        
%In_Metal
fprintf(fileID,'m%i ',Tietubespecs.In_Metal.Cell_Number)
fprintf(fileID,Materialspec.In_Metal.Material_String)
        if isfield(Materialspec.In_Metal,'Material_SAB_String')
          fprintf(fileID,'mt%i ', Tietubespecs.In_Metal.Cell_Number);
          fprintf(fileID,Materialspec.In_Metal.Material_SAB_String);
        end  


%Moderator
fprintf(fileID,'m%i ',Tietubespecs.Moderator.Cell_Number)
fprintf(fileID,Materialspec.Moderator.Material_String)
        if isfield(Materialspec.Moderator,'Material_SAB_String')
          fprintf(fileID,'mt%i ', Tietubespecs.Moderator.Cell_Number);
          fprintf(fileID,Materialspec.Moderator.Material_SAB_String);
        end  

%Out_Cool
fprintf(fileID,'m%i ',Tietubespecs.Out_Cool.Cell_Number)
fprintf(fileID,Materialspec.Out_Cool.Material_String)
        if isfield(Materialspec.Out_Cool,'Material_SAB_String')
          fprintf(fileID,'mt%i ', Tietubespecs.Out_Cool.Cell_Number);
          fprintf(fileID,Materialspec.Out_Cool.Material_SAB_String);
        end  
        
        
%Out_Metal
fprintf(fileID,'m%i ',Tietubespecs.Out_Metal.Cell_Number)
fprintf(fileID,Materialspec.Out_Metal.Material_String)
        if isfield(Materialspec.Out_Metal,'Material_SAB_String')
          fprintf(fileID,'mt%i ', Tietubespecs.Out_Metal.Cell_Number);
          fprintf(fileID,Materialspec.Out_Metal.Material_SAB_String);
        end  
    

%In_Insulator
fprintf(fileID,'m%i ',Tietubespecs.In_Insulator.Cell_Number)
fprintf(fileID,Materialspec.In_Insulator.Material_String)
        if isfield(Materialspec.In_Insulator,'Material_SAB_String')
          fprintf(fileID,'mt%i ', Tietubespecs.In_Insulator.Cell_Number);
          fprintf(fileID,Materialspec.In_Insulator.Material_SAB_String);
        end 

%Out_Insulator
fprintf(fileID,'m%i ',Tietubespecs.Out_Insulator.Cell_Number)
fprintf(fileID,Materialspec.Out_Insulator.Material_String)
        if isfield(Materialspec.Out_Insulator,'Material_SAB_String')
          fprintf(fileID,'mt%i ', Tietubespecs.Out_Insulator.Cell_Number);
          fprintf(fileID,Materialspec.Out_Insulator.Material_SAB_String);
        end 
        


end

